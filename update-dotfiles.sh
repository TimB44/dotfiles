#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

usage() {
  echo "Usage: $0 [-f]" >&2
  echo "  -f  Discard tracked local changes and reset to the remote branch" >&2
}

force=false
while getopts ":fh" option; do
  case "$option" in
    f) force=true ;;
    h)
      usage
      exit 0
      ;;
    \?)
      usage
      exit 2
      ;;
  esac
done
shift $((OPTIND - 1))

if (( $# > 0 )); then
  usage
  exit 2
fi

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

if [[ "$force" == false ]] && ! git diff-index --quiet HEAD --; then
  echo "Dotfiles update blocked by local changes." >&2
  echo "Run with -f to discard tracked local changes." >&2
  false
fi

if [[ "$force" == true ]]; then
  echo "Force updating dotfiles; tracked local changes will be discarded."
fi

git fetch origin
git reset --hard "origin/$branch"
"$DOTFILES_DIR/init.sh" --sync
