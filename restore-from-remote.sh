#!/bin/sh
set -e

# Local data directory (to back up or restore)
SRC_DIR="/data"

# Local destination directory for backups
DEST_DIR="/backups"

# Remote backup directory on cloud
BACKUP_DIR="${1:-${RCLONE_REMOTE}:${RCLONE_DEST_DIR}}"

# Check if data directory is empty
if [ -z "$(ls -A "$SRC_DIR" 2>/dev/null)" ]; then
  echo "Data directory is empty. Checking for backups..."

  # Try to find the latest backup in remote
  latest=$(rclone lsf "$BACKUP_DIR" \
    --config /config/rclone/rclone.conf \
    | grep '\.tgz$' \
    | sort \
    | tail -n1)

  if [ -n "$latest" ]; then
    echo "Found backup $latest, downloading..."
    rclone copy "$BACKUP_DIR/$latest" "$DEST_DIR" \
      --config /config/rclone/rclone.conf
  else
    echo "No .tgz backups found in remote directory $BACKUP_DIR."
  fi

  echo "Attempting restore using restore-tar-backup..."
  exec restore-tar-backup
else
  echo "Data directory is not empty. Skipping restore."
fi
