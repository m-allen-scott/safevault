#!/bin/bash

# ==========================================
# SafeVault Restore System v2
# Author : Allen Scott
# ==========================================

CONFIG_FILE="config.conf"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Configuration file not found!"
    exit 1
fi

source "$CONFIG_FILE"

mkdir -p "$RESTORE_FOLDER"

echo "========================================="
echo "      SafeVault Restore System"
echo "========================================="

echo ""
echo "Available Backups"
echo "-----------------"

aws s3 ls s3://$BUCKET_NAME/

echo ""
read -p "Enter backup filename: " BACKUP_NAME

echo ""
echo "Downloading..."

if aws s3 cp s3://$BUCKET_NAME/$BACKUP_NAME "$RESTORE_FOLDER/"; then
    echo "Download successful."
else
    echo "Download failed."
    exit 1
fi

echo ""
echo "Extracting..."

tar -xzf "$RESTORE_FOLDER/$BACKUP_NAME" -C "$RESTORE_FOLDER"

if [ $? -ne 0 ]; then
    echo "Extraction failed."
    exit 1
fi

echo ""
echo "========================================="
echo " Restore Completed Successfully "
echo "========================================="
echo ""
echo "Restore Location : $RESTORE_FOLDER"
