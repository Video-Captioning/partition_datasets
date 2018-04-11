#!/usr/bin/env bash

# --- Configuration
datafile=summary.csv # Name of input data file to visit in each subdirectory

# --- Verify command-line parameters, giving usage instructions when warranted
if (( $# != 1 ))
then
  echo 
  echo "Usage:"
  echo "  sh $0 keyword"
  echo "Example:"
  echo "  sh $0 disc"
  exit 1
fi

# --- Get the keyword from the command-line
keyword=$1

# --- Find all partitions on keyword
for i in `ls -d $keyword[0-9][0-9]/*/`; do
  for j in `ls -d $i* | grep $datafile`; do
    echo $i
  done
done
