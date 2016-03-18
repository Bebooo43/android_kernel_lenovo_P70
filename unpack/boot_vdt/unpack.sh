#!/bin/bash
e="\x1b[";c=$e"39;49;00m";y=$e"93;01m";cy=$e"96;01m";r=$e"1;91m";g=$e"92;01m";
##########################################################
#                                                        #
#           Carliv Image Kitchen for Android             #
#     boot+recovery images copyright-2015 carliv@xda     #
#    including support for MTK powered phones images     #
#                                                        #
##########################################################
abort() { cd "$PWD"; echo " "; echo -e "$cy >>$c$r Exit script$c\n"; }
###########################################################
unpackbootimg=./unpackmtkimg;
###########################################################
if [ ! "$1" ]; 
	then
	echo -e "$r No image file selected. ERROR!$c";
	abort;
	exit 1;
fi;
###########################################################
file=$(basename "$1");
echo -e "Your image is$y $origfile$c";
###########################################################
echo " ";
wimage="$file";
###########################################################
if [[ "$wimage" = "boot.img" ]];
	then
	if [ -f boot.img ];
		then		
		if [ "$file" == boot.img ];
			then
			cp -f boot.img bckp-boot.img;
			else
			mv -f boot.img bckp-boot.img;
			cp -f "$file" bckp-"$file";
			mv -f "$file" boot.img;
		fi;
		else
		cp -f "$file" bckp-"$file";
		mv -f "$file" boot.img;
	fi;
fi;
###########################################################
if [[ -z "$wimage" ]];
	then
	echo -e "$r No image to process. ERROR!$c";
	abort;
	exit 1;
fi;
echo -e "Unpacking the$y $file$c ...";
echo " ";
$unpackbootimg -i "$wimage";
if [[ "$wimage" = "boot.img" ]];
	then
	rm -f boot.img;
	if [ "$file" == boot.img ];
		then
		mv -f bckp-boot.img boot.img;
		else
		if [ -f bckp-boot.img ];
			then
			mv -f bckp-boot.img boot.img;
			mv -f bckp-"$file" "$file";
			else
			mv -f bckp-"$file" "$file";
		fi;		
	fi;		
fi;
comprfile=$(find . -name "*-ramdisk.*");
compress="${comprfile##*.}";
echo -e "Compression used:$y $compress ";
filecomp="$wimage"-ramdisk-compress;
if [ ! -f "$filecomp" ]
	then 
	echo "$compress" > "$filecomp" ;
fi;
mkdir -p ramdisk;
###########################################################
echo " ";
echo -e "Unpacking the$y ramdisk$c....";
cd ramdisk;
###########################################################
if [ "$compress" == "gz" ];
	then
	gzip -dcv "../$wimage-ramdisk.gz" | cpio -i ;
	if [ ! $? -eq "0" ]; 
	then
	  echo -e "$r Your ramdisk archive is corrupt. Are you trying to unpack a$c$cy MTK$c$r image with regular script?$c\n$r If so, please use$c$y unpack_MTK_img$c$r script. ERROR!$c";
	  abort;
	  exit 1;
	fi;
	cd ../ ;
	rm -f "$wimage-ramdisk.gz";
	cd ../ ;
fi;
if [ "$compress" == "lzma" ];
	then
	xz -dcv "../$wimage-ramdisk.lzma" | cpio -i ;
	if [ ! $? -eq "0" ]; 
	then
	  echo -e "$r Your ramdisk archive is corrupt. Are you trying to unpack a$c$cy MTK$c$r image with regular script?$c\n$r If so, please use$c$y unpack_MTK_img$c$r script. ERROR!$c";
	  abort;
	  exit 1;
	fi;
	cd ../ ;
	rm -f "$wimage-ramdisk.lzma";
	cd ../ ;
fi;
if [ "$compress" == "xz" ];
	then
	xz -dcv "../$wimage-ramdisk.xz" | cpio -i ;
	if [ ! $? -eq "0" ]; 
	then
	  echo -e "$r Your ramdisk archive is corrupt. Are you trying to unpack a$c$cy MTK$c$r image with regular script?$c\n$r If so, please use$c$y unpack_MTK_img$c$r script. ERROR!$c";
	  abort;
	  exit 1;
	fi;
	cd ../ ;
	rm -f "$wimage-ramdisk.xz";
	cd ../ ;
fi;
if [ "$compress" == "bz2" ];
	then
	bzip2 -dcv "../$wimage-ramdisk.bz2" | cpio -i ;
	if [ ! $? -eq "0" ]; 
	then
	  echo -e "$r Your ramdisk archive is corrupt. Are you trying to unpack a$c$cy MTK$c$r image with regular script?$c\n$r If so, please use$c$y unpack_MTK_img$c$r script. ERROR!$c";
	  abort;
	  exit 1;
	fi;
	cd ../ ;
	rm -f "$wimage-ramdisk.bz2";
	cd ../ ;
fi;
if [ "$compress" == "lzo" ];
	then
	lzop -dcv "../$wimage-ramdisk.lzo" | cpio -i ;
	if [ ! $? -eq "0" ]; 
	then
	  echo -e "$r Your ramdisk archive is corrupt. Are you trying to unpack a regular image with$c$cy MTK$c$r script?$c\n$r If so, please use$c$y unpack_img$c$r script. ERROR!$c";
	  abort;
	  exit 1;
	fi;
	cd ../ ;
	rm -f "$wimage-ramdisk.lzo";
	cd ../ ;
fi;
if [ "$compress" == "unknown" ];
	then
	  echo -e "$r Your image ramdisk is packed with an unsupported archive format. Please inform the author of this tool about the error and provide the image for helping him to find a solution. Exit the script.$c";
	  abort;
	  exit 1;
fi;
echo " ";
###########################################################
echo -e "Done! Your image is unpacked.";
echo " ";
