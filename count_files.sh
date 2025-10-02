#!/bin/bash

# Get all directories in the root (excluding .git)
folders=$(ls -d */ 2>/dev/null | grep -v .git | sed 's/\///g' | sort)

# Initialize counts
counts=""

for folder in $folders; do
  if [ -d "$folder" ]; then
    count=$(find "$folder" -type f | wc -l)
    counts="${counts}- $folder: $count files\n"
  fi
done

# Escape newlines for sed
counts_escaped=$(printf '%s\n' "$counts" | sed ':a;N;$!ba;s/\n/\\n/g')

# Update README.md between markers
sed -i "/<!-- FILE_COUNTS_START -->/,/<!-- FILE_COUNTS_END -->/c\\<!-- FILE_COUNTS_START -->\n$counts_escaped<!-- FILE_COUNTS_END -->" README.md