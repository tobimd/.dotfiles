#!/usr/bin/zsh

git() {
    if [[ "$PWD" == "$HOME" ]]; then
        if [[ "$1" == "clone" ]];then
            /usr/local/bin/git "$@"

        elif [[ "$1" == "add" && "$2" == "--all" ]]; then
            /usr/local/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" add --update

        elif [[ "$1" == "status" ]]; then
            shift
            /usr/local/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" status -uno "$@"

        else            
            /usr/local/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
        fi

    else
        /usr/local/bin/git "$@"
    fi
}
