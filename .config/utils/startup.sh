#!/usr/bin/zsh

# === Os specific settings
if [[ $OSTYPE == "linux-gnu"* ]]; then
    mkdir -p /tmp/downloads /tmp/screenshots /tmp/trash

    # KP_Delete (keypad - delete) now ":"
    xmodmap -e "keycode 91 = period colon"

    # bind DELETE key
    bindkey "^[[3~" delete-char
    # bind HOME key
    bindkey "^[[H" beginning-of-line
    # bind END key
    bindkey "^[[F" end-of-line

elif [[ $OSTYPE == "darwin"* ]]; then
    export LS_HOME="/usr/local/bin/gls"
    export SED_HOME="/usr/local/opt/gnu-sed/libexec/gnubin/sed"

    # Homebrew
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_ENV_HINTS=1
    export HOMEBREW_AUTOREMOVE=1

    # Gem
    export GEM_HOME="$HOME/.config/gem"

    # Android Studio
    export ANDROID_HOME="$HOME/Library/Android/sdk"
    export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
    export ANDROID_AVD_HOME="$HOME/.android/avd"

    PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
    PATH="/usr/local/Homebrew/bin:$PATH"
    PATH="$GEM_HOME/bin:$PATH"

    alias ip='ipconfig getifaddr en0'
fi

# === Shell options
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

# === Autocompletion options
# complete for "." and ".."
zstyle ':completion:*' special-dirs true
# kill command
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
# autocomplete unambiguous
zstyle ':autocomplete:*' insert-unambiguous yes
# use menu-complete for tabs
zstyle ':autocomplete:*' widget-style menu-complete

# === Environment variables
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

# flutter
export PUB_CACHE="$HOME/Projects/ipfs_http_rpc/.dart_tool/dart-sdk/cache"
export FLUTTER_SUPPRESS_ANALYTICS="true"

# typewritten prompt
export TYPEWRITTEN_PROMPT_LAYOUT="singleline_split"
export TYPEWRITTEN_RELATIVE_PATH="adaptive"
export TYPEWRITTEN_BRANCH_LEFT_SYMBOL="[ "
export TYPEWRITTEN_BRANCH_RIGHT_SYMBOL=" ]"
export TYPEWRITTEN_SQUASH_GIT_DIRECTORIES="0"
export TYPEWRITTEN_COLORS="git_branch:light;current_directory:green;symbol:light"
export TYPEWRITTEN_SYMBOL='$'

# === Update path
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
