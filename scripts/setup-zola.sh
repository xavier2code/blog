#!/bin/bash
set -e

# Zola version to install
ZOLA_VERSION="${ZOLA_VERSION:-v0.22.0}"

# Detect OS
OS="$(uname | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m)"

# Map architecture
case "$ARCH" in
  x86_64)  ARCH="x86_64" ;;
  aarch64|arm64) ARCH="aarch64" ;;
  *)        echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

# Map OS name for Zola asset
case "$OS" in
  linux)  OS_NAME="linux" ;;
  darwin) OS_NAME="macos" ;;
  *)      echo "Unsupported OS: $OS"; exit 1 ;;
esac

ZOLA_ASSET="zola-${ZOLA_VERSION#v}-${OS_NAME}-${ARCH}.tar.gz"
ZOLA_URL="https://github.com/getzola/zola/releases/download/v${ZOLA_VERSION#v}/${ZOLA_ASSET}"

echo "Downloading Zola ${ZOLA_VERSION} for ${OS_NAME}-${ARCH}..."
curl -fsSL "$ZOLA_URL" -o /tmp/zola.tar.gz

echo "Extracting Zola..."
mkdir -p /tmp/zola-extract
tar -xzf /tmp/zola.tar.gz -C /tmp/zola-extract

# Install to ~/.local/bin
mkdir -p "$HOME/.local/bin"
cp /tmp/zola-extract/zola "$HOME/.local/bin/"
chmod +x "$HOME/.local/bin/zola"

# Add to PATH for this session
export PATH="$HOME/.local/bin:$PATH"

# Verify
echo "Zola version: $(zola --version)"

# Cleanup
rm -rf /tmp/zola.tar.gz /tmp/zola-extract
