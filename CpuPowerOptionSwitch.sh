#!/bin/bash
#watch -n 0 "lscpu | grep 'MHz'"

state=$( cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor )
newState=""
stringState="Now in *** "
echo "	            The current state is [ $state ]"
if [ $state == "powersave" ] 
then
    sudo cpupower frequency-set -g performance
    newState=$( cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor )	
else
    sudo -i cpupower frequency-set -g powersave
    newState=$( cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor )
fi
#watch -n 0 "lscpu | grep 'MHz'"
echo "			Now in *** $newState ***mode"
sleep 10s
