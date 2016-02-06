# Script Pack Kernel + Ramdisk and CWM zip + sign 
# By Adi_Pat
tput setaf 6
setterm -bold 
echo "**** KERNEL PACKER SCRIPT ****"
tput sgr0 
setterm -bold
echo "Checking kernel"
if test -e kernel
   then echo "Kernel found"
else echo "Kernel not found!"
   tput sgr0
   exit 
fi
echo "Checking Ramdisk"
if test -d ramdisk 
then echo "Ramdisk found" 
else echo "Ramdisk not found!"
tput sgr0
exit 
fi
echo "kernel + ramdisk found, preparing ramdisk"
sleep 2 
./mkbootfs ramdisk | gzip > ramdisk.gz
sleep 2
echo "Packing final Kernel (boot.img) "
./mkbootimg --kernel kernel --ramdisk ramdisk.gz -o boot.img --base 10000000
sleep 2
setterm -bold 
rm ramdisk.gz
echo "Final boot.img is boot.img"
tput sgr0
echo "All Done"

