#!/bin/bash
set -e

ZOLA_VERSION="v0.22.0"
ARCH="$(uname -m)"
OS="$(uname | tr '[:upper:]' '[:lower:]')"

case "$ARCH" in
  x86_64)  ARCH_STR="x86_64" ;;
  aarch64|arm64) ARCH_STR="aarch64" ;;
esac

# Linux glibc asset (Cloudflare Pages uses Linux glibc)
ASSET="zola-${ZOLA_VERSION}-${ARCH_STR}-unknown-linux-gnu.tar.gz"
URL="https://github.com/getzola/zola/releases/download/${ZOLA_VERSION}/${ASSET}"

echo "Installing Zola $ZOLA_VERSION for ${ARCH_STR}-unknown-linux-gnu..."
curl -fsSL "$URL" -o /tmp/zola.tar.gz

mkdir -p /tmp/zola-extract
tar -xzf /tmp/zola.tar.gz -C /tmp/zola-extract
mkdir -p "$HOME/.local/bin"
cp /tmp/zola-extract/zola "$HOME/.local/bin/"
chmod +x "$HOME/.local/bin/zola"
export PATH="$HOME/.local/bin:$PATH"
echo "Zola: $(zola --version)"
rm -rf /tmp/zola.tar.gz /tmp/zola-extract
