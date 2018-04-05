#!/usr/bin/env bash

if (( $# != 3 ))
then
  echo 
  echo "Usage:"
  echo "  sh $0 keyword labeled_data training_fraction"
  echo "Example:"
  echo "  sh $0 disc labeled_3471.txt 0.40"
  exit 1
fi

round()
{
echo $(printf %.$2f $(echo "scale=$2;(((10^$2)*$1)+0.5)/(10^$2)" | bc))
};

# --- Describe what is about to happen
echo -----------------------------------------
echo 
keyword=$1
fraction=$3
destination=$keyword`echo "$(round 100*$fraction 0)" | bc`

[ -d $destination ]&&echo "Using existing subdirectory" $destination||(echo "Creating subdirectory "; mkdir $destination)

# --- Get indecies for data that matches keyword
./get_indexes_for_class.sh $1 $2 > tmp_pos_idx

# --- Select positive examples
./keep_idx.sh tmp_pos_idx $2 > tmp_pos_ex
# --- Select negative examples
./toss_idx.sh tmp_pos_idx $2 > tmp_neg_ex

# --- Show quantities of positive and negative examples
echo
sed -n $= tmp_pos_ex | sed 's/.*/& positive examples/'
sed -n $= tmp_neg_ex | sed 's/.*/& negative examples/'
echo ===========================
sed -n $= $2 | sed 's/.*/& total/'
echo 

# -----------------------------------------------

# --- Select a whole bunch of indecies for POSITIVE examples at random, many more than will be needed
awk 'END{ print "jot -r " NR,1,NR " | sort -n | uniq";}' tmp_pos_ex | sh > tmp_fountain_of_indecies

# --- Take the first TRAIN_FRAC of the indecies
awk -v frac=$3 'END{ printf( "sed 1,%d!d tmp_fountain_of_indecies\n" ), frac*NR;}' tmp_pos_ex | sh > tmp_pos_rownums

# --- Now, do the same for NEGATIVE examples
# --- Select a whole bunch of indecies
awk 'END{ print "jot -r " NR,1,NR " | sort -n | uniq";}' tmp_neg_ex | sh > tmp_fountain_of_indecies

# --- Take the first TRAIN_FRAC of the indecies
awk -v frac=$3 'END{ printf( "sed 1,%d!d tmp_fountain_of_indecies\n" ), frac*NR;}' tmp_neg_ex | sh > tmp_neg_rownums

# -----------------------------------------------

# --- Now, KEEP the identified rows for TRAINING
./keep_idx.sh tmp_pos_rownums tmp_pos_ex > $destination/training_pos.txt
./keep_idx.sh tmp_neg_rownums tmp_neg_ex > $destination/training_neg.txt
# --- then TOSS the identified rows, using the rest for TESTING...
./toss_idx.sh tmp_pos_rownums tmp_pos_ex > $destination/testing_pos.txt
./toss_idx.sh tmp_neg_rownums tmp_neg_ex > $destination/testing_neg.txt

# -----------------------------------------------

# --- Summarize results
sed -n $= $destination/training_pos.txt | sed 's/.*/& Training positive examples/'
sed -n $= $destination/training_neg.txt | sed 's/.*/& Training negative examples/'
echo ===========================
sed -n $= $destination/training_pos.txt $destination/training_neg.txt | sed 's/.*/& TOTAL Training examples/'

echo 
sed -n $= $destination/testing_pos.txt | sed 's/.*/& Testing  positive examples/'
sed -n $= $destination/testing_neg.txt | sed 's/.*/& Testing  negative examples/'
echo ===========================
sed -n $= $destination/testing_pos.txt $destination/testing_neg.txt | sed 's/.*/& TOTAL Testing examples/'

echo 
echo Partitioned data are at:
pwd | sed 's/.*/    &\/'$destination'/' 
echo 
