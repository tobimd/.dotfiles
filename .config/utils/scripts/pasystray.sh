#!/usr/bin/zsh

pasystray() {
    local procs=$(ps aux | grep pasystray | wc -l)
    local count=$(( $procs - 1 ))

    if (( $count == 0 )); then
        command pasystray
    fi
}
