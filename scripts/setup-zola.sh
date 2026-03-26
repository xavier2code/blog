#!/bin/bash
# Cloudflare Pages Zola Installer — v2 (2026-03-26)
set -e

ZOLA_VERSION="v0.22.0"

# Cloudflare Pages runs on Linux x86_64 glibc
ASSET="zola-${ZOLA_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
URL="https://github.com/getzola/zola/releases/download/${ZOLA_VERSION}/${ASSET}"

echo "[setup-zola] Installing Zola $ZOLA_VERSION for x86_64-unknown-linux-gnu..."
curl -fsSL "$URL" -o /tmp/zola.tar.gz

mkdir -p /tmp/zola-extract
tar -xzf /tmp/zola.tar.gz -C /tmp/zola-extract
mkdir -p "$HOME/.local/bin"
cp /tmp/zola-extract/zola "$HOME/.local/bin/"
chmod +x "$HOME/.local/bin/zola"

export PATH="$HOME/.local/bin:$PATH"
echo "[setup-zola] Zola: $(zola --version)"
rm -rf /tmp/zola.tar.gz /tmp/zola-extract
