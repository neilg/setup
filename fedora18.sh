#!/bin/bash

yum -y install yum-plugin-fastestmirror
yum -y update

RPMF_FREE=http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-18.noarch.rpm
RPMF_NONFREE=http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-18.noarch.rpm
LIVNA=http://rpm.livna.org/livna-release.rpm
ADOBE=http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm

yum -y install $RPMF_FREE $RPMF_NONFREE $LIVNA $ADOBE

yum -y install wget && wget -N -P /etc/yum.repos.d http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo

yum -y update

DROPBOX=https://linux.dropbox.com/packages/fedora/nautilus-dropbox-1.4.0-1.fedora.x86_64.rpm
CHROME=https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

KM_SUPPORT="dkms make gcc kernel-devel"
SSH="openssh-server openssh-clients"
EDITORS="vim emacs"
JAVA="java-1.7.0-openjdk-devel java-1.7.0-openjdk-src maven"
GIT="git git-svn gitg git-all"
VBOX="VirtualBox-4.2"
WEB="flash-plugin $CHROME"
NV="akmod-nvidia"
UTIL="iotop terminator gnome-tweak-tool trash-cli"
WINE="wine"
YUM="yum-plugin-show-leaves"

GSTREAMER="gstreamer-ffmpeg gstreamer-plugins-bad-free gstreamer-plugins-ugly"
GSTREAMER1="gstreamer1-libav gstreamer1-plugins-bad-free gstreamer1-plugins-ugly"

MEDIA="libdvdcss $GSTREAMER $GSTREAMER1 get-flash-videos get_iplayer vlc"

yum -y install $KM_SUPPORT $SSH $EDITORS $JAVA $GIT $VBOX $WEB $NV $UTIL $WINE $YUM $MEDIA

yum -y update

