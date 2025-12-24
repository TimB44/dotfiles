#!/bin/bash
set -e
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UPDATE_SCRIPT="$DOTFILES_DIR/update-dotfiles.sh"
chmod +x "$UPDATE_SCRIPT"
(crontab -l 2>/dev/null | grep -v update-dotfiles || true; echo "*/30 * * * * $UPDATE_SCRIPT") | crontab -
echo "Cron installed: runs every 30 min"
