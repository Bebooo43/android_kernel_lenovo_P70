# Script to unpack Galaxy R Kernel 
# @Adi_Pat
tput setaf 6
setterm -bold 
echo "**** KERNEL UNPACK SCRIPT ****"
tput sgr0 
setterm -bold 
tput setaf 1
echo "Checking stale files"
if test -d ramdisk
then rm -rf ramdisk
fi
tput setaf 6
echo "Checking for boot.img"
if test -e boot.img
  then
   mkdir ramdisk
   echo "Extracting Kernel + Ramdisk" 
   ./unpackbootimg -i boot.img
   cp boot.img-kernel kernel
   rm boot.img-kernel
   echo "Extracting ramdisk" 
   cd ramdisk
   gzip -dc ../boot.img-ramdisk.gz | cpio -i 
   cd ..
   rm boot.img-ramdisk.gz
   tput setaf 2
   echo "Extracted Kernel is in kernel"
   echo "Extracted Ramdisk is in ramdisk folder" 
tput sgr0
else echo "boot.img not found!"
fi
