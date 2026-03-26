#!/bin/bash
set -e

ZOLA_VERSION="v0.22.0"
OS="$(uname | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m)"
case "$ARCH" in x86_64) ARCH="x86_64" ;; aarch64|arm64) ARCH="aarch64" ;; esac
case "$OS" in linux) OS_NAME="linux" ;; darwin) OS_NAME="macos" ;; esac
ASSET="zola-${ZOLA_VERSION#v}-${OS_NAME}-${ARCH}.tar.gz"
URL="https://github.com/getzola/zola/releases/download/${ZOLA_VERSION}/${ASSET}"
echo "Installing Zola $ZOLA_VERSION for $OS_NAME-$ARCH..."
curl -fsSL "$URL" -o /tmp/zola.tar.gz
mkdir -p /tmp/zola-extract
tar -xzf /tmp/zola.tar.gz -C /tmp/zola-extract
mkdir -p "$HOME/.local/bin"
cp /tmp/zola-extract/zola "$HOME/.local/bin/"
chmod +x "$HOME/.local/bin/zola"
export PATH="$HOME/.local/bin:$PATH"
echo "Zola: $(zola --version)"
rm -rf /tmp/zola.tar.gz /tmp/zola-extract
