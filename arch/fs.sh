#!/bin/sh

# check prerequisites
# need to know m2 and two EVO devices
export m2=$1
export ssd1=$2
export ssd2=$3
if [ -z $m2 ] || [ -z $ssd1 ] || [ -z $ssd2 ]; then
  echo "Usage: $0 m2 ssd1 ssd2"
  exit 1
fi

# wipe and create partition table on m2
sgdisk "$m2" -Z
sgdisk "$m2" -og
# create partitions on m2
sgdisk "$m2" -n 1:+0:+512M -t 1:ef00 -c 1:"EFI system partition"
sgdisk "$m2" -n 2:+0:+24G -t 2:8200 -c 2:"Linux swap"
sgdisk "$m2" -n 3:+0:-0 -t 3:8300 -c 3:"Arch Linux"

#create filesystems on m2
export esp="$m2"1
export swapp="$m2"2
export archp="$m2"3
mkfs.vfat -F32 "$esp"
mkswap "$swapp"
mkfs.btrfs -f "$archp"

#create filesystems on ssds
mkfs.btrfs -f -d raid1 -m raid1 "$ssd1" "$ssd2"

#create subvolumes
umount /mnt
mount "$ssd1" /mnt
btrfs subvol create /mnt/@home
btrfs subvol create /mnt/@var
umount /mnt
mount "$archp" /mnt
btrfs subvol create /mnt/@root
umount /mnt

