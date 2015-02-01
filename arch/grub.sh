#!/bin/sh

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub_uefi --recheck
mkdir -p /boot/EFI/boot
cp /boot/EFI/grub_uefi/grubx64.efi /boot/EFI/boot/bootx64.efi
grub-mkconfig -o /boot/grub/grub.cfg

