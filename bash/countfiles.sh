#!/bin/bash

read -p "Enter the directory path: " dir

if [ -d "$dir" ]; then
  count=$(find "$dir" -type f | wc -l)
  echo "Total = $count files"
else
  echo "Directory not found"
fi



# -d "path" is use to check if path valid

# find list all files inside a given path
# -type f restrict into files only

# wc = retirns lines, words, characters count
# add -l flag = lines count
# add -c flag = characters count
