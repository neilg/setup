#!/bin/sh

pacstrap -i /mnt base base-devel git zsh btrfs-progs vim networkmanager grub efibootmgr cronie
genfstab -U -p /mnt >> /mnt/etc/fstab

