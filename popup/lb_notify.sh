#!/bin/bash

# source config
. "$(dirname $0)/../lb_config.sh"

case $1 in
  sys*)
    rofi -show run -lines 3 -eh 2 -width 100 -padding 800 -opacity 80 -bw 0 -font 'monofur for Powerline 22'
    ;;
  wifi*)
    urxvt -geometry 80x28-10+45 -name "floating_urxvt" -e "wavemon"
    ;;
  noap*)
    urxvt -geometry 95x20-10+45 -name "floating_urxvt" -e "wicd-curses"
    ;;
  cpu*)
    urxvt -geometry 80x30-10+45 -name "floating_urxvt" -e "htop"
    ;;
  dat*)
    urxvt -geometry 80x30-10+45 -name "floating_urxvt" -e 'calcurse'
    ;;
  tim*)
    urxvt -geometry 49x23-10+45 -name "floating_urxvt" -e 'tty-qlock'
    ;;
  bat*)
    urxvt -geometry 75x25-10+45 -name "floating_urxvt" -e bash -c '~/bin/bat_upower.sh'
    ;;
  vol*)
    urxvt -geometry 70x8-10+45 -name "floating_urxvt" -e "pulsemixer"
    ;;
  mail*)
    urxvt -geometry 80x30-10+45 -name "floating_urxvt" -e "mutt"
    ;;
  blu*)
    #urxvt -geometry 50x2-10+45 -name "floating_urxvt" -e bash -c '~/bin/bt_toggle_show.sh'
    bluetooth toggle
    ;;
esac
