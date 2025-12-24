#!/bin/bash
# Show dunst notification history in rofi with dark theme

# Strip HTML tags and format notifications
dunstctl history | jq -r '.data[0][] |
    "\(.appname.data): \(.summary.data)\n  \(.body.data)\n---"' | \
    sed 's/<[^>]*>//g' | \
    sed 's/&nbsp;/ /g' | \
    sed 's/&amp;/\&/g' | \
    sed 's/https\?:\/\/[^ ]*//g' | \
    rofi -dmenu -p "Notifications" -i \
        -theme-str 'window {background-color: #1a1a1a; border-color: #333333;}' \
        -theme-str 'mainbox {background-color: #1a1a1a;}' \
        -theme-str 'inputbar {background-color: #2a2a2a; text-color: #ffffff;}' \
        -theme-str 'listview {background-color: #1a1a1a; text-color: #e0e0e0;}' \
        -theme-str 'element selected {background-color: #333333; text-color: #ffffff;}' \
        -width 50 -lines 20
