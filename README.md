Areola_kernel_packer
====================

#Pack kernels using aroma as an installer

##make a script to build your kernel and include the following variables.

###Build the boot image
````
. build/envsetup.sh
lunch full_devicename-userdebug 
````

###Adjust for your CPU threads
````
time make bootimage -j9
````

###Set your directory locations
Abootimg=
````
Abootimg is the location of your out folder where boot.img resides.
````
Alibfiles=
````
Alibfiles is the directory for your library modules.
````
Klocation=
````
Klocation is the location of your kernel source. This is used to update the changelog.
````
Example:
````
Abootimg=PATH/TO/boot.img
Alibfiles=SET/YOUR/OUTPATH/target/product/DEVNAME/system/lib
Klocation=~SET/PATH/TO/android/cm11/kernel/DEVNAME/KERNAL
````
###Copy boot.img and libs
````
cp -ar $Alibfiles ./output/zip/system
cp $Abootimg ./output/zip
````

###Go to the kernel directory and fetch the last 100 commits
Leave the (). It indicates a function done in a sub-shell
````
(cd $Klocation && git log --max-count=100 --oneline --decorate > changelogs.txt && sed -i 's/(HEAD, master)/" "/g' changelogs.txt && sed -i 's/\(origin\/master, origin\/HEAD\)/" "/g' changelogs.txt)
````

###Import commits into Aroma
````
cp $Klocation/changelogs.txt output/zip/META-INF/com/google/android/aroma 
````

###Remove old files
````
rm $Klocation/changelogs.txt
````

###Naming and making an installer zip
````
cd output/zip
NOW=$(date +"%m-%d-%y")
````

###change this kernel name to whatever you name yours
````
zip -r -q --exclude=*zip* marduks kernel-"$NOW".zip * && echo "Success" || echo "Failure"
````