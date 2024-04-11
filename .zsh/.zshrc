source $ZDOTDIR/autocomplete/zsh-autocomplete.plugin.zsh
source $HOME/.config/utils/linux.sh
source $HOME/.config/utils/macos.sh
source $HOME/.config/utils/startup.sh
source $HOME/.config/utils/aliases.sh

# Disable marking untracked files under VCS as dirty. This makes repository
# status check for large repositories much, much faster [false]
DISABLE_UNTRACKED_FILES_DIRTY="true"
unset WAYLAND_DISPLAY

fpath+=$HOME/.zsh/.zfunctions

# Load zoxide
eval "$(zoxide init zsh)"
# setup direnv
eval "$(direnv hook zsh)"
# setup starship (prompt)
eval "$(starship init zsh)"

[ -f "$ZDOTDIR/fzf/.fzf.zsh" ] && source "$ZDOTDIR/fzf/.fzf.zsh"
