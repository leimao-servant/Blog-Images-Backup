#!/bin/bash

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
  echo "ImageMagick is not installed. Please install it before running this script."
  exit 1
fi

# Check for the correct number of command-line arguments
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <input_directory> <output_directory> <target_resolution>"
  exit 1
fi

input_directory="$1"
output_directory="$2"
target_resolution="$3"

# Create the output directory if it doesn't exist
mkdir -p "$output_directory"

# Loop through each image in the input directory and resize
for input_image in "$input_directory"/*; do
  if [ -f "$input_image" ]; then
    # Get the filename without the directory path
    filename=$(basename "$input_image")
    
    # Construct the output path
    output_image="$output_directory/$filename"
    
    # Resize the image using ImageMagick
    convert "$input_image" -resize "$target_resolution" "$output_image"
    
    echo "Resized: $input_image -> $output_image"
  fi
done

echo "All images resized to $target_resolution and saved in $output_directory."
