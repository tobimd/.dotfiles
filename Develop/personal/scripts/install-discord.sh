#!/bin/zsh

# Check if needed binaries are installed
local has_libcxx="true"
local has_libatomic="true"

if [[ -z $(dnf list installed | grep libcxx 2>/dev/null) ]]; then
    has_libcxx="false"
fi

if [[ -z $(dnf list installed | grep libatomic 2>/dev/null) ]]; then
    has_libcxx="false"
fi

if [[ $has_libcxx == "false" && $has_libatomic == "false" ]]; then
    sudo dnf install libcxx libatomic
elif [[ $has_libcxx == "false" ]]; then
    sudo dnf install libcxx
elif [[ $has_libatomic == "false" ]]; then
    sudo dnf install libatomic
fi

local dldir="~/Downloads"
local appdir="/usr/share/discord"

# Download discord tar into Download directory and extract it
wget -O "$dldir/discord-linux.tar.gz" https://discord.com/api/download\?platform\=linux\&format\=tar.gz
tar -zxf "$dldir/discord-linux.tar.gz"
rm "$dldir/discord-linux.tar.gz"

# Move the new discord directory into /usr/share
sudo mv "$dldir/Discord" "$appdir"

# Copy the files into their respective places (the binary, the .desktop file, etc)
sudo cp "$appdir/Discord" /usr/bin/discord
sudo cp "$appdir/discord.desktop" /usr/share/applications/
sudo cp "$appdir/discord.png" /usr/share/pixmaps/
source "$appdir/postinst.sh"

echo ""
echo "Finished installing Discord."
echo ""
