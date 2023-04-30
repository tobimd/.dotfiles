#!/usr/bin/zsh

startvenv() {
    local dir=$(realpath $1)
    local act=""

    if [[ -d "$dir/bin" && -a "$dir/bin/activate" ]]; then
	act="$dir/bin/activate"
	dir="$dir/bin"
    elif [[ -a "$dir/activate" ]]; then
        act="$dir/activate"
    elif [[ -d "$dir/.env/bin" && -a "$dir/.env/bin/activate" ]]; then
        act="$dir/.env/bin/activate"
	dir="$dir/.env/bin"
    else
        echo -e "couldn't find \x1b[1mvenv\x1b[0m directory."
        return 1
    fi

    if [[ $act != "" ]]; then
	PATH="$dir:$PATH"
	typeset -U path
	export PATH
	source $act
    fi
}
