#!/bin/bash

echo "Enter the first number:"
read a
echo "Enter the second number:"
read b

if [ $a -gt $b ]; then
  echo "a=$a is greater than b=$b"
elif [ $a -lt $b ]; then
  echo "a=$a is less than b=$b"
else
  echo "a=b=$a"
fi

# We need fi to close if-else
# There is a single space between [ and $a, also $b and ]
# ; is use to write multiple commands in the same line
# below is another version
#
# if [ $a -gt $b ] 
# then echo "a=$a is greater than b=$b"
# elif [ $a -lt $b ]
# then echo "a=$a is less than b=$b"
# else echo "a=b=$a"
# fi

