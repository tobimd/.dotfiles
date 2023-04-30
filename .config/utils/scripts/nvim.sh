#!/usr/bin/zsh

nvim() {
    local args=()

    for v in $@; do
        if [[ -h $v ]]; then
            args+=( `readlink $v` )
        else
            args+=( $v )
        fi
    done

    ${NVIM_HOME:-/usr/local/bin/nvim} -p "${args[@]}"
}
