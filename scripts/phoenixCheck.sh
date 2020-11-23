#!/bin/bash
PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin


if pgrep -x PhoenixMiner > /dev/null
then
        echo "Miner is running"
else
        date +"%D %T daemon caught miner not running rebooting" >> ~/minerLogs/restart.log
        echo "Miner is not running"
	sudo reboot
fi
