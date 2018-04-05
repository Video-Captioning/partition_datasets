#/usr/bin/bash

if (( $# != 2 ))
then
  echo 
  echo "Usage:"
  echo "  sh $0 idx dat"
  echo "Example:"
  echo "  sh $0 idx labeled_3471.txt"
  exit 1
fi

# Create a script
# to remove selected rows, by row_id, from data

awk '{print NR;}' $2 > all_idx
sed 's/.*/&d/g' $1 > tmp.sed
sed -f tmp.sed all_idx | sed 's/.*/&d/g' > tmp2.sed
sed -f tmp2.sed $2