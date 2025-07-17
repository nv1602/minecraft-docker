#!/bin/sh
# update_modrinth_env.sh

MOD_LIST=$(grep -v '^\s*#' modrinth.txt | grep -v '^\s*$' | paste -sd, -)

# If .env doesn't exist, create it with just this variable
if [ ! -f .env ]; then
  echo "MODRINTH_PROJECTS=$MOD_LIST" > .env
  exit 0
fi

# If the variable already exists, replace it. Otherwise, append to the file.
if grep -q '^MODRINTH_PROJECTS=' .env; then
  sed -i "s|^MODRINTH_PROJECTS=.*$|MODRINTH_PROJECTS=$MOD_LIST|" .env
else
  echo "MODRINTH_PROJECTS=$MOD_LIST" >> .env
fi