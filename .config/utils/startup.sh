#!/usr/bin/zsh

# shell options #

# keep "/" after completion of directories
setopt no_auto_remove_slash
# disable instant session-exit when using ctrl+d
setopt ignoreeof
# glob asterisk includes "."
setopt globdots
# skip duplications in history
setopt histignoredups
# do not save duplicated commands
setopt histsavenodups
# allow shared history for different sessions
setopt sharehistory

# autocompletion options #

# complete for "." and ".."
zstyle ':completion:*' special-dirs true
# kill command
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
# autocomplete unambiguous
zstyle ':autocomplete:*' insert-unambiguous yes
# use menu-complete for tabs
zstyle ':autocomplete:*' widget-style menu-complete

# environment variables #

# zsh
export ZDOTDIR="$HOME/.zsh"
export ZSHRC_HOME="$ZDOTDIR/.zshrc"
export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=99999
export SAVEHIST=99999

# zoxide
export _ZO_DATA_DIR="$HOME/.config/zoxide"

# nnn
export NNN_OPTS="deHi"
export NNN_BMS="d:$HOME/desktop;w:$HOME/downloads;c:$HOME/documents;p:$HOME/projects;a:$HOME/apps"

# rust
export RUSTUP_HOME="$HOME/apps/rust/rustup"
export CARGO_HOME="$HOME/apps/rust/cargo"

# misc
export EDITOR="/usr/local/bin/nvim"
export LESSHISTFILE="/dev/null"
export DOTFILES_HOME="$HOME/.dotfiles"
export PYTHONSTARTUP="$HOME/.config/python/startup.py"
export STARSHIP_CONFIG="$HOME/.config/starship/config.toml"

# update path #

PATH="$HOME/.local/bin:$PATH"
PATH="$CARGO_HOME/bin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="/usr/local/sbin:$PATH"

typeset -U path
export PATH

# === Source scripts
for script in $HOME/.config/utils/scripts/*.sh; do
    source $script
done
