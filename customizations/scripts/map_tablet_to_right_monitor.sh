#!/bin/bash
# Made this with the help of the documentation at:
# https://wiki.archlinux.org/index.php/wacom_tablet#Adjusting_aspect_ratios
# https://wiki.archlinux.org/index.php/wacom_tablet#xrandr_setup

# Please turn this into a dunction when going back to manjaro i3?? Or just set this script in another location


# Limit stylus to a 16:9 centralized area
xsetwacom set 'Wacom Cintiq 21UX Pen stylus' Area 0 8275 87200 57325
xsetwacom set 'Wacom Cintiq 21UX Pen eraser' Area 0 8275 87200 57325

# Set Display using coordinates WIDTHxHEIGHT+OFFSET_X+OFFSET_Y
xsetwacom set 'Wacom Cintiq 21UX Pen stylus' MapToOutput 1600x900+1920+0
xsetwacom set 'Wacom Cintiq 21UX Pen eraser' MapToOutput 1600x900+1920+0
