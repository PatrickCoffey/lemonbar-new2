#!\bin\bash
# i3 panel config. Powerline style.

panel_fifo="/tmp/i3_lemonbar_${USER}"
geometry="x35"
font="monofur for Powerline-11"
iconfont="Ionicons-11"
iconfont2="FontAwesome-10"
iconfont3="OpenLogos-10"
res_w=$(xrandr | grep "current" | awk '{print $8a}')

# update setting, in seconds (conky update in i3_lemonbar_conky
upd_vol=3                           # Volume update
upd_bat=5                           # Battey update
upd_ssid=5                          # SSID update
upd_pac=1800                        # packages that need update
upd_aur=1800                        # aur packages that need update
upd_blu=5                           # bluetooth status
upd_mail=300                        # Mail check update
#upd_web=300                         # check internet access

# debug settings
#upd_vol=1
#upd_bat=1
#upd_ssid=1
#upd_pac=10
#upd_aur=10
#upd_blu=1
#upd_mail=1
#upd_web=1

# colours ( base16 - hopscotch )
base00="#322931"
base01="#433b42"
base02="#5c545b"
base03="#797379"
base04="#989498"
base05="#b9b5b8"
base06="#d5d3d5"
base07="#ffffff"
base08="#dd464c"
base09="#fd8b19"
base0A="#fdcc59"
base0B="#8fc13e"
base0C="#149b93"
base0D="#1290bf"
base0E="#c85e7c"
base0F="#b33508"

c_black="$base00"
c_grey1="$base01"
c_grey2="$base02"
c_grey3="$base03"
c_grey4="$base04"
c_grey5="$base05"
c_grey6="$base06"
c_white="$base07"
c_red_soft="$base08"
c_orange="$base09"
c_yellow="$base0A"
c_green="$base0B"
c_teal="$base0C"
c_blue="$base0D"
c_pink="$base0E"
c_red_bright="$base0F"

c_bg_l="$c_grey1"
c_bg_d="$c_black"
c_fg_l="$c_blue"
c_fg_d="$c_blue"


#default space between sections
stab=" "
dstab="  "

# Char glyps for powerline fonts
sep_left=""
sep_l_left=""
sep_right=""
sep_l_right=""

# actions
act_arch_c="./popup/lb_notify.sh sys"
act_wsp_1_c="echo wsp1"
act_wsp_2_c="echo wsp2"
act_wsp_3_c="echo wsp3"
act_wsp_4_c="echo wsp4"
act_wsp_5_c="echo wsp5"
act_wsp_6_c="echo wsp6"
act_wsp_7_c="echo wsp7"
act_wsp_8_c="echo wsp8"
act_wsp_9_c="echo wsp9"
act_wsp_0_c="echo wsp0"
act_title_c="echo title"
act_cpu_c="./popup/lb_notify.sh cpu"
act_mem_c="./popup/lb_notify.sh mem"
act_wifi_c="./popup/lb_notify.sh wifi"
act_wifi_noap_c="./popup/lb_notify.sh noap"
act_bat_c="./popup/lb_notify.sh bat"
act_vol_c="./popup/lb_notify.sh vol"
act_date_c="./popup/lb_notify.sh date"
act_time_c="./popup/lb_notify.sh time"
act_mail_c="./popup/lb_notify.sh mail"
act_pac_c="./popup/lb_notify.sh pac"
act_blu_c="./popup/lb_notify.sh blu"
act_web_c="./popup/lb_notify.sh web"
act_lock_c="~/bin/pixfflock"

# Icon glyphs
icon_arch="B"
icon_title=""
icon_clock=""
icon_calendar=""
icon_bat_empty=""
icon_bat_low=""
icon_bat_mid=""
icon_bat_full=""
icon_charging=""
icon_cpu=""
icon_mem=""
icon_mail=""
icon_mail_none=""
icon_chat=""
icon_chat_none=""
icon_pac=""
icon_aur=""
icon_vol_high=""
icon_vol_mid=""
icon_vol_low=""
icon_mute=""
icon_wifi=""
icon_web=""
icon_blu=""
icon_lock=""
icon_shutdown=""
