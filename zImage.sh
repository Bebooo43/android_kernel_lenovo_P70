#!/bin/bash
if cd ~/kernel-3.10
then
    if [ ! -d "out" ]
    then
        mkdir out
    fi
        if make O=out ARCH=arm64 CROSS_COMPILE=~/gcc/gcc-linaro-5.2-aarch64-linux-gnu/bin/aarch64-linux-gnu- P70_defconfig
        then
            if make -j2 O=out ARCH=arm64 CROSS_COMPILE=~/gcc/gcc-linaro-5.2-aarch64-linux-gnu/bin/aarch64-linux-gnu-
            then
                if cp out/arch/arm64/boot/Image.gz-dtb unpack/boot_aosp/kernel
                then
                    if cp out/arch/arm64/boot/Image.gz-dtb unpack/boot_vdt/kernel
                    then
                        if cd unpack/boot_aosp
                        then
                            if ./repack.pl -boot kernel ramdisk/ boot.img
                            then
                                if (grep CONFIG_CPU_OC=y ../../arch/arm64/configs/P70_defconfig > /dev/null)
                                then
                                    zip -r Boot_P70A_only_AOSP.zip META-INF system boot.img
                                else
                                    zip -r Boot_P70_all_AOSP.zip META-INF system boot.img
                                fi
                                    if cd ../boot_vdt
                                    then
                                        if ./repack.pl -boot kernel ramdisk/ boot.img
                                        then
                                            if (grep CONFIG_CPU_OC=y ../../arch/arm64/configs/P70_defconfig > /dev/null)
                                            then
                                                zip -r Boot_P70A_only_VDT.zip META-INF boot.img
                                            else
                                                zip -r Boot_P70_all_VDT.zip META-INF boot.img
                                            fi
                                        fi
                                    fi
                            fi
                        fi
                    fi
                fi
            fi
        fi
fi
cd

