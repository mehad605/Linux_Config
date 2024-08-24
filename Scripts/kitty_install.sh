#!/bin/bash


# Download and run the installer script from Kitty's website
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Create a symbolic link to the Kitty binary in /usr/local/bin for easy access
sudo ln -s ~/.local/kitty.app/bin/kitty /usr/local/bin/

# Create an application shortcut for Kitty in the applications menu
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/

# Create a shortcut to open text and image files with Kitty in the file manager
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/

# Update the application shortcuts with the correct icon and executable path
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop

# Create a desktop shortcut for Kitty
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/Desktop

# Update the desktop shortcut with the correct icon and executable path
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/Desktop/kitty*.desktop
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/Desktop/kitty*.desktop

# Make the desktop shortcut executable and trusted
gio set ~/Desktop/kitty*.desktop metadata::trusted true
chmod a+x ~/Desktop/kitty*.desktop

# Set Kitty as the default terminal emulator
# Update alternatives to give Kitty a higher priority than the default GNOME Terminal
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which kitty) 50