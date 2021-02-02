#!/bin/bash
PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin


if pgrep -x python > /dev/null
then
        echo "Monitor is running"
	date +"%D %T Monitor is running" >> /home/ethos/monitorCheck/monitorLog.log
else
	echo "Monitor found not running"
	echo "launching Monitor"
	date +"%D %T No monitor found running Launching monitor" >> /home/ethos/monitorCheck/monitorLog.log
        python /home/ethos/monitorCheck/monitor.py c44e8e "http://markcp.ethosdistro.com/?json=yes"
fi
