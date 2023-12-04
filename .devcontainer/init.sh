#!/usr/bin/zsh

set -ex

if [ -f .env.local ]; then
    export CHEZMOI_USER=$(grep CHEZMOI_USER .env.local | cut -d '=' -f2)
fi

if [ -n "$CHEZMOI_USER" ]; then
    chezmoi init --apply $CHEZMOI_USER
fi
