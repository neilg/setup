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

export esp="$m2"1
export swapp="$m2"2
export archp="$m2"3

swapon "$swapp"
mount "$archp" /mnt -o defaults,discard,subvol=@root
mkdir /mnt/boot
mount "$esp" /mnt/boot -o defaults,discard
mkdir /mnt/home
mount "$ssd1" /mnt/home -o defaults,discard,subvol=@home
mkdir /mnt/var
mount "$ssd1" /mnt/var -o defaults,discard,subvol=@var

