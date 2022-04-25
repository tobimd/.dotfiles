source $HOME/.config/utils/startup
source $HOME/.config/utils/env

export ZSH="$ZDOTDIR/.oh-my-zsh"

ZSH_THEME=""

# Use case-sensitive completion [false]
CASE_SENSITIVE="false"

# Use hyphen-insensitive completion [false].
HYPHEN_INSENSITIVE="true"

# Disable marking untracked files under VCS as dirty. This makes repository
# status check for large repositories much, much faster [false]
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git python pip npm gitignore docker gitfast history sudo  )

# Source any other files automatically
source $HOME/.config/utils/utils
source $ZDOTDIR/.oh-my-zsh/oh-my-zsh.sh

# Load Typewritten prompt
fpath+=$ZDOTDIR/.oh-my-zsh/custom/typewritten-prompt
autoload -U promptinit; promptinit
prompt typewritten

# General aliases
alias ls="$LS_HOME -FAGgHopX --color=always --group-directories-first --si"
alias la="$LS_HOME -FAGHpXC --color=always --group-directories-first --si"
alias lo="$LS_HOME -FX --color=always --group-directories-first --si"
alias zsource="source $ZDOTDIR/.zshrc"
alias vim="$NEOVIM_HOME"
alias wget="wget --hsts-file=$HOME/.hsts/.wget-hsts"
alias today="date +'%A %d/%m/%y - %T'"

# Python aliases
alias python="python3"
alias py="python3"
alias pip="python3 -m pip"
alias idle="idle3.9"
alias venv-create="py -m venv"
alias venv-stop="deactivate"  # to start: venv-init

# Git aliases
alias glst="git ls-tree --full-tree --name-only -r HEAD"

# Flutter aliases
alias flutter="fvm flutter"
alias dart="fvm dart"
alias fvmpg="fvm flutter pub get"
alias fvmpa="fvm flutter pub add"
alias fvmd="fvm flutter doctor"
alias fvmr="fvm flutter run"
alias fvmrv="fvm flutter run --verbose"
alias fvmu="fvm use"
alias fvml="fvm list"

fpath=($fpath "/home/tobi/.zsh/.zfunctions")
