#!/bin/bash
xrdb -merge ${HOME}/.Xresources

DBS_L=/usr/bin/dbus-launch 

$DBS_L trayer --edge top --align right --expand true --width 10 --transparent true --tint 0x333333 --alpha 0 --height 28 --monitor 1 &


feh --bg-scale ${HOME}/.wallpaper.jpg

dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# composite manager
if [ -x /usr/bin/xcompmgr ] ; then
    xcompmgr &
fi

# network-manager
if [ -x /usr/bin/nm-applet ] ; then
   $DBS_L nm-applet --sm-disable &
fi

if [ -x /usr/bin/conky ] ; then
    $DBS_L conky
fi 

if [ -x /usr/bin/albert ] ; then
    $DBS_L albert &
fi 

if [ -x /usr/bin/fcitx ] ; then
   $DBS_L fcitx -d
fi

if [ -x /usr/bin/dropbox ] ; then
    $DBS_L dropbox &
fi

if [ -x /usr/bin/nextcloud ] ; then
    $DBS_L nextcloud &
fi

if [ -x /usr/bin/blueberry-tray ] ; then
    $DBS_L blueberry-tray &
fi 

if [ -x /usr/bin/xscreensaver ] ; then
    $DBS_L xscreensaver &
fi

if [ -d /usr/bin/xbindkeys ] ; then
    $DBS_L xbindkeys 
fi 

$DBS_L xmonad
