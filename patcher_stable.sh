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

SERVER_VER=$(curl -L -s --head $STABLE | grep location | grep -oP "(?<=linux/).*(?=/discord)")
LOCAL_VER=$(cat $INSTALL_DIR/Discord/resources/build_info.json | jq -r .version)

if [[ $SERVER_VER == "" ]]
then
    echo "The Discord servers are unavailable. Please try again later"
    exit 1
fi

if [[ $LOCAL_VER == "" ]]
then
    echo "A Discord installation doesn't seem to be installed at $INSTALL_DIR"
    echo "Please open this file and redirect the INSTALL_DIR variable to where it is installed"
    echo "If you need a new install, retry with the installer_stable script instead"
    exit 1
fi

if [[ $SERVER_VER == $LOCAL_VER ]] 
then
    echo "You have the latest version installed ($LOCAL_VER). No actions required"
    exit 0
else
    echo "Local version ($LOCAL_VER) does not match latest server version ($SERVER_VER)"
fi

echo "Downloading Discord"
curl -L -o "$TEMP_DIR/discord-stable.tar.gz" $STABLE --create-dirs

echo "Updating Discord"
tar -xzf $TEMP_DIR/discord-stable.tar.gz -C $INSTALL_DIR