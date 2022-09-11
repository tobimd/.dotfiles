#!/usr/bin/zsh

if [[ $OSTYPE == "linux-gnu"* ]]; then
    # Linux specific settings

    PATH="$PATH:$HOME/.local/bin"

    # bind DELETE key (Supr)
    bindkey "^[[3~" delete-char

    # bind HOME key (Inicio)
    bindkey "^[[H" beginning-of-line

    # bind END key (Fin)
    bindkey "^[[F" end-of-line


elif [[ $OSTYPE == "darwin"* ]]; then
    # MacOS specific settings

    PATH="/usr/local/Homebrew/bin:$PATH"
    PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

    export LS_HOME="/usr/local/bin/gls"

    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_ENV_HINTS=1
    export HOMEBREW_AUTOREMOVE=1

else
    # Windows specific settings

fi

# retain the / added after completing
# directories or symbolic links to directories
setopt no_auto_remove_slash


# Common paths (separated for readiblity)
PATH="$PATH:$HOME/.apps/flutter/bin"
PATH="$PATH:$HOME/.apps/rust/cargo/bin"
PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Settings for zsh-autocomplete
# (marlonrichert/zsh-autocomplete.git)

# complete . and .. special directories
zstyle ':completion:*' special-dirs true

# kill command
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# [no]: tab inserts the top completion.
# yes: tab first inserts a substring common to
#  	all listed completions, if any
zstyle ':autocomplete:*' insert-unambiguous yes

# [complete-word]: (Shift-)Tab inserts the top
# 	(bottom) completion. menu-complete: Press again
# 	to cycle to next (previous) completion.
# menu-select: Same as `menu-complete`, but
#     	updates selection in menu.
zstyle ':autocomplete:*' widget-style menu-complete

# Base environment variables
export EDITOR="/usr/local/bin/nvim"
export LESSHISTFILE="/dev/null"

# Locations
export DOTFILES_HOME="$HOME/.dotfiles"
export RUSTUP_HOME="$HOME/.apps/rust/rustup"
export CARGO_HOME="$HOME/.apps/rust/cargo"
export ZDOTDIR="$HOME/.zsh"
export ZSHRC_HOME="$ZDOTDIR/.zshrc"
export PUB_CACHE="$HOME/.apps/flutter/pub-cache"
export FLUTTER_HOME="$HOME/.apps/flutter"
export PYTHONSTARTUP="$HOME/.config/python/startup.py"

# Typewritten specific env variables
export TYPEWRITTEN_PROMPT_LAYOUT="singleline_split"
export TYPEWRITTEN_RELATIVE_PATH="adaptive"
export TYPEWRITTEN_BRANCH_LEFT_SYMBOL="[ "
export TYPEWRITTEN_BRANCH_RIGHT_SYMBOL=" ]"
export TYPEWRITTEN_SQUASH_GIT_DIRECTORIES="0"
export TYPEWRITTEN_COLORS="git_branch:light;current_directory:green;symbol:light"
export TYPEWRITTEN_SYMBOL="$"

typeset -U path
export PATH
