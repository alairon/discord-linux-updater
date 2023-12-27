# discord-updater
The Linux version of Discord oddly doesn't have an auto updater, and requests users with an out-of-date version to either download a `.deb` or `.tar.gz` file. Users on Debian-based distributions can just download and install the `.deb` package, but what about everyone else? 

## *"It's your lucky day!"*
No need to roll those D20s, these small scripts allows Linux users to install and update the official `tar.gz` version of Discord. This is intended for users who have issues running the snap/flatpak version, and those with package managers that either don't have it in their repos or do not offer the latest version.

## Disclaimer
**This repository is not associated with Discord.** Please note that the scripts found here are not an official way of installing or updating Discord, and were created for my own amusement.

I have only tested these scripts on Fedora 39 and OpenSUSE Tumbleweed, for the stable release version of Discord. YMMV.

# Available Scripts
Users can start the installation/upgrade process by running the following commands:

* `bash installer_stable.sh` for installation
* `bash patcher_stable.sh` for updates by completely overwriting the current installation with the updated `tar.gz` file **OR**
* `bash patcher_quick.sh` for a faster update experience by only updating the version number. While this typically allows the user to start up Discord afterwards, it is not confirmed whether this thoroughly updates the client every time.

By default, the install location variable (`$INSTALL_DIR`) points to `~/.local/bin`. To change this, please open the file you wish to run and direct the `$INSTALL_DIR` variable at the top of the scripts to your desired location. Certain locations may require you to run the script in an elevated profile.

## Requirements
The scripts requires the use of:
* bash
* cURL
* perl
* jq
* tar

These are typically available out-of-the-box in most distributions, but if your installation of Linux is missing any of these applications, please install them through your package manager before proceeding.
