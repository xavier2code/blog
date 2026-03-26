#!/bin/bash
# Clone x-theme directly via HTTPS (bypasses submodule auth issues on Cloudflare Pages)
set -e

THEME_DIR="themes/x-theme"
REPO="https://github.com/xavier2code/x-theme.git"

echo "[clone-theme] Cloning x-theme via HTTPS..."
rm -rf "$THEME_DIR"
git clone --depth=1 "$REPO" "$THEME_DIR"

echo "[clone-theme] Done: $(ls $THEME_DIR | head -3)"
