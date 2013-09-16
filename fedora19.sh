#!/bin/bash

installed() {
  if [[ $( rpm -qa $1 ) == *${1}* ]]; then
    return 0
  else
    return 1
  fi
}

fail() {
  echo "$1"
  if [ -z $2 ]; then
    EXIT_CODE=-1
  else
    EXIT_CODE=$2
  fi
  exit $EXIT_CODE
}

while getopts ":h:" option; do
  case $option in
    h)
      echo setting hostname to $OPTARG
      hostnamectl --static --transient set-hostname "$OPTARG" || fail "couldn't set hostname to $OPTARG"
      ;;
    *)
      echo UNKNOWN ARG $OPTARG at position $OPTIND
      echo exiting
      exit -1
      ;;
  esac
done

yum -y install yum-plugin-fastestmirror
yum -y update

if ! installed rpmfusion-free-release; then
  REPOS="$REPOS http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-19.noarch.rpm"
fi
if ! installed rpmfusion-nonfree-release; then
  REPOS="$REPOS http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-19.noarch.rpm"
fi
if ! installed livna-release; then
  REPOS="$REPOS http://rpm.livna.org/livna-release.rpm"
fi
if ! installed adobe-release-x86_64; then
  REPOS="$REPOS http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm"
fi
if ! installed infinality-repo; then
  REPOS="$REPOS http://www.infinality.net/fedora/linux/infinality-repo-1.0-1.noarch.rpm"
fi
if [ ! -z "$REPOS" ]; then
  echo "installing $REPOS"
  yum -y install $REPOS
fi

yum-config-manager --add-repo=http://repos.fedorapeople.org/repos/spot/chromium-stable/fedora-chromium-stable.repo
yum-config-manager --add-repo=http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo

yum -y update

if ! installed nautilus-dropbox; then
  DROPBOX=https://linux.dropbox.com/packages/fedora/nautilus-dropbox-1.6.0-1.fedora.x86_64.rpm
fi
if ! installed google-chrome-stable; then
  CHROME=https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
fi
# skype and sbt don't set up their own repos, so subsequent updates aren't dealt with
if ! installed skype; then
  SKYPE=http://download.skype.com/linux/skype-4.2.0.11-fedora.i586.rpm alsa-lib.i686 libXv.i686 libXScrnSaver.i686 qt.i686 qt-x11.i686 pulseaudio-libs.i686 pulseaudio-libs-glib2.i686 alsa-plugins-pulseaudio.i686 qtwebkit.i686
fi
if ! installed sbt; then
  SBT=http://scalasbt.artifactoryonline.com/scalasbt/sbt-native-packages/org/scala-sbt/sbt/0.12.4/sbt.rpm
fi

CLAM="clamav clamav-update"
FONTS="freetype-infinality fontconfig-infinality"
GPS="foxtrotgps gpsd gpsd-clients"
GOBI="gobi_loader"
KM_SUPPORT="dkms make gcc kernel-devel"
YUM="yum-plugin-show-leaves"
EDITORS="vim emacs"
GIT="git git-svn gitg git-all tig"
GUEST="xguest"
HASKELL="haskell-platform cabal-dev"
JAVA="java-1.7.0-openjdk-devel java-1.7.0-openjdk-src maven visualvm"
NET="whois wireshark-gnome corkscrew telnet"
#NV="akmod-nvidia"
SSH="openssh-server openssh-clients"
UTIL="iotop terminator gnome-tweak-tool trash-cli powertop units pbzip2 spawn htop"
VBOX="VirtualBox-4.2"
WEB="flash-plugin $CHROME chromium wget"
#WINE="wine"

GSTREAMER="gstreamer-ffmpeg gstreamer-plugins-bad-free gstreamer-plugins-ugly gstreamer-plugins-bad gstreamer-plugins-bad-nonfree"
GSTREAMER1="gstreamer1-libav gstreamer1-plugins-bad-free gstreamer1-plugins-ugly gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld gstreamer1-plugins-good-extras"
DVD="libdvdcss libdvdread libdvdnav"

MEDIA="$DVD $GSTREAMER $GSTREAMER1 get-flash-videos get_iplayer vlc"

yum -y install $VBOX $JAVA $DROPBOX $FONTS $KM_SUPPORT $NET $SSH $EDITORS $GIT $WEB $NV $UTIL $WINE $YUM $MEDIA $SKYPE $CLAM $SBT $GPS $GOBI $HASKEL $GUEST

yum -y update

systemctl enable sshd.service
systemctl start sshd.service

