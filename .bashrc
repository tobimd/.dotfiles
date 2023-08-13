if [[ -n "$IN_NIX_SHELL" ]]; then
	export PS1='\[\e[90m\]nix:\[\e[0m\]\[\e[32m\]\w\[\e[0m\] \$ '
else
	export PS1='\[\e[90m\]bash:\[\e[0m\]\[\e[32m\]\w\[\e[0m\] \$ '
fi
