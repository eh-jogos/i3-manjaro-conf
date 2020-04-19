#!/bin/bash
# A script to open my setup for working from home to Javary on Mathy
# it accepts one optional argument to select if it should be dual monitors (true) or not (false), 
# dual monitors is the default if nothing is passed
# Dependencies:
# - i3wm
# - Path to Project
# - Monitor Adresses (Names?)
# - Slack
# - Workflowy
# - Thunar
# - wmctrl
# - Firefox

SETUP_NAME = "Javary Mathy"

#i3 workspace names! Get them from your i3/congfig
W1=1:1:Firefox
W2=2:2:Consoles
W3=3:3:Godot
W4=4:
W5=5:
W6=6:6:TabWork
W7=7:7:TabOther
W8=8:8:TabMedia

# echo "I was given $# argument(s):"
# printf "%s\n" "$@"

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
SLACK=/usr/bin/slack
WORKFLOWY=/opt/WorkFlowy-x86_64.AppImage
MATHY_WORK_FOLDER=/mnt/24847D5F847D3500/Daniel/Trabalhos/Javary/math-learning/
JGODOT=godot/bin/godot.x11.opt.tools.64
MONITOR_LEFT=eDP-1-1
MONITOR_RIGHT=HDMI-0
CURRENT_WORKSPACE="$(i3-msg -t get_workspaces | jq '.[] | select(.focused == true)' | jq .name)"


i3-msg move container to workspace RESET_WORKSPACE
i3-msg workspace RESET_WORKSPACE
sleep 1
i3-msg move container to workspace $W2
i3-msg workspace $W2
cd $MATHY_WORK_FOLDER
terminal
if [ $DUAL_MONITORS = "true" ]
then
    i3-msg move workspace to output $MONITOR_RIGHT
fi
sleep 3

i3-msg workspace $W1
if [ $DUAL_MONITORS = "true" ]
then
    i3-msg move workspace to output $MONITOR_LEFT
fi
i3-msg layout tabbed
firefox --new-window https://app.genyo.com.br/c/registroPonto
sleep 3
firefox --new-tab https://docs.google.com/spreadsheets/d/1uznJo4EUh_4az81sPOOZfu68u_tcFDWQgWqLgGHmGwY/edit#gid=963472364
sleep 1
firefox --new-tab https://clockify.me/tracker
sleep 1
firefox --new-tab "https://gitlab.com/javary/math-learning/-/boards?scope=all&utf8=%E2%9C%93&state=opened&assignee_username=danielvandalk"
sleep 1
firefox --new-tab https://drive.google.com/drive/folders/1nHi3pebb_SQONGdDQE-ErSQojt9uvBVd
sleep 1


i3-msg workspace $W6
if [ $DUAL_MONITORS = "true" ]
then
    i3-msg move workspace to output $MONITOR_LEFT
fi
thunar $WORK_FOLDER &
while ! [[ "$(wmctrl -l)" =~ "File Manager" ]] 
do
    sleep 2
done
setsid $SLACK %U &>/dev/null
while ! [[ "$(wmctrl -l)" =~ "Slack" ]] 
do
    sleep 2
done
i3-msg focus parent
sleep 1
i3-msg layout tabbed
$WORKFLOWY &

