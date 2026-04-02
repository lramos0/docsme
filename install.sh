#!/usr/bin/env bash

set -euo pipefail

REPO="lramos0/docsme"
DEFAULT_BRANCH="main"
INSTALL_PATH="/usr/local/bin/docsme"

# Allow optional version argument (tag like v1.0.0)
VERSION="${1:-$DEFAULT_BRANCH}"

if [[ "$VERSION" == "$DEFAULT_BRANCH" ]]; then
  URL="https://raw.githubusercontent.com/$REPO/$DEFAULT_BRANCH/bin/docsme"
else
  URL="https://raw.githubusercontent.com/$REPO/$VERSION/bin/docsme"
fi

echo "Installing docsme from $VERSION..."

# Create temp file
TMP_FILE="$(mktemp)"

# Download script
curl -fsSL "$URL" -o "$TMP_FILE"

# Ensure it's executable
chmod +x "$TMP_FILE"

# Move to global path
if [[ -w "$(dirname "$INSTALL_PATH")" ]]; then
  mv "$TMP_FILE" "$INSTALL_PATH"
else
  sudo mv "$TMP_FILE" "$INSTALL_PATH"
fi

echo "✅ Installed docsme → $INSTALL_PATH"
echo "Run: docsme --help"
