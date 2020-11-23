#!/bin/bash
cat working > /home/bdc/test.txt
sudo sh -c echo 's 1 600 769' > /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/pp_od_clk_voltage
