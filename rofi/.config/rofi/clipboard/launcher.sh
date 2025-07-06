#!/usr/bin/env bash

# Kiểm tra clipboard có rỗng không
if [[ -z $(xclip -o -selection clipboard 2>/dev/null) ]]; then
  dunstify -h string:x-dunst-stack-tag:clip_notif -t 4000 -u critical "Clipboard Manager" "Clipboard is empty"
  exit
fi

dir="$HOME/.config/rofi/clipboard"

# Hiển thị danh sách clipboard history (dùng greenclip hoặc cliphist nếu có bản X11)
choice=$(echo -e "\t\uf1f8   Wipe Clipboard\n$(greenclip print)" | rofi -markup-rows -dmenu -display-columns 2 -theme ${dir}/clipboard.rasi)

if [[ $choice == *"Wipe Clipboard"* ]]; then
  yes=''
  no=''

  confirmation=$(echo -e "<span foreground='#a6e3a1'>$yes</span>\n<span foreground='#f38ba8'>$no</span>" |
    rofi -markup-rows -dmenu -p 'Confirmation' -mesg 'Are you Sure?' -theme ${dir}/confirmation.rasi)

  if [[ $confirmation =~ "$yes" ]]; then
    # Xóa clipboard
    echo -n "" | xclip -selection clipboard
    greenclip clear
    dunstify -h string:x-dunst-stack-tag:clip_notif -t 4000 -u critical "Clipboard Manager" "Clipboard has been wiped"
  fi
  exit
elif [[ -n $choice ]]; then
  echo "$choice" | xclip -selection clipboard
  # Dán bằng Ctrl+V
  xdotool key --clearmodifiers ctrl+shift+v
else
  exit
fi
