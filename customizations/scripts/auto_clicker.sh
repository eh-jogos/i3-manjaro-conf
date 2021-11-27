#!/usr/bin/env bash
# requires jq

function click_locations(){
	parameters=( "$@" )
	
	
	if [[ ${#parameters[@]} -eq 0 ]]
	then
		parameters[0]=""
	fi
	
	while true
	do
		for parameter in "${parameters[@]}"
		do
			xdotool $parameter click 1
		done
		sleep 0.0016
	done
}


click_locations ""