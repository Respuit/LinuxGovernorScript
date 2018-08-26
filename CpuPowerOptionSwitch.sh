#!/bin/bash
# You may Use this to inspect cpu clockage live:
#  watch -n 0 "lscpu | grep 'MHz'"

state=$( cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor )
newState=""
echo -e "\tThe current state is [ $state ]"
if [ $state != "performance" ] 
then
    sudo -i cpupower frequency-set -g performance >/dev/null
    echo "$state" > /tmp/CpuPowerOptionSwitch.state
    newState=$( cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor )
else
    if [ ! -f /tmp/CpuPowerOptionSwitch.state ]; then
        echo -e "\tCPU scaling already set to performance."
        echo -e "\tCouldn't find a previously recorded state."
        exit 1
    fi
    prevState=$( cat /tmp/CpuPowerOptionSwitch.state )
    sudo cpupower frequency-set -g "$prevState" >/dev/null
    newState=$( cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor )	
fi
echo -e "\tNow in *** $newState *** mode"
