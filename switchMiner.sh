#!/bin/bash
HOMEDIR=$HOME/scripts
PHOENIXCRON=cronJobs/phoenixCron.crj
NANOMINERCRON=cronJobs/nanominerCron.crj
LOLMINERCRON=cronJobs/lolminerCron.crj
DISABLEDCRON=cronJobs/disabledCron.crj


usage () {

  echo " "
  echo " Script Usage "
  echo "    sh switchMiner.sh (eth|etc|rvn|stop) "
  echo " "
  exit 1

}

phoenixToggle () {
    sudo systemctl stop lolminer.service
    sudo systemctl disable lolminer.service
    echo -e "lolminer stopped \nlolminer daemon disabled"
    sudo systemctl stop nanominer.service
    sudo systemctl disable nanominer.service
    echo -e "nanominer stopped \nnanominer daemon disabled"
    sudo systemctl enable phoenix.service
    sudo systemctl start phoenix.service
    echo -e "Phoenix started \ndaemon enabled"
    echo "setting phoenix cronTab"
    crontab $PHOENIXCRON
    crontab -l

}

nanominerToggle () {
    sudo systemctl stop lolminer.service
    sudo systemctl disable lolminer.service
    echo -e "lolminer stopped \nlolminer daemon disabled"
    sudo systemctl stop phoenix.service
    sudo systemctl disable phoenix.service
    echo -e "phoenix stopped \nphoenix daemon disabled"
    sudo systemctl enable nanominer.service
    sudo systemctl start nanominer.service
    echo -e "nanominer started \ndaemon enabled"
    echo "setting nanominer cronTab"
    crontab $NANOMINERCRON
    crontab -l

}

lolminerToggle () {
    sudo systemctl stop phoenix.service
    sudo systemctl disable phoenix.service
    echo -e "phoenix stopped \nphoenix daemon disabled"
    sudo systemctl stop nanominer.service
    sudo systemctl disable nanominer.service
    echo -e "nanominer stopped \nnanominer daemon disabled"
    sudo systemctl enable lolminer.service
    sudo systemctl start lolminer.service
    echo -e "lolminer started \ndaemon enabled"
    echo "setting lolminer cronTab"
    crontab $LOLMINERCRON
    crontab -l
}

allStop () {
    sudo systemctl stop phoenix.service
    sudo systemctl disable phoenix.service
    echo -e "phoenix stopped \nphoenix daemon disabled"
    sudo systemctl stop nanominer.service
    sudo systemctl disable nanominer.service
    echo -e "nanominer stopped \nnanominer daemon disabled"
    sudo systemctl stop lolminer.service
    sudo systemctl disable lolminer.service
    echo -e "lolminer stopped \nlolminer daemon disabled"
    crontab $DISABLEDCRON
    crontab -l 
} 
if [ $# -ne 1 ]; then
    usage
    exit 1;
else
    case $1 in
        [Ee][Tt][Hh])
            phoenixToggle
            ;;
        [Rr][Vv][Nn])
            nanominerToggle
            ;;
	[Ee][Tt][Cc])
	    lolminerToggle
	    ;;
    [Ss][Tt][Oo][Pp])
	    allStop
	    ;;
        *) echo "******************************************************************"
           echo "${0}: Invalid option found on command line: ${OPTARG}"
           echo "******************************************************************"
           usage
           break
           ;;
    esac
fi
