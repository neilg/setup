#!/bin/bash

yum -y update

yum -y install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-18.noarch.rpm
yum -y install http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-18.noarch.rpm
yum -y install http://rpm.livna.org/livna-release.rpm
yum -y install http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm

wget -P /etc/yum.repos.d http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo

#yum -y install https://linux.dropbox.com/packages/fedora/nautilus-dropbox-1.4.0-1.fedora.x86_64.rpm

yum -y update

yum -y install dkms gcc make kernel-devel wget vim openssh-server
yum -y install VirtualBox-4.2
yum -y install flash-plugin
yum -y install akmod-nvidia

yum -y update

