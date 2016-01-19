#!/system/bin/sh

(while true; do

if [ wake=`cat /sys/power/wait_for_fb_sleep` ]; then
    HFE=`content query --uri content://settings/system --projection name:value --where "name='haptic_feedback_enabled'" | rev | cut -c1-1 | rev`
    if [ "$HFE" -ne "0" ]; then
        content insert --uri content://settings/system --bind name:s:haptic_feedback_enabled --bind value:i:0
    fi
fi
if [ wake=`cat /sys/power/wait_for_fb_wake` ]; then 
    if [ "$HFE" -eq "1" ]; then
        content insert --uri content://settings/system --bind name:s:haptic_feedback_enabled --bind value:i:1
    fi
fi

done &)
