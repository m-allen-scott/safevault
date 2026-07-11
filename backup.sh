#!/bin/bash

# ==========================================
# SafeVault Backup System v4
# Author : Allen Scott
# ==========================================

CONFIG_FILE="config.conf"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Configuration file not found!"
    exit 1
fi

source "$CONFIG_FILE"

mkdir -p "$BACKUP_FOLDER"
mkdir -p "$LOG_FOLDER"

TIMESTAMP=$(date +"%Y-%m-%d-%H-%M-%S")

BACKUP_NAME="backup-$TIMESTAMP.tar.gz"
BACKUP_FILE="$BACKUP_FOLDER/$BACKUP_NAME"
LOG_PATH="$LOG_FOLDER/$LOG_FILE"

echo "========================================="
echo "      SafeVault Backup System"
echo "========================================="

echo "[$TIMESTAMP] Backup Started" >> "$LOG_PATH"

if [ ! -d "$SOURCE_FOLDER" ]; then
    echo "Source folder not found!"
    echo "[$TIMESTAMP] ERROR : Source folder missing." >> "$LOG_PATH"
    exit 1
fi

echo ""
echo "Creating backup..."

tar -czf "$BACKUP_FILE" "$SOURCE_FOLDER"

if [ $? -ne 0 ]; then
    echo "Compression failed."
    echo "[$TIMESTAMP] ERROR : Compression failed." >> "$LOG_PATH"
    exit 1
fi

echo "Compression successful."

echo ""
echo "Uploading backup to Amazon S3..."

if aws s3 cp "$BACKUP_FILE" s3://$BUCKET_NAME/; then
    echo "Upload successful."
else
    echo "Upload failed."
    echo "[$TIMESTAMP] ERROR : Upload failed." >> "$LOG_PATH"
    exit 1
fi

echo ""
echo "Verifying upload..."

if aws s3 ls s3://$BUCKET_NAME/$BACKUP_NAME >/dev/null; then
    echo "Verification successful."
else
    echo "Verification failed."
    echo "[$TIMESTAMP] ERROR : Verification failed." >> "$LOG_PATH"
    exit 1
fi

find "$BACKUP_FOLDER" -type f -name "*.tar.gz" -mtime +$RETENTION_DAYS -delete

echo "[$TIMESTAMP] SUCCESS : Backup Completed." >> "$LOG_PATH"

echo ""
echo "========================================="
echo " Backup Completed Successfully"
echo "========================================="

echo "Backup File : $BACKUP_FILE"
echo "Log File    : $LOG_PATH"
