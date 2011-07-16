#!/bin/bash
# Engages suspend when battery state reaches critical levels.

# Requires: acpi, pm-utils, NOPASSWD exception for pm-suspend in sudoers

PERCENTAGE=$(acpi | awk '{ print $4 }' | sed s/,// | sed s/%//)
AC=$(cat /proc/acpi/ac_adapter/C1F2/state | awk '{ print $2 }')

main(){
if (( $PERCENTAGE <= 3 )); then
	if [ $AC = "off-line" ]; then 
	wall -n 'BATTERY LEVEL CRITICAL - SLEEPING TO PREVENT LOSS OF WORK'
	echo 'BATTERY LEVEL CRITICAL - SLEEPING TO PREVENT LOSS OF WORK' && sleep 2 && sleeptime
	fi
fi
}

sleeptime(){
sudo pm-suspend
}

main
