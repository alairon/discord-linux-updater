#!/bin/bash

# Installation directories
INSTALL_DIR="$HOME/.local/bin"
#INSTALL_DIR="/opt"
#INSTALL_DIR="/usr/local/bin"

# Temporary working directory
TEMP_DIR="/tmp/Discord"

# Discord installer URL and channels
DOWNLOAD_URL="https://discord.com/api/download"
STABLE=$DOWNLOAD_URL"?platform=linux&format=tar.gz"
#BETA=$DOWNLOAD_URL"/ptb?platform=linux&format=tar.gz"
#CANARY=$DOWNLOAD_URL"/canary?platform=linux&format=tar.gz"


echo "Downloading Discord"
curl -L -o "$TEMP_DIR/discord-stable.tar.gz" $STABLE --create-dirs

echo "Installing Discord to $INSTALL_DIR"
tar -xzf $TEMP_DIR/discord-stable.tar.gz -C $INSTALL_DIR


# Modify the included .desktop file to where it is installed
cp $INSTALL_DIR/Discord/discord.desktop $INSTALL_DIR/Discord/discord.desktop.bkp
perl -i -pe 's/(?<=(Exec=)).*/Discord/gmi' $INSTALL_DIR/Discord/discord.desktop
perl -i -pe 's/(?<=(Icon=)).*/$INSTALL_DIR\/Discord\/discord.png/gmi' $INSTALL_DIR/Discord/discord.desktop
perl -i -pe 's/(?<=(Path=)).*/$INSTALL_DIR\/Discord"/gmi' $INSTALL_DIR/Discord/discord.desktop

# Update the desktop shortcut
echo Updating the desktop shortcuts
mv $INSTALL_DIR/Discord/discord.desktop $HOME/.local/share/applications/
mv $INSTALL_DIR/Discord/discord.desktop.bkp $INSTALL_DIR/Discord/discord.desktop
xdg-desktop-menu forceupdate
