#!/bin/sh
xrandr --newmode "1600x900-60.00"  118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync
xrandr --addmode "HDMI-1-0" "1600x900-60.00"
xrandr --output HDMI-1-0 --primary --mode "1600x900-60.00" --pos 1920x0 --rotate normal --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1-1 --off --output HDMI-1-1 --off --output DP-1-2 --off --output HDMI-1-2 --off --output DP-1-3 --off --output HDMI-1-3 --off
