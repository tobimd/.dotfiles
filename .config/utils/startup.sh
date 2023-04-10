#!/usr/bin/zsh

# Linux specific settings
if [[ $OSTYPE == "linux-gnu"* ]]; then
    mkdir -p /tmp/downloads /tmp/screenshots

    # bind DELETE key (Supr)
    bindkey "^[[3~" delete-char

    # bind HOME key (Inicio)
    bindkey "^[[H" beginning-of-line

    # bind END key (Fin)
    bindkey "^[[F" end-of-line
    
    # Rust
    export RUSTUP_HOME="$HOME/apps/rust/rustup"
    export CARGO_HOME="$HOME/apps/rust/cargo"

    PATH="$PATH:$HOME/.local/bin"
    PATH="$PATH:$HOME/apps/rust/cargo/bin"

# MacOS specific settings
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

    # Rust
    export RUSTUP_HOME="$HOME/.apps/rust/rustup"
    export CARGO_HOME="$HOME/.apps/rust/cargo"

    PATH="/usr/local/Homebrew/bin:$PATH"
    PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
    PATH="$GEM_HOME/bin:$PATH"
    PATH="$PATH:$HOME/.apps/rust/cargo/bin"

# Windows specific settings
else

fi

# retain the / added after completing
# directories or symbolic links to directories
setopt no_auto_remove_slash

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

# Common paths
PATH="$HOME/apps/rust/cargo/bin:/usr/local/bin:/usr/local/sbin:$PATH"

# Base environment variables
export EDITOR="/usr/local/bin/nvim"
export LESSHISTFILE="/dev/null"
export DOTFILES_HOME="$HOME/.dotfiles"
export ZDOTDIR="$HOME/.zsh"
export ZSHRC_HOME="$ZDOTDIR/.zshrc"
export PYTHONSTARTUP="$HOME/.config/python/startup.py"
export _ZO_DATA_DIR="$HOME/.config/zoxide"

export RUSTUP_HOME="$HOME/apps/rust/rustup"
export CARGO_HOME="$HOME/apps/rust/cargo"

# Flutter variables
export PUB_CACHE="$HOME/Projects/ipfs_http_rpc/.dart_tool/dart-sdk/cache"
export FLUTTER_SUPPRESS_ANALYTICS="true"

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
