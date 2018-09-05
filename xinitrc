#!/bin/sh
# ~/.xinitrc

if [[ -x /usr/bin/synclient ]]; then
    synclient TapButton1=1
    synclient TapButton2=2
    synclient TapButton3=3
fi


export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

xset +fp /home/tyler/.fonts
xset fp rehash

ibus-daemon -rdx

xrdb ~/.Xresources
# urxvtd -q -o -f
xset s off
xset -dpms
numlockx on

[[ -x $HOME/bin/setup_display ]] && $HOME/bin/setup_display

if [[ -f $HOME/.config/xmodmap/xmodmap.config ]]; then
    sleep 1 && xmodmap $HOME/.config/xmodmap/xmodmap.config && echo "SUCCEEDED" > ~/xmodmap_status || echo "FAILED" > ~/xmodmap_status
fi

mopidy &

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


