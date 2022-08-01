#!/bin/bash
# A script to open my Cpp Udemy Course Setup

#i3 workspace names! Get them from your i3/congfig
W1=1:1:Firefox
W2=2:2:Consoles
W3=3:3:Godot
W4=4:4:CodeAssist
W5=5:5:Art
W6=6:6:TabWork
W7=7:7:TabOther
W8=8:8:TabMedia

SETUP_NAME="C++ Udemy Course"
DUAL_MONITORS=true
if [ ! -z "$1" ]
then
    if [ $1 = "false" ]
    then
        DUAL_MONITORS=false
        echo "Single Monitor Setup for $SETUP_NAME"
    elif [ $1 != "true" ]
    then
        echo "$SETUP_NAME || unrecognized option: $1 | Going with default (Dual Monitor)"
    else
        echo "Dual Monitor Setup for $SETUP_NAME"
    fi
else
    echo "Dual Monitor Setup for $SETUP_NAME"
fi

# PATHS
WORKFLOWY=/opt/WorkFlowy-x86_64.AppImage
CPP_COURSE_FOLDER=~/WORK_SSD/eh_jogos/ProjetosCode/UdemyCppCourse/CppCourseVSC/
MONITOR_LEFT=eDP-1
MONITOR_RIGHT=HDMI-1-0
CURRENT_WORKSPACE="$(i3-msg -t get_workspaces | jq '.[] | select(.focused == true)' | jq .name)"

# Script Body
i3-msg move scratchpad
sleep 1
i3-msg workspace RESET_WORKSPACE

i3-msg workspace $W1
sleep 1
i3-msg layout stacking
firefox --new-window https://www.udemy.com/course/beginning-c-plus-plus-programming/learn/
sleep 3
firefox --new-tab https://pomodoro-tracker.com/
firefox --new-tab https://docs.google.com/spreadsheets/d/19_iyG9zCOMS5qulOZZat9M77d7LG3O28ZfQ_hPQWvzQ/edit#gid=1683392473
if [ $DUAL_MONITORS = "true" ]
then
    i3-msg move workspace to output $MONITOR_LEFT
fi
sleep 1

i3-msg workspace $W6
i3-msg layout stacking
$WORKFLOWY &
while ! [[ "$(wmctrl -l)" =~ "WorkFlowy" ]] 
do
    sleep 2
done
thunar $CPP_COURSE_FOLDER &
while ! [[ "$(wmctrl -lx)" =~ ".Thunar" ]] 
do
	wmctrl -lx
	echo "waiting on Thunar"
	sleep 2
done
if [ $DUAL_MONITORS = "true" ]
then
    i3-msg move workspace to output $MONITOR_RIGHT
fi


# Open Code
sleep 1
i3-msg workspace $W4
if [ $DUAL_MONITORS = "true" ]
then
    i3-msg move workspace to output $MONITOR_LEFT
fi
code $CPP_COURSE_FOLDER
while ! [[ "$(wmctrl -lx)" =~ "code-oss.code-oss" ]] 
do
    sleep 1
done
