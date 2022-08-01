#!/usr/bin/env bash

DIR_PATH=~/Wallpapers/
IMAGE_PATH=$(find $DIR_PATH -name '*.png' -o -name '*.jpg' | shuf -n 1)
convert $IMAGE_PATH -resize 1920x1080 -gravity center -background black -extent 1920x1080 RGB:- | i3lock -t --raw 1920x1080:rgb --image=/dev/stdin
date +"%Y-%m-%d %T - $IMAGE_PATH" >> ~/ScreenLockHistory.log