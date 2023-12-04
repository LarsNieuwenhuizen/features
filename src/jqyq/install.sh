#!/usr/bin/env sh
set -e

preflight() {
    # Set a pinned version of yq
    YQ_VERSION=v4.40.4
    INSTALL_YQ=true

    # Set a pinned version of jq
    JQ_VERSION=1.7
    INSTALL_JQ=true

    # BINDIR setup
    BINDIR=$(echo $PATH | rev | cut -d: -f1 | rev)
    if [ ! -d $BINDIR ]; then
        mkdir -p $BINDIR
    fi

    # Check if yq is installed and has the defined version
    if [ -x "$(command -v yq)" ]; then
        echo "yq is already installed"
        INSTALL_YQ=false
    fi

    # Check if jq is installed and has the defined version
    if [ -x "$(command -v jq)" ]; then
        echo "jq is installed"
        INSTALL_JQ=false
    fi

    # Find the architecture
    ARCH=$(uname -m)
    case $ARCH in
    x86_64) ARCH=amd64 ;;
    aarch64) ARCH=arm64 ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
    esac

    # Find the linux distribution
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$NAME
    else
        echo "Unsupported OS"
        exit 1
    fi
    case $OS in
    "Ubuntu") OS="linux" ;;
    "Debian GNU/Linux") OS="linux" ;;
    *)
        echo "Unsupported OS: $OS"
        exit 1
        ;;
    esac
}

install_yq() {
    URL="https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_${OS}_${ARCH}"
    curl -sL $URL -o $BINDIR/yq
    chmod +x $BINDIR/yq
}

install_jq() {
    URL="https://github.com/jqlang/jq/releases/download/jq-${JQ_VERSION}/jq-${OS}-${ARCH}"
    curl -sL $URL -o $BINDIR/jq
    chmod +x $BINDIR/jq
}

install() {
    if [ $INSTALL_YQ = true ]; then
        install_yq
    fi
    if [ $INSTALL_JQ = true ]; then
        install_jq
    fi
}

preflight
install "$@"
