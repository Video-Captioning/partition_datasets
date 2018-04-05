#!/usr/bin/env bash

# Get command-line arguments, giving usage instructions, when warranted
if (( $# != 2 ))
then
  echo 
  echo "Usage:"
  echo "  sh $0 idx dat"
  echo "Example:"
  echo "  sh $0 idx labeled_3471.txt"
  exit 1
fi

# Create a script to remove
# selected rows, by row_id, from data
sed 's/.*/&d/g' $1 > tmp.sed
# Run the script
sed -f tmp.sed $2
