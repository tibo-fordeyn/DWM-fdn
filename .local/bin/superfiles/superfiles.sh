#!/bin/bash

# Configuratie
SERVER_IP="192.168.0.249"
USER="dyntif"
REMOTE_PATH="/home/dyntif/superfiles"
LOCAL_PATH="$HOME/persoonlijk/superfiles"

MOUNT_PROBLEM="$LOCAL_PATH/problematisnoi"
MOUNT_TOEKOMST="$LOCAL_PATH/toekomst"

REMOTE_KLEINER="$REMOTE_PATH/kleiner"
BACKUP_KLEINER="/home/dyntif/backup_home/kleiner"

REMOTE_TOEKOMST="$REMOTE_PATH/toekomst"
BACKUP_TOEKOMST="/home/dyntif/backup_home/toekomst"

# Controleer of de server bereikbaar is
ping -c 1 -W 2 "$SERVER_IP" > /dev/null
if [ $? -ne 0 ]; then
    echo "Fout: Server ($SERVER_IP) is niet bereikbaar."
    exit 1
fi

#################
# problematisnoi
#################
if ! mountpoint -q "$MOUNT_PROBLEM"; then
    echo "Mounting problematisnoi..."
    sshfs "$USER@$SERVER_IP:$REMOTE_PATH/problematisnoi" "$MOUNT_PROBLEM" -o reconnect || {
        echo "Fout: Kon problematisnoi niet mounten!"
        exit 1
    }
else
    echo "problematisnoi is al gemount."
fi

#################
# toekomst
#################
if ! mountpoint -q "$MOUNT_TOEKOMST"; then
    echo "Mounting toekomst..."
    sshfs "$USER@$SERVER_IP:$REMOTE_PATH/toekomst" "$MOUNT_TOEKOMST" -o reconnect || {
        echo "Fout: Kon toekomst niet mounten!"
        exit 1
    }
else
    echo "toekomst is al gemount."
fi

#################
# Backup/sync kleiner
#################
echo "Leegmaken van $BACKUP_KLEINER..."
ssh "$USER@$SERVER_IP" "rm -rf $BACKUP_KLEINER/*" || {
    echo "Fout: Kon backup/kleiner niet leegmaken!"
    exit 1
}

echo "Verplaatsen van huidige $REMOTE_KLEINER naar $BACKUP_KLEINER..."
ssh "$USER@$SERVER_IP" "mv $REMOTE_KLEINER/* $BACKUP_KLEINER/" || {
    echo "Fout: Kon kleiner niet verplaatsen naar backup!"
    exit 1
}

echo "Synchroniseren van $LOCAL_PATH/kleiner naar server..."
rsync -av --delete "$LOCAL_PATH/kleiner/" "$USER@$SERVER_IP:$REMOTE_KLEINER/" || {
    echo "Fout: Rsync synchronisatie (kleiner) mislukt!"
    exit 1
}

#################
# Backup/sync toekomst
#################
echo "Leegmaken van $BACKUP_TOEKOMST..."
ssh "$USER@$SERVER_IP" "rm -rf $BACKUP_TOEKOMST/*" || {
    echo "Fout: Kon backup/toekomst niet leegmaken!"
    exit 1
}

echo "Verplaatsen van huidige $REMOTE_TOEKOMST naar $BACKUP_TOEKOMST..."
ssh "$USER@$SERVER_IP" "mv $REMOTE_TOEKOMST/* $BACKUP_TOEKOMST/" || {
    echo "Fout: Kon toekomst niet verplaatsen naar backup!"
    exit 1
}

echo "Synchroniseren van $LOCAL_PATH/toekomst naar server..."
rsync -av --delete "$LOCAL_PATH/toekomst/" "$USER@$SERVER_IP:$REMOTE_TOEKOMST/" || {
    echo "Fout: Rsync synchronisatie (toekomst) mislukt!"
    exit 1
}

echo "Klaar!"
