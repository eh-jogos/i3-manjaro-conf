#!/bin/zsh
# A script to open my setup for working on Escape from the Cosmic Abyss
# it accepts one optional argument to select if it should be dual monitors (true) or not (false), 
# dual monitors is the default if nothing is passed
# Parameters are:
# $1 - SETUP_NAME
# $2 - WORK_FOLDER
# $3 - GODOT_PROJECT_FOLDER
# $4 - DUAL MONITORs
# $5... - everything from 5 onwards will be considered as firefox tabs
# Dependencies:
# - i3wm
# - Path to Project
# - Monitor Adresses (Names?)
# - Godot 2.1.x (and my godot function in a folder called .zfunc at ~)
# - Workflowy
# - Thunar
# - wmctrl
# - Firefox

# echo "${@}"

#i3 workspace names! Get them from your i3/congfig
W1=1:1:Firefox
W2=2:2:Consoles
W3=3:3:Godot
W4=4:4:CodeAssist
W5=5:5:Art
W6=6:6:TabWork
W7=7:7:TabOther
W8=8:8:TabMedia

SETUP_NAME=$1
DUAL_MONITORS=true
if [ ! -z "$4" ]
then
    if [ $4 = "false" ]
    then
        DUAL_MONITORS=false
        echo "Single Monitor Setup for $SETUP_NAME"
    elif [ $4 != "true" ]
    then
        echo "$SETUP_NAME || unrecognized option: $4 | Going with default (Dual Monitor)"
    else
        echo "Dual Monitor Setup for $SETUP_NAME"
    fi
else
    echo "Dual Monitor Setup for $SETUP_NAME"
fi

# PATHS
WORKFLOWY=/opt/WorkFlowy-x86_64.AppImage

WORK_FOLDER=$2
GODOT_PROJECT_FOLDER=$3
COURSE_FOLDER="/mnt/HD_DATA/Livros e Tutoriais/GDQuestCourses/GDQuest Godot/ActionRPGCourse"

MONITOR_LEFT=eDP-1-1
MONITOR_RIGHT=HDMI-0
CURRENT_WORKSPACE="$(i3-msg -t get_workspaces | jq '.[] | select(.focused == true)' | jq .name)"

fpath=( ~/.zfunc "${fpath[@]}" )
autoload -Uz godot

########### Script Body

# RESET WORKSPACE
i3-msg move container to workspace RESET_WORKSPACE
i3-msg workspace RESET_WORKSPACE
sleep 1


# Open terminals
i3-msg move container to workspace $W2
i3-msg workspace $W2
if [ $DUAL_MONITORS = "true" ]
then
    i3-msg move workspace to output $MONITOR_LEFT
fi
cd $WORK_FOLDER


# Open Code
sleep 1
i3-msg workspace $W4
if [ $DUAL_MONITORS = "true" ]
then
    i3-msg move workspace to output $MONITOR_LEFT
fi
code $WORK_FOLDER
while ! [[ "$(wmctrl -lx)" =~ "code-oss.code-oss" ]] 
do
    sleep 1
done


# Open Project folder and workflowy
sleep 1
i3-msg workspace $W6
if [ $DUAL_MONITORS = "true" ]
then
    i3-msg move workspace to output $MONITOR_LEFT
fi
echo $WORK_FOLDER
thunar $WORK_FOLDER &
echo $COURSE_FOLDER
thunar $COURSE_FOLDER &
while ! [[ "$(wmctrl -lx)" =~ ".Thunar" ]] 
do
    wmctrl -lx
    echo "waiting on Thunar"
    sleep 2
done
$WORKFLOWY &
i3-msg layout stacking
while ! [[ "$(wmctrl -lx)" =~ "workflowy.WorkFlowy" ]] 
do
    sleep 2
done


# Open Browser and relevant tabs
sleep 1
i3-msg workspace $W1
if [ $DUAL_MONITORS = "true" ]
then
    i3-msg move workspace to output $MONITOR_LEFT
fi
firefox --new-window "https://docs.google.com/spreadsheets/"
sleep 3
firefox --new-tab "https://pomodoro-tracker.com/"
i3-msg layout stacking
sleep 1
if [ ! -z "$5" ]
then
    for url in ${@:5};
    do
        firefox --new-tab $url
        sleep 1
    done
else
    echo "No additional Firefox tabs"
fi


# Open Godot
sleep 1
i3-msg workspace $W3
if [ $DUAL_MONITORS = "true" ]
then
    i3-msg move workspace to output $MONITOR_RIGHT
fi
godot -e & 
