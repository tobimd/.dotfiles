# silence useless warning in mac
export BASH_SILENCE_DEPRECATION_WARNING=1

curl() { command curl "$@"; echo; }

# change prompt
if [[ -n "$IN_NIX_SHELL" ]]; then
	export PS1='\[\e[90m\]nix:\[\e[0m\]\[\e[32m\]\w\[\e[0m\] \$ '
else
	export PS1='\[\e[90m\]bash:\[\e[0m\]\[\e[32m\]\w\[\e[0m\] \$ '
fi
