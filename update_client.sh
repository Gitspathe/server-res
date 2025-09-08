#!/bin/bash
# Example script to safely restart a Unity dedicated server

# -------- CONFIGURATION --------
CLIENT_DIR="/var/www/mercurialorder/"                # Directory where your client runs
ARCHIVE_PATH="/home/gitspathe/Client_Archive.tar.gz" # Path to the new client archive
WEB_USER="www-data"

# -------- REMOVE OLD FILES --------
echo "Cleaning up server files..."
rm -rf "$CLIENT_DIR"/*

# -------- UNZIP NEW CLIENT --------
echo "Extracting new client files..."
tar -xf "$ARCHIVE_PATH" -C "$CLIENT_DIR"

# -------- FIX PERMISSIONS --------
echo "Fixing ownership and permissions..."
chown -R $WEB_USER:$WEB_USER "$CLIENT_DIR"
find "$CLIENT_DIR" -type d -exec chmod 755 {} \;
find "$CLIENT_DIR" -type f -exec chmod 644 {} \;

# -------- DONE --------
echo "Client updated successfully!"
