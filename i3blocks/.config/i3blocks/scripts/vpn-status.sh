#!/bin/bash
# Show VPN status (read-only)

# Check if VPN is connected
if nmcli connection show --active | grep -q "lucid-static"; then
    echo "VPN: ON"
    echo "VPN: ON"
    echo "#00ff00"  # Green color
else
    echo "VPN: OFF"
    echo "VPN: OFF"
    echo "#888888"  # Gray color
fi
