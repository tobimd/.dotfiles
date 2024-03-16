#!/usr/bin/zsh

epic() {
	if [[ "$1" == "games" ]]; then
		shift
		legendary list 2>/dev/null | ~/.config/legendary/games.py $@
	else
		legendary $@
	fi
}
