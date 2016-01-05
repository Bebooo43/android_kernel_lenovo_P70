#!/bin/bash
cd ~/kernel-3.10
mkdir out
make O=out ARCH=arm64 CROSS_COMPILE=~/gcc/gcc-linaro-5.2-aarch64-linux-gnu/bin/aarch64-linux-gnu- P70_defconfig
make -j2 O=out ARCH=arm64 CROSS_COMPILE=~/gcc/gcc-linaro-5.2-aarch64-linux-gnu/bin/aarch64-linux-gnu-
cp ~/kernel-3.10/out/arch/arm64/boot/Image.gz-dtb ~/kernel-3.10/out/arch/arm64/boot/boot.img-kernel
cp ~/kernel-3.10/out/arch/arm64/boot/boot.img-kernel ~/Kitchen/boot/boot.img-kernel
cd
