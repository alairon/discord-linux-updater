#!/bin/bash

SUDO_MODE=0
#Check for sudo permissions
function check_sudo(){
    if pgrep -s 0 '^sudo$' > /dev/null; then
        #zenity --warning --title "Sudo Mode" --text "You appear to be running the installer through sudo"
        SUDO_MODE=1
    fi
}

check_sudo

# Installation directories
INSTALL_DIR="$HOME/.local/bin"

if [[ $SUDO_MODE == 1 ]] then
    INSTALL_DIR="/opt" # Requires sudo
fi

# Temporary working directory
TEMP_DIR="/tmp/Discord"

# Discord installer URL and channels
DOWNLOAD_URL="https://discord.com/api/download"
#STABLE=$DOWNLOAD_URL"?platform=linux&format=tar.gz"
BETA=$DOWNLOAD_URL"/ptb?platform=linux&format=tar.gz"
#CANARY=$DOWNLOAD_URL"/canary?platform=linux&format=tar.gz"


echo "Downloading Discord"
curl -L -o "$TEMP_DIR/discord-ptb.tar.gz" $BETA --create-dirs

echo "Installing Discord to $INSTALL_DIR"
tar -xzf $TEMP_DIR/discord-ptb.tar.gz -C $INSTALL_DIR


# Modify the included .desktop file to where it is installed
cp $INSTALL_DIR/DiscordPTB/discord-ptb.desktop $INSTALL_DIR/DiscordPTB/discord-ptb.desktop.bkp
export INSTALL_DIR
perl -i -pe 's/(?<=(Exec=)).*/DiscordPTB/gmi' $INSTALL_DIR/DiscordPTB/discord-ptb.desktop
perl -i -pe 's/(?<=(Icon=)).*/$ENV{INSTALL_DIR}\/DiscordPTB\/discord.png/gmi' $INSTALL_DIR/DiscordPTB/discord-ptb.desktop
perl -i -pe 's/(?<=(Path=)).*/$ENV{INSTALL_DIR}\/DiscordPTB/gmi' $INSTALL_DIR/DiscordPTB/discord-ptb.desktop

# Update the desktop shortcut
echo "Creating desktop shortcuts"

# Create a desktop file in the logged in user's directory
if [[ $SUDO_MODE == 1 ]] then
    mv $INSTALL_DIR/DiscordPTB/discord-ptb.desktop /home/$(logname)/.local/share/applications/ #/usr/share/applications/
    chown $(logname):$(logname) -R /home/$(logname)/.local/share/applications/discord-ptb.desktop
else
    #Local
    mv $INSTALL_DIR/DiscordPTB/discord-ptb.desktop $HOME/.local/share/applications/
fi

mv $INSTALL_DIR/DiscordPTB/discord-ptb.desktop.bkp $INSTALL_DIR/DiscordPTB/discord-ptb.desktop
xdg-desktop-menu forceupdate

echo "Done!"
