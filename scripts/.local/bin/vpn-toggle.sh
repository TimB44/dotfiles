#!/bin/bash
# Toggle lucid-static VPN connection

if nmcli connection show --active | grep -q "lucid-static"; then
    # VPN is connected, disconnect it
    nmcli connection down lucid-static
    notify-send "VPN" "Disconnected from lucid-static"
else
    # VPN is disconnected, connect it
    nmcli connection up lucid-static
    notify-send "VPN" "Connecting to lucid-static..."
fi
