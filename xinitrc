#!/bin/sh
# ~/.xinitrc

if [[ -x /usr/bin/synclient ]]; then
    synclient TapButton1=1
    synclient TapButton2=2
    synclient TapButton3=3
fi

xrdb ~/.Xresources
urxvtd -q -o -f
xset s off
xset -dpms
numlockx on

xsetroot -solid "#12171f"

ntpd -qg

if [[ -f $HOME/.config/xmodmap/xmodmap.config ]]; then
    xmodmap $HOME/.config/xmodmap/xmodmap.config
fi

mopidy &

[[ -x $HOME/bin/setup_display ]] && $HOME/bin/setup_display

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


