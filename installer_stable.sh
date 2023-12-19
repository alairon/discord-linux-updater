#!/bin/bash

# Installation directories
INSTALL_DIR="/home/$(logname)/.local/bin"
#INSTALL_DIR="/opt"
#INSTALL_DIR="/usr/local/bin"

# Temporary working directory
TEMP_DIR="/tmp/Discord"

# Discord installer URL and channels
DOWNLOAD_URL="https://discord.com/api/download"
STABLE=$DOWNLOAD_URL"?platform=linux&format=tar.gz"
#BETA=$DOWNLOAD_URL"/ptb?platform=linux&format=tar.gz"
#CANARY=$DOWNLOAD_URL"/canary?platform=linux&format=tar.gz"

SUDO_MODE=0
#Check for sudo permissions
if pgrep -s 0 '^sudo$' > /dev/null; then
    SUDO_MODE=1
    INSTALL_DIR=$(zenity --list --radiolist --title "Set Install Location" --text "Where would you like to install Discord?" --column "Options" --column "" TRUE $INSTALL_DIR FALSE "/opt" --cancel-label="Cancel" --ok-label "Next")
fi

CONFIRM_INSTALL=$(zenity --question --title "Confirm Installation" --text "We are ready to install Discord to: $INSTALL_DIR.\nProceed?")
if [[ CONFIRM_INSTALL=='No' ]] then
    exit
fi

exit
echo "Downloading Discord"
curl -L -o "$TEMP_DIR/discord-stable.tar.gz" $STABLE --create-dirs

echo "Installing Discord to $INSTALL_DIR"
tar -xzf $TEMP_DIR/discord-stable.tar.gz -C $INSTALL_DIR


# Modify the included .desktop file to where it is installed
cp $INSTALL_DIR/Discord/discord.desktop $INSTALL_DIR/Discord/discord.desktop.bkp
export INSTALL_DIR
perl -i -pe 's/(?<=(Exec=)).*/Discord/gmi' $INSTALL_DIR/Discord/discord.desktop
perl -i -pe 's/(?<=(Icon=)).*/$ENV{INSTALL_DIR}\/Discord\/discord.png/gmi' $INSTALL_DIR/Discord/discord.desktop
perl -i -pe 's/(?<=(Path=)).*/$ENV{INSTALL_DIR}\/Discord/gmi' $INSTALL_DIR/Discord/discord.desktop

# Create the desktop shortcut
echo "Creating shortcuts"
if [[ $SUDO_MODE == 1 ]] then
    mv $INSTALL_DIR/Discord/discord.desktop /home/$(logname)/.local/share/applications/
    chown $(logname):$(logname) -R /home/$(logname)/.local/share/applications/discord.desktop
else 
    mv $INSTALL_DIR/Discord/discord.desktop $HOME/.local/share/applications/
fi

mv $INSTALL_DIR/Discord/discord.desktop.bkp $INSTALL_DIR/Discord/discord.desktop
xdg-desktop-menu forceupdate

echo "Done!"