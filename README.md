# discord-updater
The Linux version of Discord oddly doesn't have an auto updater, and requests users with an out-of-date version to either download a `.deb` or `.tar.gz` file. Users on Debian-based distributions can just download and install the `.deb` package, but what about everyone else? 

## *"It's your lucky day!"*
No need to roll those D20s, these small scripts allows Linux users properly install and update the official `tar.gz` version of Discord. This is intended for users who have issues running the snap/flatpak version, and those with package managers that either don't have it in their repos or do not offer the latest version.

## Starting the Application
Users can start the installation/upgrade process by running the following command:

* `bash installer_stable.sh` for installation
* `bash patcher_stable.sh` for updates

By default, the install location variable (`$INSTALL_DIR`) points to `~/.local/bin`. To change this, please open the files and direct it to your desired location.

## Requirements
The scripts requires the use of:
* bash
* cURL
* perl
* jq
* tar

These are typically available out-of-the-box in most distributions, but if your installation of Linux is missing any of these applications, please install them through your package manager before proceeding.
