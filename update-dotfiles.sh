#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

notify_failure() {
  if [[ -x "$DOTFILES_DIR/notify-update-failure.sh" ]]; then
    "$DOTFILES_DIR/notify-update-failure.sh" || true
  fi
}
trap notify_failure ERR

branch="$(git branch --show-current)"
if [[ -z "$branch" ]]; then
  echo "Cannot update dotfiles from a detached HEAD." >&2
  false
fi

if ! git diff-index --quiet HEAD --; then
  echo "Dotfiles update blocked by local changes." >&2
  false
fi

git fetch origin
git reset --hard "origin/$branch"
"$DOTFILES_DIR/init.sh" --sync
