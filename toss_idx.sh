#!/usr/bin/env bash

# Remove the specified image indexes, and keep the rest

TOSS_ROWS=$1
CLASS_LABELS=$2

sed 's/.*/&d/g' $TOSS_ROWS   >   script_to_remove_specified_rows_from
sed -f script_to_remove_specified_rows_from   $CLASS_LABELS
