#!/usr/bin/env bash

readonly PROGRAM_NAME=$(basename $0)

function usage()
{
	cat <<- EOF
	
	- - - - - - - - - - - - - - - -
	Usage: ./$PROGRAM_NAME options
	- - - - - - - - - - - - - - - -
	
	INPUT
		a keyword
		an index file
	
	OUTPUT
		row indexes for all rows in the index file that contain the keyword
	
	OPTIONS:
	
	Both of these are required
	  -k | --keyword           Class label, i.e., disc, player, jump, throw, catch, etc.	
	  -l | --label_file        Contains class labels
	
	  -h | --help              Show this information
	
	Example:
	./library/$PROGRAM_NAME -k field  -l labeled_3471.txt
	EOF
}

# --- Get command-line
  while true; do
    case "$1" in
    
      -l | --label_file )   LABEL_FILE="$2" ; shift 2 ;;
      -k | --keyword    )      KEYWORD="$2" ; shift 2 ;;
      -d | --dataset    )      DATASET="$2/"; shift 2 ;;
      -h | --help       )         HELP=true;  shift; usage; exit ;;

      # End of keyword parameters
      --               )                     shift; break ;;
      *                ) break ;;

    esac
  done

[ ! -n "$KEYWORD" ]    && ( echo 'Please specify a keyword -k or --keyword'; exit )
[ ! -n "$LABEL_FILE" ] && ( echo 'Please specify a label file -l or --label_file'; exit )
[ ! -e $LABEL_FILE    ] && ( echo 'Label file not found'; exit )

( [ -n "$KEYWORD" ] && [ -n "$LABEL_FILE" ] && [ -e $LABEL_FILE ] ) && ( awk '/'$INDEX_FILE'/{print NR;}' $LABEL_FILE  )

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Tests:
# ------

# Success:

# (1)
# $ ./library/get_indexes_for_class.sh -k field -l labeled_3471.txt

# Failures:

# (1) No label file specified
# $ ./library/get_indexes_for_class.sh -k field
## Please specify a label file -l or --label_file

# (2) Label file not found
# $ ./library/get_indexes_for_class.sh -l ABC
# Label file not found

# (3) No keyword specified
# $ ./library/get_indexes_for_class.sh -l labeled_3471.txt
## Please specify a keyword -k or --keyword
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
