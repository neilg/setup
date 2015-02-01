#!/bin/sh

locale=en_GB.UTF-8
sed -i "s/^#${locale}/${locale}/" '/etc/locale.gen'
locale-gen
echo LANG=${locale} > /etc/locale.conf
export LANG=${locale}

cat > /etc/vconsole.conf << EOF
KEYMAP=uk
FONT=Lat2-Terminus16
EOF

ln -s /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc --utc

hostname=riesling
echo $hostname > /etc/hostname
sed -i "/^127\.0\.0\.1/ s/$/ ${hostname}/" /etc/hosts
sed -i "/^::1/          s/$/ ${hostname}/" /etc/hosts

