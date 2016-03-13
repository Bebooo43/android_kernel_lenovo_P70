#!/bin/bash

CONFIG_1=P70_defconfig #No OC
CONFIG_2=P70_GC_defconfig #OC CPU & GPU
CONFIG_3=P70_G_defconfig #OC only GPU
CONFIG_4=P70_C_defconfig #OC only CPU

CONFIG_5=P70_cyanogenmod_defconfig #No OC
CONFIG_6=P70_GC_cyanogenmod_defconfig #OC CPU & GPU
CONFIG_7=P70_G_cyanogenmod_defconfig #OC only GPU
CONFIG_8=P70_C_cyanogenmod_defconfig #OC only CPU

KERNEL_DIR=~/kernel-3.10
CROSS_COMPILE=~/gcc/gcc-linaro-5.2-aarch64-linux-gnu/bin/aarch64-linux-gnu-
OUT=out

make_aosp_kernel() {
if cd $KERNEL_DIR
then
	if [ ! -d "$OUT" ]
	then
		mkdir $OUT
	fi
		if make O=$OUT ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE $1
		then
			if make -j2 O=$OUT ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE
			then
				if cp out/arch/arm64/boot/Image.gz-dtb unpack/boot_aosp/kernel
				then
					if cd unpack/boot_aosp
					then
						if ./repack.pl -boot kernel ramdisk/ boot.img
						then
							if mv boot.img ../boot_aosp.img
							then
								if rm -f kernel
								then
									cd $KERNEL_DIR
								fi
							fi
						fi
					fi
				fi
			fi
		fi
fi
}

make_vdt_kernel() {
if cd $KERNEL_DIR
then
	if [ ! -d "$OUT" ]
	then
		mkdir $OUT
	fi
		if make O=$OUT ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE $1
		then
			if make -j2 O=$OUT ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE
			then
				if cp out/arch/arm64/boot/Image.gz-dtb unpack/boot_vdt/kernel
				then
					if cd unpack/boot_vdt
					then
						if ./repack.pl -boot kernel ramdisk/ boot.img
						then
							if mv boot.img ../boot_vdt.img
							then
								if rm -f kernel
								then
									cd $KERNEL_DIR
								fi
							fi
						fi
					fi
				fi
			fi
		fi
fi
}

make_cm_kernel() {
if cd $KERNEL_DIR
then
	if [ ! -d "$OUT" ]
	then
		mkdir $OUT
	fi
		if make O=$OUT ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE $1
		then
			if make -j2 O=$OUT ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE
			then
				if cp out/arch/arm64/boot/Image.gz-dtb unpack/boot_cm/boot.img-kernel
				then
					if cd unpack/boot_cm
					then
						if ./repack.sh
						then
							if mv boot.img ../boot_cm.img
							then
								if rm -f boot.img-kernel
								then
									cd $KERNEL_DIR
								fi
							fi
						fi
					fi
				fi
			fi
		fi
fi
}

make_aicp_kernel() {
if cd $KERNEL_DIR
then
	if [ ! -d "$OUT" ]
	then
		mkdir $OUT
	fi
		if make O=$OUT ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE $1
		then
			if make -j2 O=$OUT ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE
			then
				if cp out/arch/arm64/boot/Image.gz-dtb unpack/boot_aicp/boot.img-kernel
				then
					if cd unpack/boot_aicp
					then
						if ./repack.sh
						then
							if mv boot.img ../boot_aicp.img
							then
								if rm -f boot.img-kernel
								then
									cd $KERNEL_DIR
								fi
							fi
						fi
					fi
				fi
			fi
		fi
fi
}

make_cm_zormax_kernel() {
if cd $KERNEL_DIR
then
	if [ ! -d "$OUT" ]
	then
		mkdir $OUT
	fi
		if make O=$OUT ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE $1
		then
			if make -j2 O=$OUT ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE
			then
				if cp out/arch/arm64/boot/Image.gz-dtb unpack/boot_cm_zormax/boot.img-kernel
				then
					if cd unpack/boot_cm_zormax
					then
						if ./repack.sh
						then
							if mv boot.img ../boot_cm_zormax.img
							then
								if rm -f boot.img-kernel
								then
									cd $KERNEL_DIR
								fi
							fi
						fi
					fi
				fi
			fi
		fi
fi
}

make_zip() {
if cd $KERNEL_DIR/unpack
then
	if [ "$1" == "$CONFIG_1" ]
	then
		zip -r Boot_P70.zip META-INF system boot_aosp.img boot_vdt.img boot_cm.img boot_aicp.img boot_cm_zormax.img
	elif [ "$1" == "$CONFIG_2" ]
	then
		zip -r Boot_P70_GC.zip META-INF system boot_aosp.img boot_vdt.img boot_cm.img boot_aicp.img boot_cm_zormax.img
	elif [ "$1" == "$CONFIG_3" ]
	then
		zip -r Boot_P70_G.zip META-INF system boot_aosp.img boot_vdt.img boot_cm.img boot_aicp.img boot_cm_zormax.img
	elif [ "$1" == "$CONFIG_4" ]
	then
		zip -r Boot_P70_C.zip META-INF system boot_aosp.img boot_vdt.img boot_cm.img boot_aicp.img boot_cm_zormax.img
	fi
		if rm -f boot_aosp.img
		then
			if rm -f boot_vdt.img
			then
				if rm -f boot_cm.img
				then
					if rm -f boot_aicp.img
					then
						if rm -f boot_cm_zormax.img
						then
							cd $KERNEL_DIR
						fi
					fi
				fi
			fi
		fi
fi
}

boot_p70() {
make_aosp_kernel "$CONFIG_1"
make_vdt_kernel "$CONFIG_1"
make_cm_kernel "$CONFIG_5"
make_aicp_kernel "$CONFIG_1"
make_cm_zormax_kernel "$CONFIG_5"
make_zip "$CONFIG_1"
}

boot_p70_gc() {
make_aosp_kernel "$CONFIG_2"
make_vdt_kernel "$CONFIG_2"
make_cm_kernel "$CONFIG_6"
make_aicp_kernel "$CONFIG_2"
make_cm_zormax_kernel "$CONFIG_6"
make_zip "$CONFIG_2"
}

boot_p70_g() {
make_aosp_kernel "$CONFIG_3"
make_vdt_kernel "$CONFIG_3"
make_cm_kernel "$CONFIG_7"
make_aicp_kernel "$CONFIG_3"
make_cm_zormax_kernel "$CONFIG_7"
make_zip "$CONFIG_3"
}

boot_p70_c() {
make_aosp_kernel "$CONFIG_4"
make_vdt_kernel "$CONFIG_4"
make_cm_kernel "$CONFIG_8"
make_aicp_kernel "$CONFIG_4"
make_cm_zormax_kernel "$CONFIG_8"
make_zip "$CONFIG_4"
}

boot_p70
boot_p70_gc
boot_p70_g
boot_p70_c

