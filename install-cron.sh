#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UPDATE_SCRIPT="$DOTFILES_DIR/update-dotfiles.sh"

(crontab -l 2>/dev/null | grep -v update-dotfiles || true; echo "*/30 * * * * $UPDATE_SCRIPT") | crontab -
echo "Automatic dotfiles updates enabled."
