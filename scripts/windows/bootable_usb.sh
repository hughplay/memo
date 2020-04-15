# Create a bootable USB driver on MAC
# https://alexlubbock.com/bootable-windows-usb-on-mac

diskutil list
diskutil eraseDisk MS-DOS "WINDOWS10" MBR <diskN>

rsync -avh --progress --exclude=sources/install.wim /Volumes/<Volume Name of Mounted WINDOWS ISO>/* /Volumes/WINDOWS10
brew install wimlib
wimlib-imagex split /Volumes/CCCOMA_X64FRE_EN-US_DV9/sources/install.wim /Volumes/WINDOWS10/sources/install.swm 4000
