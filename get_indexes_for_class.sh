#!/usr/bin/env bash

# Get command-line arguments, giving usage instructions, when warranted
if (( $# < 2 ))
then
  echo
  echo "Usage:"
  echo "  $0 index_file data_file"
  echo "Example:"
  echo "  $0 positive_indexes labeled_3471.txt"
  exit 1
fi

awk '/'$1'/{print NR;}' $2
