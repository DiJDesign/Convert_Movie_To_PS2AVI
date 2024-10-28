#!/bin/bash

# Script created by Dillon Earl Jones 10-28-2024
# This script is made to convert all movies that are compatible with ffmpeg to format that works with PS2 homebrew SMS

# Check if at least one input file was provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 <input_file1> <input_file2> ..."
  exit 1
fi

# Loop through all provided input files
for input_file in "$@"; do
  # Extract the filename without extension
  output_file="${input_file%.*}_ps2.avi"

  # Run ffmpeg with the specified options
  # Adjust volume setting if the volume when playing on your PS2 isn't right, increase to make louder, decrease to make quieter. Value of 1 = No adjustment.
  echo "Converting $input_file to $output_file..."
  ffmpeg -i "$input_file" -vf scale=640:480 -c:v mpeg4 -b:v 1500k -c:a libmp3lame -b:a 128k -af volume=30 "$output_file"
  
  echo "Conversion complete for $input_file. Output file: $output_file"
done

echo "All conversions completed."
