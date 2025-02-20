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
#pandoc "$filename" -t beamer -V theme=Singapore -V colortheme=albatross -o "$basefilename.pdf"
pandoc "$filename" -t latex -V geometry:margin=1in -V colorlinks=true -V linkcolor=blue -V toccolor=gray -V documentclass=report -o "$basefilename.pdf"


# Check if PDF was successfully generated
if [ -f "$basefilename.pdf" ]; then
  echo "Presentation generated: $basefilename.pdf"
  # Opening the file with MuPDF with standard zoom of 370
  zathura "$basefilename.pdf" &
else
  echo "Error generating report."
  exit 2
fi
