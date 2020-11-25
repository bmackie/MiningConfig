#!/bin/bash

usage () {
    
    echo " "
    echo " Script Usage "
    echo "    sh toggleOverclock.sh (enable|Disable) "
    echo " "
    exit 1
}

enableOverclock () {
sudo systemctl enable core1.service
sudo systemctl enable core2.service
sudo systemctl enable core3.service
sudo systemctl enable core4.service
sudo systemctl enable core5.service
sudo systemctl enable core6.service
sudo systemctl enable core7.service
sudo systemctl enable mem2.service
sudo systemctl enable core1card2.service
sudo systemctl enable core2card2.service
sudo systemctl enable core3card2.service
sudo systemctl enable core4card2.service
sudo systemctl enable core5card2.service
sudo systemctl enable core6card2.service
sudo systemctl enable core7card2.service
sudo systemctl enable mem2card2.service
sudo systemctl enable applyoc.service
}

disableOverclock () {
sudo systemctl disable core1.service
sudo systemctl disable core2.service
sudo systemctl disable core3.service
sudo systemctl disable core4.service
sudo systemctl disable core5.service
sudo systemctl disable core6.service
sudo systemctl disable core7.service
sudo systemctl disable mem2.service
sudo systemctl disable core1card2.service
sudo systemctl disable core2card2.service
sudo systemctl disable core3card2.service
sudo systemctl disable core4card2.service
sudo systemctl disable core5card2.service
sudo systemctl disable core6card2.service
sudo systemctl disable core7card2.service
sudo systemctl disable mem2card2.service
sudo systemctl disable applyoc.service
}



if [ $# -ne 1 ]; then
    usage
    exit 1;
else
    case $1 in
        [Ee][Nn][Aa][Bb][Ll][Ee])
            enableOverclock
	    ;;
        [Dd][Ii][Ss][Aa][Bb][Ll][Ee])
	    disableOverclock
	    ;;
	*) echo "******************************************************************"
           echo "${0}: Invalid option found on command line: ${OPTARG}"
	   echo "******************************************************************"
	   usage
	   break
	   ;;
    esac
fi
