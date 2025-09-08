!/bin/bash
# Example script to safely restart a Unity dedicated server

# -------- CONFIGURATION --------
SERVER_DIR="/mnt/storage/game_server"                 # Directory where your server runs
SERVER_EXE="$SERVER_DIR/Magitech Requiem.x86_64"      # Unity server executable (quoted properly)
SERVER_HOST="$SERVER_DIR/OathShellHost"                  # OathShellHost wrapper.
ARCHIVE_PATH="/home/gitspathe/Server_Archive.tar.gz"  # Path to the new server archive
SERVER_EXEC="./Magitech Requiem.x86_64"               # Unity server executable (relative, quoted)
SCREEN_NAME="GameServer"                              # Screen instance name
SERVER_USER="gameuser"                                # Server user

# -------- SHUTDOWN SERVER --------
echo "Shutting down server..."
systemctl stop gameserver.service

# -------- REMOVE OLD FILES --------
echo "Cleaning up server files..."
rm -rf "$SERVER_DIR"/*

# -------- UNZIP NEW SERVER --------
echo "Extracting new server files..."
tar -xf "$ARCHIVE_PATH" -C "$SERVER_DIR"

# -------- FIX PERMISSIONS --------
echo "Fixing ownership and permissions..."
chown -R "$SERVER_USER:$SERVER_USER" "$SERVER_DIR"
find "$SERVER_DIR" -type d -exec chmod 755 {} \;
find "$SERVER_DIR" -type f -exec chmod 644 {} \;
chmod +x "$SERVER_EXE"
chmod +x "$SERVER_HOST"

# -------- START SERVER --------
systemctl start gameserver.service
