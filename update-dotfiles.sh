#!/bin/bash
cd "$HOME/dev_dotfiles" || exit
BRANCH=$(git branch --show-current)
git diff-index --quiet HEAD -- && git fetch origin && git reset --hard "origin/$BRANCH"
