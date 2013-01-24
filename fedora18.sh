#!/bin/bash

installed() {
  if [[ $( rpm -qa $1 ) == *${1}* ]]; then
    return 0
  else
    return 1
  fi
}

yum -y install yum-plugin-fastestmirror wget
yum -y update

if ! installed rpmfusion-free-release; then
  REPOS="$REPOS http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-18.noarch.rpm"
fi
if ! installed rpmfusion-nonfree-release; then
  REPOS="$REPOS http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-18.noarch.rpm"
fi
if ! installed livna-release; then
  REPOS="$REPOS http://rpm.livna.org/livna-release.rpm"
fi
if ! installed adobe-release-x86_64; then
  REPOS="$REPOS http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm"
fi
if [ ! -z "$REPOS" ]; then
  echo "installing $REPOS"
  yum -y install $REPOS
fi

wget -N -P /etc/yum.repos.d http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo

yum -y update

if ! installed nautilus-dropbox; then
  DROPBOX=https://linux.dropbox.com/packages/fedora/nautilus-dropbox-1.4.0-1.fedora.x86_64.rpm
fi
if ! installed google-chrome-stable; then
  CHROME=https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
fi
if ! installed skype; then # this isn't quite right, as another version of skype may be installed
  SKYPE=http://download.skype.com/linux/skype-4.1.0.20-fedora.i586.rpm
fi

KM_SUPPORT="dkms make gcc kernel-devel"
YUM="yum-plugin-show-leaves"
EDITORS="vim emacs"
GIT="git git-svn gitg git-all"
JAVA="java-1.7.0-openjdk-devel java-1.7.0-openjdk-src maven"
NET="whois wireshark-gnome"
NV="akmod-nvidia"
SSH="openssh-server openssh-clients"
UTIL="iotop terminator gnome-tweak-tool trash-cli powertop"
VBOX="VirtualBox-4.2"
WEB="flash-plugin $CHROME hotot"
WINE="wine"

GSTREAMER="gstreamer-ffmpeg gstreamer-plugins-bad-free gstreamer-plugins-ugly"
GSTREAMER1="gstreamer1-libav gstreamer1-plugins-bad-free gstreamer1-plugins-ugly"

MEDIA="libdvdcss $GSTREAMER $GSTREAMER1 get-flash-videos get_iplayer vlc"

yum -y install $KM_SUPPORT $NET $SSH $EDITORS $JAVA $GIT $VBOX $WEB $NV $UTIL $WINE $YUM $MEDIA $SKYPE

yum -y update

sudo systemctl enable sshd.service
sudo systemctl start sshd.service

