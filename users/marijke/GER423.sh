#!/usr/bin/env bash

set -euxo pipefail

LAPTOPPORT=eDP-1
MONITORPORT=DP-2

CONFIG_NAME="GER423"
PRIMARY="${LAPTOPPORT}"

autorandr --match-edid --load "${CONFIG_NAME}"

xfconf-query -c "xfce4-panel" -p "/panels/panel-1/icon-size" -s "12"
xfconf-query -c "xfce4-panel" -p "/panels/panel-1/output-name" -s "${PRIMARY}"
xfconf-query -c "xfce4-panel" -p "/panels/panel-1/size" -s "24"

xfconf-query -c "xsettings" -p "/Gtk/FontName" -s "Sans 10"
xfconf-query -c "xsettings" -p "/MonospaceFontName" -s "Gtk/JetBrainsMono Nerd Font Medium 10"
xfconf-query -c "xsettings" -p "/Net/IconThemeName" -s "Adwaita"
xfconf-query -c "xsettings" -p "/Net/ThemeName" -s "Adwaita-dark"

dconf write \
      /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/font \
      "'JetBrainsMono Nerd Font 13'"

cp other.xml "${HOME}/.config/JetBrains/PyCharmCE2025.1/options"

#pycharm-community &
#gnome-terminal --geometry 135x30+2100+1400 &

