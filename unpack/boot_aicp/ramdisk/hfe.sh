#!/system/bin/sh

(while true; do

if [ wake=`cat /sys/power/wait_for_fb_sleep` ]; then
    HFE=`settings get system haptic_feedback_enabled`
    if [ "$HFE" -ne "0" ]; then
        settings put system haptic_feedback_enabled 0
    fi
fi
if [ wake=`cat /sys/power/wait_for_fb_wake` ]; then 
    if [ "$HFE" -eq "1" ]; then
        settings put system haptic_feedback_enabled 1
    fi
fi

done &)
