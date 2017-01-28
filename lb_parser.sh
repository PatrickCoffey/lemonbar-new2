#!/bin/bash
#
# Input parser for i3 bar
# 14 ago 2015 - Electro7
# modified from copperbadger by schlerp

# config
. $(dirname $0)/lb_config.sh

# min init
irc_n_high=0
# title="%{F${color_head} B${color_sec_b2} T3}${sep_right}%{F${color_head} B${color_sec_b2}}%{T2} ${icon_prog} %{F${color_sec_b2} B- T3}${sep_right}%{F- B- T1}"
#title="%{F${color_head} B${color_sec_b2} T2} ${icon_prog} %{T1}"

# fonts
f_text="%{T1}"
f_icon="%{T2}"
f_icon2="%{T3}"

# style segments
n_black="%{ B${c_black} F${c_black} }"
n_grey1="%{ B${c_black} F${c_grey1} }"
n_grey2="%{ B${c_black} F${c_grey2} }"
n_grey3="%{ B${c_black} F${c_grey3} }"
n_grey4="%{ B${c_black} F${c_grey4} }"
n_grey5="%{ B${c_black} F${c_grey5} }"
n_grey6="%{ B${c_black} F${c_grey6} }"
n_white="%{ B${c_black} F${c_white} }"
n_red_soft="%{ B${c_black} F${c_red_soft} }"
n_orange="%{ B${c_black} F${c_orange} }"
n_yellow="%{ B${c_black} F${c_yellow} }"
n_green="%{ B${c_black} F${c_green} }"
n_teal="%{ B${c_black} F${c_teal} }"
n_blue="%{ B${c_black} F${c_blue} }"
n_pink="%{ B${c_black} F${c_pink} }"
n_red_bright="%{ B${c_black} F${c_red_bright} }"

h_black="%{ B${c_white} F${c_white} }"
h_grey1="%{ B${c_white} F${c_grey1} }"
h_grey2="%{ B${c_white} F${c_grey2} }"
h_grey3="%{ B${c_white} F${c_grey3} }"
h_grey4="%{ B${c_white} F${c_grey4} }"
h_grey5="%{ B${c_white} F${c_grey5} }"
h_grey6="%{ B${c_white} F${c_grey6} }"
h_white="%{ B${c_white} F${c_white} }"
h_red_soft="%{ B${c_white} F${c_red_soft} }"
h_orange="%{ B${c_white} F${c_orange} }"
h_yellow="%{ B${c_white} F${c_yellow} }"
h_green="%{ B${c_white} F${c_green} }"
h_teal="%{ B${c_white} F${c_teal} }"
h_blue="%{ B${c_grey1} F${c_blue} }"
h_pink="%{ B${c_white} F${c_pink} }"
h_red_bright="%{ B${c_white} F${c_red_bright} }"

# seperators for the segments
# fore ground colour is previous sections background
# back ground is next sections background colour
# title
# pacaur
# mailchat
# connection
# system
# vol
# bat
# datetime
# buttons

#sep_title="%{ B${} F${} }"
#sep_pacaur="%{ B${} F${} }"
#sep_mailchat="%{ B${} F${} }"
#sep_connection="%{ B${} F${} }"
#sep_system="%{ B${} F${} }"
#sep_vol="%{ B${} F${} }"
#sep_bat="%{ B${} F${} }"
#sep_datetime="%{ B${} F${} }"
#sep_buttons="%{ B${} F${} }"

# parser main loop
while read -r line ; do
  case $line in
    SYS*)
      #=========================================================================
      # conky=, 0 = wday, 1 = mday, 2 = month, 3 = time, 4 = cpu, 5 = mem, 6 = disk /, 7 = disk /home, 8-9 = up/down wlan, 10-11 = up/down eth, 12-13=speed
      sys_arr=(${line#???})

      date="${sys_arr[0]} ${sys_arr[1]} ${sys_arr[2]}"
      s_date="${f_icon}${icon_calendar}${f_text} ${date}"

      s_time="${f_icon}${icon_clock}${f_text} ${sys_arr[3]}"
      
      if [[ ${sys_arr[4]} -gt 94 ]]; then
        s_cpu="${n_red_bright}${f_icon}${icon_cpu}${f_text} ${sys_arr[4]}%${n_grey5}"
      elif [[ ${sys_arr[4]} -gt 74 ]]; then
        s_cpu="${n_orange}${f_icon}${icon_cpu}${f_text} ${sys_arr[4]}%${n_grey5}"
      elif [[ ${sys_arr[4]} -gt 49 ]]; then
        s_cpu="${n_yellow}${f_icon}${icon_cpu}${f_text} ${sys_arr[4]}%${n_grey5}"
      else
        s_cpu="${f_icon}${icon_cpu}${f_text} ${sys_arr[4]}%"
      fi

      if [[ ${sys_arr[6]} -gt 95 ]]; then
        s_mem="${n_red_bright}${f_icon}${icon_mem}${f_text} ${sys_arr[5]}${n_grey5}"
      elif [[ ${sys_arr[6]} -gt 74 ]]; then
        s_mem="${n_orange}${f_icon}${icon_mem}${f_text} ${sys_arr[5]}${n_grey5}"
      elif [[ ${sys_arr[6]} -gt 49 ]]; then
        s_mem="${n_yellow}${f_icon}${icon_mem}${f_text} ${sys_arr[5]}${n_grey5}"
      else
        s_mem="${f_icon}${icon_mem}${f_text} ${sys_arr[5]}"      
      fi
      ;;

    VOL*)
      #=========================================================================
      # Volume:
      #   [0] Muted indicator: (M=Muted / (anything else)=Unmuted)
      #   [1] On/off (muted) status (1=Unmuted / 0=Muted)
      vol_arr=(${line#???})
      vol_frg=-
      vol_oln=-
      if [[ ${vol_arr[0]} == "M" ]]; then
        s_vol="${n_grey2}${f_icon}${icon_vol_mute}${f_text} ${vol_arr[1]}${n_grey5}"
      else
        if [[ ${vol_arr[1]} -gt 66 ]]; then
          s_vol="${f_icon}${icon_vol_high}${f_text} ${vol_arr[1]}"
        elif [[ ${vol_arr[1]} -gt 33 ]]; then
          s_vol="${f_icon}${icon_vol_mid}${f_text} ${vol_arr[1]}"
        else
          s_vol="${f_icon}${icon_vol_low}${f_text} ${vol_arr[1]}"
        fi
      fi
      ;;

    GMA*)
      # Gmail
      gmail="${line#???}"
      if [[ ${gmail} == 0 ]]; then
        s_gmail="${n_grey2}${f_icon}${icon_mail_none}${f_text} ${gmail}${n_grey5}"
      else
        s_gmail="${n_grey5}${f_icon}${icon_mail}${f_text} ${gmail}"
      fi
      ;;

    # MPD*)
      # Music
      # mpd_arr=(${line#???})
      #if [ -z "${line#???}" ]; then
      #  song="none";
      #elif [ "${mpd_arr[1]}" == "error:" ]; then
      #  song="mpd off";
      #else
      #  song="${line#???}";
      #fi
      #mpd="%{T2}${icon_music} %{F- T1}  ${song}"
      ## echo "Setting music display to ${song}" >> bar.log
      #;;

    BAT*)
      #=========================================================================
      # Battery readout:
      #   [0] = integer part
      #   [1] = charging status (D(ischarging), C(harging))
      #   [2] = power level (F(ull), N(ormal), L(ow), C(ritical))
      bat_arr=(${line#???})
      if [[ ${bat_arr[2]} == "F" ]]; then
        s_bat="${f_icon}${icon_bat_full}${f_text} ${bat_arr[0]}%"
      elif [[ ${bat_arr[2]} == "N" ]]; then
        s_bat="${f_icon}${icon_bat_mid}${f_text} ${bat_arr[0]}%"
      elif [[ ${bat_arr[2]} == "L" ]]; then
        s_bat="${n_orange}${f_icon}${icon_bat_low}${f_text} ${bat_arr[0]}%${n_grey5}"
      elif [[ ${bat_arr[2]} == "C" ]]; then
        s_bat="${n_red_bright}${f_icon}${icon_bat_empty}${f_text} ${bat_arr[0]}%${n_grey5}"
      fi

      if [[ ${bat_arr[1]} == "C" ]]; then
        s_bat="${n_green}${f_icon}${icon_charging}${f_text} ${bat_arr[0]}%${n_grey5}"
      fi
      ;;

    WSP*)
      #=========================================================================
      # I3 Workspaces
      wsp="${n_grey5}"
      set -- ${line#???}
      while [ $# -gt 0 ] ; do
        case $1 in
         FOC*)
           wsp="${wsp}${h_blue} ${1#???} "
           ;;
         INA*|URG*|ACT*)
           wsp="${wsp}${n_grey5} ${1#???} "
           ;;
        esac
        shift
      done
      s_wsp="${wsp}${n_grey5}"
      ;;
      
    WIN*)
      #=========================================================================
      # window title
      title=$(xprop -id ${line#???} | awk '/_NET_WM_NAME/{$1=$2="";print}' | cut -d'"' -f2)
      s_title=">>> ${title}"
      ;;

    SID*)
      if [[ ${line#???} == "" ]]; then
        s_ssid="${n_grey2}${f_icon}${icon_wifi}${f_text} No AP${n_grey5}"
      else
        s_ssid="${f_icon}${icon_wifi}${f_text} ${line#???}"
      fi
      ;;
      
    BLU*)
      if [[ ${line#???} == "on" ]]; then
        s_blu="${n_blue}${f_icon}${icon_blu}${f_text}${n_grey5}"
      else
        s_blu="${n_grey2}${f_icon}${icon_blu}${f_text}${n_grey5}"
      fi
      ;;
      
    AUR*)
      if [[ ${line#???} -gt 10 ]]; then
        s_aur="${n_red_bright}${f_icon}${icon_aur}${f_text} ${line#???}${n_grey5}"
      elif [[ ${line#???} -gt 5 ]]; then
        s_aur="${n_orange}${f_icon}${icon_aur}${f_text} ${line#???}${n_grey5}"
      elif [[ ${line#???} -gt 0 ]]; then
        s_aur="${n_yellow}${f_icon}${icon_aur}${f_text} ${line#???}${n_grey5}"
      else
        s_aur="${n_grey5}${f_icon}${icon_aur}${f_text} ${line#???}${n_grey5}"
      fi
      ;;
      
    PAC*)
      if [[ ${line#???} -gt 10 ]]; then
        s_pac="${n_red_bright}${f_icon}${icon_pac}${f_text} ${line#???}${n_grey5}"
      elif [[ ${line#???} -gt 5 ]]; then
        s_pac="${n_orange}${f_icon}${icon_pac}${f_text} ${line#???}${n_grey5}"
      elif [[ ${line#???} -gt 0 ]]; then
        s_pac="${n_yellow}${f_icon}${icon_pac}${f_text} ${line#???}${n_grey5}"
      else
        s_pac="${n_grey5}${f_icon}${icon_pac}${f_text} ${line#???}${n_grey5}"
      fi
      ;;
      
  esac

  # LOCK
  s_lock="${f_icon}${icon_lock}${f_text}"
  
  # shutdown button
  s_shutdown="${f_icon}${icon_shutdown}${f_text}"

  # And finally, output
  printf "%s\n" "%{l}${s_wsp} ${s_title}%{r} ${s_pac} ${s_aur}  %{A:${act_mail_c}:}${s_gmail}%{A}  %{A:${act_blu_c}:}${s_blu}%{A} %{A:${act_wifi_c}:}${s_ssid}%{A}  %{A:${act_cpu_c}:}${s_cpu} ${s_mem}%{A}  %{A:${act_vol_c}:}${s_vol}%{A}  %{A:${act_bat_c}:}${s_bat}%{A}  %{A:${act_date_c}:}${s_date} ${s_time}%{A}  %{A:${act_lock_c}:}${s_lock}%{A} ${s_shutdown}"
done






