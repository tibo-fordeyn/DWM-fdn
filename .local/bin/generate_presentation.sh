#!/bin/bash

# the %p option in the vimrc should give the path!
if [ -z "$1" ]; then
  echo "Error: No file path provided."
  exit 1
fi

# Get the full file path
fullpath=$1

# Extract file name and directory from the full path
filename=$(basename -- "$fullpath")
dirname=$(dirname -- "$fullpath")
basefilename="${filename%.*}"

cd "$dirname" || exit

# Convert Markdown to PDF using Pandoc
pandoc "$filename" -t beamer -V theme=Singapore -V colortheme=albatross -o "$basefilename.pdf"


# Check if PDF was successfully generated
if [ -f "$basefilename.pdf" ]; then
  echo "Presentation generated: $basefilename.pdf"
  mupdf -r 350 "$basefilename.pdf" &
else
  echo "Error generating presentation."
  exit 2
fi
