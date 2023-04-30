source $ZDOTDIR/autocomplete/zsh-autocomplete.plugin.zsh
source $HOME/.config/utils/startup.sh
source $HOME/.config/utils/aliases.sh

#source $ZDOTDIR/zoxide/init.zsh

# Disable marking untracked files under VCS as dirty. This makes repository
# status check for large repositories much, much faster [false]
DISABLE_UNTRACKED_FILES_DIRTY="true"

unset WAYLAND_DISPLAY

# Load TYPEWRITTEN
fpath+=$HOME/.zsh/typewritten
autoload -U promptinit; promptinit
prompt typewritten

fpath=($fpath "$HOME/.zsh/.zfunctions")

# Load zoxide
eval "$(zoxide init zsh)"

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
