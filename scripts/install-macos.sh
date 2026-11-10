#!/bin/bash
# Installs the latest MoW release on macOS. Files fetched with curl carry no quarantine flag,
# so the unsigned app opens without the "unidentified developer" prompt.
#   curl -fsSL https://raw.githubusercontent.com/AitorPo/bard-releases/main/scripts/install-macos.sh | bash
# Lives in the code repo; the release workflow copies it to the public releases repo.
set -euo pipefail

REPO="AitorPo/bard-releases"
case "$(uname -m)" in
  arm64) ARCH="aarch64" ;;
  x86_64) ARCH="x64" ;;
  *) echo "unsupported CPU: $(uname -m)" >&2; exit 1 ;;
esac

TMP="$(mktemp -d)"
MOUNT=""
cleanup() {
  [ -n "$MOUNT" ] && hdiutil detach "$MOUNT" -quiet 2>/dev/null || true
  rm -rf "$TMP"
}
trap cleanup EXIT

echo "Downloading the latest MoW ($ARCH)..."
URL="$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" \
  | grep '"browser_download_url"' | grep "_${ARCH}.dmg" | head -n1 | cut -d '"' -f4)" || true
if [ -z "$URL" ]; then
  echo "No $ARCH dmg found. No release is published yet." >&2
  exit 1
fi
curl -fL --progress-bar -o "$TMP/MoW.dmg" "$URL"

DMG="$(ls "$TMP"/*.dmg | head -n1)"
MOUNT="$(hdiutil attach "$DMG" -nobrowse -readonly | tail -n1 | cut -f3-)"
APP="$(ls -d "$MOUNT"/*.app | head -n1)"

if pgrep -x mow >/dev/null 2>&1; then
  echo "Quit MoW first, then run this again." >&2
  exit 1
fi
if pgrep -x bard >/dev/null 2>&1; then
  echo "Quit Bard (the old name of MoW) first, then run this again." >&2
  exit 1
fi
# MoW was called Bard before: the old app is replaced, not kept next to it
rm -rf "/Applications/Bard.app"
rm -rf "/Applications/MoW.app"
cp -R "$APP" "/Applications/MoW.app"
xattr -d com.apple.quarantine "/Applications/MoW.app" 2>/dev/null || true
echo "Installed /Applications/MoW.app"
open "/Applications/MoW.app"
