#!/bin/sh

# ~/.xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

# invoke global X session script

if [[ -x /usr/bin/synclient ]]; then
    synclient TapButton1=1
    synclient TapButton2=2
    synclient TapButton3=3
fi
xrdb ~/.Xresources
urxvtd -q -o -f
xset -s off
xset -dpms

session=${1:-i3}

case $session in
    awesome ) exec awesome;;
    i3|13wm ) exec i3;;
    openbox ) exec openbox;;
    xmonad  ) source $HOME/.Xsession.d/xmonad.session;;
    bspwm   ) exec bspwm;;
    dwm     ) exec dwm;;
    *       ) exec $session;;
esac


