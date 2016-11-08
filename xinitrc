#!/bin/sh

# ~/.xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

# invoke global X session script

xrdb ~/.Xresources
urxvtd -q -o -f
exec awesome

