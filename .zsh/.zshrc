source $ZDOTDIR/autocomplete/zsh-autocomplete.plugin.zsh
source $HOME/.config/utils/startup.sh
source $HOME/.config/utils/aliases.sh

#source $ZDOTDIR/zoxide/init.zsh

# Disable marking untracked files under VCS as dirty. This makes repository
# status check for large repositories much, much faster [false]
DISABLE_UNTRACKED_FILES_DIRTY="true"

unset WAYLAND_DISPLAY

fpath+=$HOME/.zsh/.zfunctions
fpath+=$HOME/.zsh/typewritten
autoload -U promptinit; promptinit
prompt typewritten

# Load zoxide
eval "$(zoxide init zsh)"

export PATH="/usr/local/opt/opencv@3/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/opencv@3/lib"
export CPPFLAGS="-I/usr/local/opt/opencv@3/include"

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# setup direnv
eval "$(direnv hook zsh)"
