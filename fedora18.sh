#!/bin/bash

yum install dkms gcc make kernel-devel wget
yum update

#yum localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-18.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-18.noarch.rpm
#rpm -ivh http://rpm.livna.org/livna-release.rpm
yum install --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-18.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-18.noarch.rpm
yum install --nogpgcheck http://rpm.livna.org/livna-release.rpm

wget -P /etc/yum.repos.d http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
yum update
