#!/usr/bin/zsh

mqps() {
    local topic="$1"
    local flag="$2"
    local data="$3"

    # check if data is for file
    if [[ "$flag" == "-f" || "$flag" == "--file" ]] && [[ -r "$data" ]]; then
        data=$(cat "$data")
    fi

    # if data is empty, treat flag as the message
    if [[ -z "$flag" ]]; then
        data="$flag"
    fi

    # start mosquitto_sub
    (echo -n "[$!] mosquitto_sub -t \"$topic\"\n[$!] mosquitto_pub -m " && mosquitto_sub -t "$topic" -C 1 & mosquitto_pub -t "$topic" -m "$data" 2>&1 >/dev/null)
}
