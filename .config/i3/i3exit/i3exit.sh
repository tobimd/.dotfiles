#!/bin/sh

__lock() {
  /home/tobi/.config/i3/i3lock-fancy/i3lock-fancy -p -n -f 'JetBrains-Mono-Regular-Nerd-Font-Complete-Mono' -t 'password' -- scrot -z -o
}

case "$1" in
  lock)
    __lock
    ;;

  logout)
    i3-msg exit
    ;;

  suspend)
    __lock & systemctl suspend
    ;;

  hibernate)
    __lock & systemctl hibernate
    ;;

  reboot)
    systemctl reboot
    ;;

  shutdown)
    systemctl poweroff
    ;;

  *)
    echo "Usage: $0 {lock|logout|suspend|hibernate|reboot|shutdown}"
    exit 2
esac
exit 0
