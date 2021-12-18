#!/usr/bin/env bash

# This simple script just runs rsync to sync the files from the
# local machine to the remote server.
REMOTE_SERVER="${1}"
set -e
echo "Backing up settings" && \
rsync -arv --files-from='include-files.txt' ~/ "${REMOTE_SERVER}":~/settings
