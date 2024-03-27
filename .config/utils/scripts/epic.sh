#!/usr/bin/zsh

epic() {
	if [[ "$1" == "games" ]]; then
		shift
		~/.config/legendary/games.py $@ "$(legendary list 2>/dev/null)"
	elif [[ "$1" == "installed" ]]; then
		games="$(~/.config/legendary/games.py --ini "$(legendary list 2>/dev/null)")"
		installed=( $(legendary list-installed | grep -Eoe ':[^\|]+\| V' | grep -Eoe '\w\w+' --color=never) )
		grepped=""

		for game in ${installed[@]}; do
			lines=( $(echo "$games" | grep "$game") )
			grepped+="|${lines[1]}"
		done

		~/.config/legendary/games.py "$(legendary list 2>/dev/null)" | grep -Ee "${grepped:1}" --color=never
	else
		legendary $@
	fi
}
