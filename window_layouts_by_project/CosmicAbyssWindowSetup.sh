#!/bin/zsh
# A script to open my setup for working on Escape from the Cosmic Abyss
# it accepts one optional argument to select if it should be dual monitors (true) or not (false), 
# dual monitors is the default if nothing is passed
# Dependencies:
# - i3wm
# - Path to Project
# - Monitor Adresses (Names?)
# - Godot 2.1.x (and my godot function in a folder called .zfunc at ~)
# - Workflowy
# - Thunar
# - wmctrl
# - Firefox

#i3 workspace names! Get them from your i3/congfig
W1=1:1:Firefox
W2=2:2:Consoles
W3=3:3:Godot
W4=4:4:CodeAssist
W5=5:5:Art
W6=6:6:TabWork
W7=7:7:TabOther
W8=8:8:TabMedia

SETUP_NAME="Escape From the Cosmic Abyss"
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

WORK_FOLDER=/mnt/24847D5F847D3500/Daniel/ProjetosGames/CursoUdemy/EscapeFromTheCosmicAbyss/
GODOT_PROJECT_FOLDER=GameSteam

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
cd $WORK_FOLDER/$GODOT_PROJECT_FOLDER
terminal


# Open Code
i3-msg workspace $W4
if [ $DUAL_MONITORS = "true" ]
then
    i3-msg move workspace to output $MONITOR_LEFT
fi
code .
while ! [[ "$(wmctrl -lx)" =~ "- Code - OSS" ]] 
do
    sleep 1
done


# Open Project folder and workflowy
i3-msg workspace $W6
if [ $DUAL_MONITORS = "true" ]
then
    i3-msg move workspace to output $MONITOR_LEFT
fi
i3-msg layout stacking
thunar $WORK_FOLDER &
while ! [[ "$(wmctrl -l)" =~ "File Manager" ]] 
do
    sleep 2
done
$WORKFLOWY &
while ! [[ "$(wmctrl -l)" =~ "WorkFlowy" ]] 
do
    sleep 2
done


# Open Browser and relevant tabs
i3-msg workspace $W1
if [ $DUAL_MONITORS = "true" ]
then
    i3-msg move workspace to output $MONITOR_LEFT
fi
i3-msg layout stacking
firefox --new-window "https://pomodoro-tracker.com/"
sleep 3
firefox --new-tab "https://docs.google.com/spreadsheets/"
sleep 1
firefox --new-tab "https://partner.steamgames.com/apps/landing/"
sleep 1
firefox --new-tab "https://itch.io/dashboard"
sleep 1

# Open Godot
i3-msg workspace $W3
if [ $DUAL_MONITORS = "true" ]
then
    i3-msg move workspace to output $MONITOR_RIGHT
fi
godot 32-steam
