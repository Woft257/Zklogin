#!/bin/sh
set -e

: "${ZKEY:=/app/binaries/zkLogin-main.zkey}"
: "${WITNESS_BINARIES:=/app/binaries}"
: "${GDRIVE_FILE_ID:?Missing GDRIVE_FILE_ID}"

mkdir -p "$(dirname "$ZKEY")"

if [ ! -s "$ZKEY" ]; then
  echo "Downloading zkey from Google Drive..."
  python3 -m gdown --id "$GDRIVE_FILE_ID" -O "$ZKEY"
fi

echo "zkey file:"
ls -lh "$ZKEY"

exec /app/run.prover.sh

