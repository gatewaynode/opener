#!/usr/bin/env bash

if [ -d "$1" ]; then
	tree -L 3 "$1"
else
	bat --color=always --style=numbers --line-range=:500 "$1"
fi
