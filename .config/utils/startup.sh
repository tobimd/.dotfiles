#!/usr/bin/zsh

if [[ $OSTYPE == "linux-gnu"* ]]; then
    # Linux specific settings

elif [[ $OSTYPE == "darwin"* ]]; then
    # MacOS specific settings

    PATH="$PATH:/usr/local/Homebrew/bin"

    export LS_HOME="/usr/local/bin/gls"
    export SED_HOME="/usr/local/opt/gnu-sed/libexec/gnubin/sed"

    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_ENV_HINTS=1
    export HOMEBREW_AUTOREMOVE=1

else
    # Windows specific settings

fi

# Settings for zsh-autocomplete
# (marlonrichert/zsh-autocomplete.git)

# [no]: tab inserts the top completion.
#  yes: tab first inserts a substring common to all listed completions, if any
zstyle ':autocomplete:*' insert-unambiguous yes

# [complete-word]: (Shift-)Tab inserts the top (bottom) completion.
#   menu-complete: Press again to cycle to next (previous) completion.
#     menu-select: Same as `menu-complete`, but updates selection in menu.
zstyle ':autocomplete:*' widget-style menu-complete


# Misc/general path or setting env variables
export DOTFILES_HOME="$HOME/.dotfiles"
export ZDOTDIR="$HOME/.zsh"
export ZSHRC_HOME="$ZDOTDIR/.zshrc"
export EDITOR="/usr/local/bin/nvim"
export LESSHISTFILE="/dev/null"
export PYTHONSTARTUP="$HOME/.config/python/startup.py"

# Typewritten specific env variables
export TYPEWRITTEN_PROMPT_LAYOUT="singleline_split"
export TYPEWRITTEN_RELATIVE_PATH="adaptive"
export TYPEWRITTEN_BRANCH_LEFT_SYMBOL="[ "
export TYPEWRITTEN_BRANCH_RIGHT_SYMBOL=" ]"
export TYPEWRITTEN_SQUASH_GIT_DIRECTORIES="0"
export TYPEWRITTEN_COLORS="git_branch:light;current_directory:green;symbol:light"
export TYPEWRITTEN_SYMBOL="$"

PATH="/usr/local/bin:/usr/local/sbin:$HOME/.cargo/bin:$PATH"
typeset -U path
export PATH
