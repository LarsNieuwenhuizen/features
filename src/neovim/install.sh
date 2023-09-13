#!/bin/sh
set -e

install () {
    apt-get update
    apt-get upgrade -y
    apt-get install -y --no-install-recommends neovim
}

install "$@"
