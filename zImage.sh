#!/bin/bash

CONFIG_1=P70_defconfig #No OC
CONFIG_2=P70_GC_defconfig #OC CPU & GPU
CONFIG_3=P70_G_defconfig #OC only GPU
CONFIG_4=P70_C_defconfig #OC only CPU

KERNEL_DIR=~/kernel-3.10
CROSS_COMPILE=~/gcc/gcc-linaro-5.2-aarch64-linux-gnu/bin/aarch64-linux-gnu-
OUT=out

for CONFIG in $CONFIG_1 $CONFIG_2 $CONFIG_3 $CONFIG_4
do
if cd $KERNEL_DIR
then
	if [ ! -d "$OUT" ]
	then
		mkdir out
	fi
		if make O=$OUT ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE $CONFIG
		then
			if make -j2 O=$OUT ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE
			then
				if cp out/arch/arm64/boot/Image.gz-dtb unpack/boot_aosp/kernel
				then
					if cp out/arch/arm64/boot/Image.gz-dtb unpack/boot_vdt/kernel
					then
						if cp out/arch/arm64/boot/Image.gz-dtb unpack/boot_cm/boot.img-kernel
						then
							if cp out/arch/arm64/boot/Image.gz-dtb unpack/boot_aicp/boot.img-kernel
							then
								if cp out/arch/arm64/boot/Image.gz-dtb unpack/boot_cm_zormax/boot.img-kernel
								then
									if cd unpack/boot_aosp
									then
										if ./repack.pl -boot kernel ramdisk/ boot.img
										then
											if mv boot.img ../boot_aosp.img
											then
												if rm -f kernel
												then
													if cd ../boot_vdt
													then
														if ./repack.pl -boot kernel ramdisk/ boot.img
														then
															if mv boot.img ../boot_vdt.img
															then
																if rm -f kernel
																then
																	if cd ../boot_cm
																	then
																		if ./repack.sh
																		then
																			if mv boot.img ../boot_cm.img
																			then
																				if rm -f boot.img-kernel
																				then
																					if cd ../boot_aicp
																					then
																						if ./repack.sh
																						then
																							if mv boot.img ../boot_aicp.img
																							then
																								if rm -f boot.img-kernel
																								then
																									if cd ../boot_cm_zormax
																									then
																										if ./repack.sh
																										then
																											if mv boot.img ../boot_cm_zormax.img
																											then
																												if rm -f boot.img-kernel
																												then
																													if cd ../
																													then
																														if [ "$CONFIG" == "$CONFIG_1" ]
																														then
																															zip -r Boot_P70.zip META-INF system boot_aosp.img boot_vdt.img boot_cm.img boot_aicp.img boot_cm_zormax.img
																														elif [ "$CONFIG" == "$CONFIG_2" ]
																														then
																															zip -r Boot_P70_GC.zip META-INF system boot_aosp.img boot_vdt.img boot_cm.img boot_aicp.img boot_cm_zormax.img
																														elif [ "$CONFIG" == "$CONFIG_3" ]
																														then
																															zip -r Boot_P70_G.zip META-INF system boot_aosp.img boot_vdt.img boot_cm.img boot_aicp.img boot_cm_zormax.img
																														elif [ "$CONFIG" == "$CONFIG_4" ]
																														then
																															zip -r Boot_P70_C.zip META-INF system boot_aosp.img boot_vdt.img boot_cm.img boot_aicp.img boot_cm_zormax.img
																														fi
																															if rm -f boot_aosp.img
																															then
																																if rm -f boot_vdt.img
																																then
																																	#if rm -f boot_cm.img
																																	#then
																																		if rm -f boot_aicp.img
																																		then
																																			rm -f boot_cm_zormax.img
																																		fi
																																	#fi
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
fi
cd
done

