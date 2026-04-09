#!/bin/bash

read -p "Search text: " term
read -p "Directory: " dir

if [ -d "$dir" ]; then
  grep -RIn --color=never "$term" "$dir"
else
  echo "Directory not found"
fi

# -R recursive
# -I ignore binary files
# -n show line numbers
