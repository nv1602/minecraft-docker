#!/bin/sh

MOD_FILE="${1:-modrinth.txt}"

if [ ! -f "$MOD_FILE" ]; then
  echo "Mod list file '$MOD_FILE' not found."
  exit 1
fi

# Read non-comment, non-empty lines and join with commas
MOD_LIST=$(grep -v '^\s*#' "$MOD_FILE" | grep -v '^\s*$' | paste -sd, -)

# If .env doesn't exist, create it with just this variable
if [ ! -f .env ]; then
  echo "MODRINTH_PROJECTS=$MOD_LIST" >.env
  exit 0
fi

# If the variable already exists, replace it. Otherwise, append to the file.
if grep -q '^MODRINTH_PROJECTS=' .env; then
  sed -i "s|^MODRINTH_PROJECTS=.*$|MODRINTH_PROJECTS=$MOD_LIST|" .env
else
  echo "MODRINTH_PROJECTS=$MOD_LIST" >>.env
fi
