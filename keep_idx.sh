#!/usr/bin/env bash

# Keep the specified image indexes and discard the rest

KEEP_ROWS=$1
CLASS_LABELS=$2

awk '{print NR;}' $CLASS_LABELS           >   all_row_numbers
sed 's/.*/&d/g' all_row_numbers           >   toss_all_rows
sed 's/.*/&d/g' $KEEP_ROWS                >   except_for_these
sed -f   except_for_these toss_all_rows   >   script_to_keep
sed -f   script_to_keep   $CLASS_LABELS
