#!/bin/sh
set -e

export DEBIAN_FRONTEND=noninteractive

install () {
    apt-get update
    apt-get upgrade -y
    apt-get install -y --no-install-recommends neovim
}

install "$@"
