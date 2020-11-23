#!/bin/bash

[[ "$UID" != "0" ]] && {
    echo "This script must be ran as root"
    exit 1
}

[[ $# -lt 2 ]] && {
    echo "Missing command line arguments"
    exit 1
}

function install_package {
    if command -v apt &>/dev/null; then
        MANAGER="apt -y -qq"
        ${MANAGER} update
    else
        MANAGER="yum -yq"
    fi
    ${MANAGER} install ${1} > /dev/null 2>&1
}

SERVICE_NAME="foreman"
SERVICE_GIST="https://gist.githubusercontent.com/delawr0190/0a81fb2f66633b14dfd47703fcb9a4f1/raw/service.sh"

[ $SUDO_USER ] && FOREMAN_USER=$SUDO_USER || FOREMAN_USER=`whoami`
FOREMAN_HOME=/opt/foreman
FOREMAN_CLIENT_ID=${1}
FOREMAN_API_KEY=${2}
FOREMAN_PICKAXE_ID=${3:-$(uuidgen)}

# Remove any existing Foreman services
[[ -f /etc/systemd/system/${SERVICE_NAME}.service ]] && {
    echo "Removing existing Foreman service..."
    systemctl stop ${SERVICE_NAME} 2> /dev/null
    systemctl disable ${SERVICE_NAME} 2> /dev/null
    rm /etc/systemd/system/${SERVICE_NAME}.service 2> /dev/null
    rm /etc/systemd/system/multi-user.target.wants/${SERVICE_NAME}.service 2> /dev/null
    systemctl daemon-reload
    systemctl reset-failed
}

# Remove Foreman directory if it exists
[[ -d ${FOREMAN_HOME} ]] && {
    echo "Found ${FOREMAN_HOME} - removing..."
    pkill -f 'java.*pickaxe.Main'
    pkill -f 'java.*chisel.*'
    EXISTING_ID=$(grep -iR "pickaxeId" ${FOREMAN_HOME}/pickaxe/conf/pickaxe.yml | cut -d':' -f2 | tr -d '[:space:]' | tr -d '"')
    [[ ! -z $EXISTING_ID ]] && {
        FOREMAN_PICKAXE_ID=$EXISTING_ID
    }
    rm -rf ${FOREMAN_HOME}
}
mkdir ${FOREMAN_HOME}
chown -R ${FOREMAN_USER}:${FOREMAN_USER} ${FOREMAN_HOME}

# Services will need jq, wget, and unzip
type jq >/dev/null 2>&1 || {
    echo "Installing jq"
    install_package jq
}
type wget >/dev/null 2>&1 || {
    echo "Installing wget"
    install_package wget
}
type unzip >/dev/null 2>&1 || {
    echo "Installing unzip"
    install_package unzip
}

# Get the latest Foreman service script
wget --no-check-certificate ${SERVICE_GIST} -q -O ${FOREMAN_HOME}/service.sh
chmod +x ${FOREMAN_HOME}/service.sh
chown ${FOREMAN_USER}:${FOREMAN_USER} ${FOREMAN_HOME}/service.sh

# Make new Foreman service
tee -a /etc/systemd/system/${SERVICE_NAME}.service << END
[Unit]
Description=Foreman
After=network.target

[Service]
Type=simple
Restart=always
RestartSec=10
ExecStart=${FOREMAN_HOME}/service.sh ${FOREMAN_HOME} ${FOREMAN_CLIENT_ID} ${FOREMAN_API_KEY} ${FOREMAN_PICKAXE_ID}

[Install]
WantedBy=multi-user.target
END

# Start the service
systemctl enable ${SERVICE_NAME}
systemctl start ${SERVICE_NAME}