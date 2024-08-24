#!/bin/bash

sudo apt update && sudo apt upgrade
sudo apt install curl
chmod +x *.sh

########################################
#       ADDING REPOSITORIES            #
########################################

#-------------------------------------------------VS CODE--------------------------------------------------------------------
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg

sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg

echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

rm -f packages.microsoft.gpg

#----------------------------------------------Brave Browser-----------------------------------------------------------------
sudo curl -fsSLo /etc/apt/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

#------------------------------------------------Fast Fetch------------------------------------------------------------------
sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch

#--------------------------------------------------KeepassXC-----------------------------------------------------------------
sudo add-apt-repository -y ppa:phoerious/keepassxc

#--------------------------------------------------Syncthing-----------------------------------------------------------------
sudo curl -L -o /etc/apt/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg

echo "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

sudo apt update

########################################
#     INSTALLING PACKAGES WITH APT     #
########################################

#Flag to check if any errors occurred
error_occurred=false

# Read the package names from the file
while IFS= read -r package; do
    # Attempt to install the package and capture error details if any
    if ! sudo apt install -y "$package" 2>> temp_error_log; then
        # Set the error flag
        error_occurred=true
        # Append the error details to crash_log (create if doesn't exist)
        echo "Failed to install: $package" >> crash_log
        echo "Error details:" >> crash_log
        cat temp_error_log >> crash_log
        echo "-----------------------------" >> crash_log
    fi
    # Clear the temporary error log for the next package
    > temp_error_log
done < packages.lst

# Clean up temporary error log
rm -f temp_error_log

# If no errors occurred, remove the crash_log file if it exists
if ! $error_occurred; then
    rm -f crash_log
else
    echo "Some packages failed to install. Check crash_log for details."
fi

#Enabling syncthing autostart
sudo systemctl enable syncthing@$(whoami).service
sudo systemctl start syncthing@$(whoami).service


########################################
#    INSTALLING FLATPAK PACKAGES       #
########################################
#adds the Flathub repository, a source for installing flatpak applications
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub md.obsidian.Obsidian -y


########################################
#       INSTALLING EXTENSIONS          #
########################################

xdg-settings set default-web-browser brave-browser.desktop
brave-browser https://chrome.google.com/webstore/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep &
wait
./extensions.sh
wait


########################################
#      INSTALLING KITTY TERMINAL       #
########################################

./kitty_install.sh

########################################
#          KEYBOARD SHORTCUTS          #
########################################

#xkill
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "Xkill"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "xkill"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "<Primary>Escape"



# Define paths to your scripts
CUSTOMIZATION_SCRIPT="./customization.sh"
VISIT_SITES_SCRIPT="./visit_sites.sh"

# Open GNOME Terminal with multiple tabs for different tasks
gnome-terminal \
    --tab --title="Customization" -- bash -c "$CUSTOMIZATION_SCRIPT; exec $SHELL" \
    --tab --title="Login" -- bash -c "$VISIT_SITES_SCRIPT; exec $SHELL"
