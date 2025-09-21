#!/bin/bash

dir="/var/log"

if [ -d "$dir" ]; then
  echo "Calculating the 10 largest dirs and files . . ."
  du -ah "$dir" 2>/dev/nukk | sort -rh | head -n 10
else
  echo "path not found"
fi
