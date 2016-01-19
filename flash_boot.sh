#!/bin/bash
if
adb devices | grep recovery > /dev/null
then
  if
  cd ~/kernel-3.10/unpack/boot_aosp
  then
    if
    adb push boot.img /sdcard/boot.img
    then
      if
      adb shell dd if=/sdcard/boot.img of=/dev/block/mmcblk0p7
      then
        adb shell reboot
      fi
    fi
  fi
else
  if
  cd ~/kernel-3.10/unpack/boot_aosp
  then
    if
    adb push boot.img /sdcard/boot.img
    then
      if
      adb shell su -c dd if=/sdcard/boot.img of=/dev/block/mmcblk0p7
      then
        adb shell su -c reboot
      fi
    fi
  fi
fi
cd
