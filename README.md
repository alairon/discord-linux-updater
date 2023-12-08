# discord-updater

This small script allows Linux users properly install and update a `tar.gz` version of Discord. This is intended for users who do not use the Debian version of the application (as a native `.deb` file exists) or those with package managers who do not offer the latest version.

## Starting the Application
Users can start the installation/upgrade process by running the following command:

* `bash installer_stable.sh` for installation
* `bash patcher_stable.sh` for updates

By default, the install location variable (`$INSTALL_DIR`) points to `~/.local/bin`. To change this, please open the files and modify to your desired location.
