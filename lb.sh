#! /bin/bash
#
# I3 bar with https://github.com/LemonBoy/bar

. $(dirname $0)/lb_config.sh

if [ $(pgrep -cx $(basename $0)) -gt 1 ] ; then
    printf "%s\n" "The status bar is already running." >&2
    exit 1
fi

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

[ -e "${panel_fifo}" ] && rm "${panel_fifo}"
mkfifo "${panel_fifo}"

### EVENTS METERS

# Window title, "WIN"
xprop -spy -root _NET_ACTIVE_WINDOW | sed -un 's/.*\(0x.*\)/WIN\1/p' > "${panel_fifo}" &

# i3 Workspaces, "WSP"
$(dirname $0)/i3_workspaces.py > ${panel_fifo} &

# Conky, "SYS"
conky -c $(dirname $0)/lb_conky > "${panel_fifo}" &

### UPDATE INTERVAL METERS
cnt_vol=${upd_vol}
cnt_mail=${upd_mail}
cnt_bat=${upd_bat}
cnt_ssid=${upd_ssid}
cnt_pac=${upd_pac}
cnt_aur=${upd_aur}
cnt_blu=${upd_blu}
cnt_web=${upd_web}

while :; do
    
  # Volume, "VOL"
  if [ $((cnt_vol++)) -ge ${upd_vol} ]; then
    echo "VOL$(alsa-status)" > "${panel_fifo}" &
    cnt_vol=0
  fi

  # Battey, "BAT"
  if [ $((cnt_bat++)) -ge ${upd_bat} ]; then
    echo "$(batstat)" > "${panel_fifo}" &
    cnt_bat=0
  fi

  # SSID, "SID"
  if [ $((cnt_ssid++)) -ge ${upd_ssid} ]; then
    echo "SID$(iwgetid -r)" > "${panel_fifo}" &
    cnt_ssid=0
  fi

  # Gmail (number of unread)
  if [ $((cnt_mail++)) -ge ${upd_mail} ]; then
    echo "GMA$(gmail.sh)" > "${panel_fifo}" &
    cnt_mail=0
  fi

  # pacman packages
  if [ $((cnt_pac++)) -ge ${upd_pac} ]; then
    echo "PAC$(pacman -Qu | wc -l)" > "${panel_fifo}" &
    cnt_pac=0
  fi  

  # aur  packages
  if [ $((cnt_aur++)) -ge ${upd_aur} ]; then
    echo "AUR$(cower -u | wc -l)" > "${panel_fifo}" &
    cnt_aur=0
  fi  

  # bluetooth
  if [ $((cnt_blu++)) -ge ${upd_blu} ]; then
    echo "BLU$(bluetooth | cut -d ' ' -f 3)" > "${panel_fifo}" &
    cnt_blu=0
  fi

  # internet access
  #if [ $((cnt_web++)) -ge ${upd_web} ]; then
  #  echo "WEB$(checkweb.sh)" > "${panel_fifo}" &
  #  cnt_web=0
  #fi

  # Finally, wait 1 second
  sleep 1s;

done &

# start lemonbar
cat "${panel_fifo}" | $(dirname $0)/lb_parser.sh \
 | lemonbar -p -f "${font}" -f "${iconfont}" -f "${iconfont2}" -f "${iconfont3}" \
 -g "${geometry}" -B "${c_bg_d}" -F "${c_fg_d}" -u 3 \
 | while read line; do eval $line; done

wait

