source $HOME/.config/utils/startup.sh
source $HOME/.config/utils/scripts.sh
source $HOME/.config/utils/aliases.sh

# Disable marking untracked files under VCS as dirty. This makes repository
# status check for large repositories much, much faster [false]
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Load TYPEWRITTEN
fpath+=$HOME/.zsh/typewritten
autoload -U promptinit; promptinit
prompt typewritten

fpath=($fpath "$HOME/.zsh/.zfunctions")
