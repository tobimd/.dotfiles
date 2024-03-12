#!/usr/bin/zsh

[[ $ZSH_EVAL_CONTEXT =~ :file$ ]] && sourced="true" || sourced="false"

pasystray() {
    local procs=$(ps aux | grep pasystray | wc -l)
    local count=$(( $procs - 1 ))

    if (( $count == 0 )); then
        command pasystray
    fi
}

if (( "$sourced" == "false" )); then
    pasystray
fi
