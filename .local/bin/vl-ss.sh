#!/bin/bash

# Directory that has the symlink
base_dir=~/school/

# Checking symlink
if [ ! -L "$base_dir/current-subject" ]; then
    echo "Symlink not configured correctly"
    exit 1
fi

# Getting symlink
current_subject=$(readlink -f $base_dir/current-subject)

# Checking 'images' folder
if [ ! -d "$current_subject/images" ]; then
    mkdir -p "$current_subject/images"
    echo "Images folder didn't exist, now it does!"
fi

# filename
datetime=$(date '+%Y-%m-%d_%H-%M-%S')
filename="$current_subject/images/screenshot_$datetime.png"

# taking ss
flameshot gui -p "$filename"
