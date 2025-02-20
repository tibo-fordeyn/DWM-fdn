#!/bin/bash

if [ -z "$1" ]; then
    echo "Gebruik: $0 <link>"
    exit 1
fi

# Serverconfiguratie
SERVER_USER="dyntif" 
SERVER_IP="192.168.0.249"  
REMOTE_SCRIPT="~/.local/bin/download-video.sh"
LOCAL_MOUNT_POINT=~/persoonlijk/superfiles/problematisnoi
DOWNLOAD_DIR="$LOCAL_MOUNT_POINT/yt/vandaag/"

# 1. Voer het downloadscript uit op de server
ssh "$SERVER_USER@$SERVER_IP" "$REMOTE_SCRIPT '$1'"

# 2. Mount de servermap lokaal
sshfs "$SERVER_USER@$SERVER_IP:/home/$SERVER_USER/superfiles/problematisnoi" "$LOCAL_MOUNT_POINT"

# 3. Zoek de meest recent gedownloade video
latest_file=$(ssh "$SERVER_USER@$SERVER_IP" "find ~/superfiles/problematisnoi/yt/vandaag/ -type f -printf '%T@ %p\n' | sort -n | tail -1 | cut -d' ' -f2-")

# 4. Controleer of er een bestand is gevonden
if [ -z "$latest_file" ]; then
    echo "Geen nieuwe video gevonden om af te spelen."
    exit 1
fi

# 5. Speel de meest recent gedownloade video af met mpv
mpv "$LOCAL_MOUNT_POINT/yt/vandaag/$(basename "$latest_file")"
