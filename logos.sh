#!/bin/bash

# Needed to resolve DNS durin Chroot 
echo 'nameserver 8.8.8.8' > /etc/resolv.conf
# Needed to resolve source location  during Chroot
sed -i '$d' /etc/apt/sources.list

# Update the package list
apt-get update

# Install the packages
apt-get install -y gnome-shell tilix

# Change defualt theming 
echo -e '#!/bin/bash\n\n# Change Gnome settings\ngsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'' > /etc/skel/gnome-settings.sh
chmod +x /etc/skel/gnome-settings.sh
echo "/etc/skel/gnome-settings.sh" >> /etc/skel/.profile

# Create a script that loads Tilix settings
echo -e '#!/bin/bash\n\n# Load Tilix settings\ndconf load /com/gexperts/Tilix/ < /etc/skel/.config/tilix.dconf' > /etc/skel/tilix-settings.sh
# Make the script executable
chmod +x /etc/skel/tilix-settings.sh
# Add the script to the .profile file to be executed at login
echo "/etc/skel/tilix-settings.sh" >> /etc/skel/.profile

# Install brave & curl
apt-get install -y curl
#       Download and add Brave's signing key
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
#       Add Brave to the APT repositories
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" > /etc/apt/sources.list.d/brave-browser-release.list
#       Update the package list
#apt-get update
#       Install the Brave browser
#apt-get install -y brave-browser

# Add Spotify's signing key
curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
#       Add Spotify to the APT repositories
echo "deb http://repository.spotify.com stable non-free" > /etc/apt/sources.list.d/spotify.list
#       Update the package list
#apt-get update
#       Install the Spotify client
#apt-get install -y spotify-client
apt-get clean