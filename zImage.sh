#!/bin/bash
cd ~/kernel-3.10
mkdir out
make O=out ARCH=arm64 CROSS_COMPILE=~/gcc/gcc-linaro-5.2-aarch64-linux-gnu/bin/aarch64-linux-gnu- P70_defconfig
make -j2 O=out ARCH=arm64 CROSS_COMPILE=~/gcc/gcc-linaro-5.2-aarch64-linux-gnu/bin/aarch64-linux-gnu-
cp out/arch/arm64/boot/Image.gz-dtb unpack/boot_aosp/kernel
cp out/arch/arm64/boot/Image.gz-dtb unpack/boot_vdt/kernel
cd unpack/boot_aosp
./repack.pl -boot kernel ramdisk/ boot.img
if (grep CONFIG_CPU_OC=y ../../arch/arm64/configs/P70_defconfig > /dev/null); then
    zip -r Boot_P70A_only_AOSP.zip META-INF system boot.img
    else
    zip -r Boot_P70_all_AOSP.zip META-INF system boot.img
fi
cd ../boot_vdt
./repack.pl -boot kernel ramdisk/ boot.img
if (grep CONFIG_CPU_OC=y ../../arch/arm64/configs/P70_defconfig > /dev/null); then
    zip -r Boot_P70A_only_VDT.zip META-INF boot.img
    else
    zip -r Boot_P70_all_VDT.zip META-INF boot.img
fi
cd

