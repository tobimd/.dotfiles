#!/usr/bin/zsh

if [[ $OSTYPE == "linux-gnu"* ]]; then
    # Linux specific settings

elif [[ $OSTYPE == "darwin"* ]]; then
    # MacOS specific settings

    PATH="$PATH:/usr/local/Homebrew/bin"

    export LS_HOME="/usr/local/bin/gls"

    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_ENV_HINTS=1
    export HOMEBREW_AUTOREMOVE=1

else
    # Windows specific settings

fi

export DOTFILES_HOME="$HOME/.dotfiles"

export TYPEWRITTEN_PROMPT_LAYOUT="singleline_split"
export TYPEWRITTEN_RELATIVE_PATH="adaptive"
export TYPEWRITTEN_BRANCH_LEFT_SYMBOL="[ "
export TYPEWRITTEN_BRANCH_RIGHT_SYMBOL=" ]"
export TYPEWRITTEN_SQUASH_GIT_DIRECTORIES="0"
export TYPEWRITTEN_COLORS="git_branch:light;current_directory:green;symbol:light"
export TYPEWRITTEN_SYMBOL="$"

export ZDOTDIR="$HOME/.zsh"
export ZSHRC_HOME="$ZDOTDIR/.zshrc"
export EDITOR="/usr/local/bin/nvim"
export LESSHISTFILE="/dev/null"
export PYTHONSTARTUP="$HOME/.config/python/startup.py"
export DOCKER_HOST="unix:///$HOME/.local/share/containers/podman/machine/default/podman.sock"

PATH="$PATH:/usr/local/bin:/usr/local/sbin"
typeset -U path
export PATH
