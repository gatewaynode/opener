#!/usr/bin/env bash

if [ -d "$1" ]; then
	tree -a -L 3 "$1"
else
	BAT_TEST=$(file --mime "$1")
	if [[ $BAT_TEST == *binary ]] ; then
		hexyl -n 4kB "$1"
	else
		bat --color=always --style=numbers --line-range=:500 "$1"
	fi
fi
