#!/bin/sh

# Enable visual terminal bell
gsettings set org.gnome.desktop.wm.preferences audible-bell false
gsettings set org.gnome.desktop.wm.preferences visual-bell true
gsettings set org.gnome.desktop.wm.preferences visual-bell-type frame-flash

# No blinking cursor
gsettings set org.gnome.desktop.interface cursor-blink false

# Show date in toolbar
gsettings set org.gnome.desktop.interface clock-show-date true

# Show week number in toolbar calendar
gsettings set org.gnome.shell.calendar show-weekdate true

# Disable screensaver
gsettings set org.gnome.desktop.screensaver idle-activation-enabled false
gsettings set org.gnome.desktop.session idle-delay 0

# Disable Ctrl+Alt+Delete
gsettings set org.gnome.settings-daemon.plugins.media-keys logout ''

# Always show log out
gsettings set org.gnome.shell always-show-log-out true

# Set desktop wallpaper
gsettings set org.gnome.desktop.background color-shading-type vertical
#gsettings set org.gnome.desktop.background picture-uri file://$HOME/Pictures/Club-Mate.png
#gsettings set org.gnome.desktop.background picture-options centered
gsettings set org.gnome.desktop.background primary-color '#555555'
gsettings set org.gnome.desktop.background secondary-color '#000000'

# Set favorites
gsettings set org.gnome.shell favorite-apps "['gnome-terminal.desktop', 'emacs.desktop', 'firefox.desktop', 'nautilus.desktop']"
