#!/bin/sh
set -e

: "${ZKEY:=/app/binaries/zkLogin-main.zkey}"
: "${WITNESS_BINARIES:=/app/binaries}"
: "${GDRIVE_FILE_ID:?Missing GDRIVE_FILE_ID}"

ZKEY_DIR="$(dirname "$ZKEY")"
ZKEY_TMP="$ZKEY.part"

mkdir -p "$ZKEY_DIR"

# If the zkey is already present and reasonably sized, skip re-downloading.
# (The zkLogin main zkey is ~600MB; this threshold prevents re-download loops after partial downloads.)
if [ -f "$ZKEY" ]; then
  ZKEY_SIZE_BYTES="$(wc -c < "$ZKEY" | tr -d ' ')"
else
  ZKEY_SIZE_BYTES="0"
fi

if [ "$ZKEY_SIZE_BYTES" -lt 500000000 ]; then
  echo "Downloading zkey from Google Drive..."
  rm -f "$ZKEY_TMP"

  # Use a temp file + rename for atomicity; keep logs small to reduce memory overhead.
  python3 -m gdown --quiet --id "$GDRIVE_FILE_ID" -O "$ZKEY_TMP"
  mv -f "$ZKEY_TMP" "$ZKEY"
fi

echo "zkey file:"
ls -lh "$ZKEY"

exec /app/run.prover.sh

