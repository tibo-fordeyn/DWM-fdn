#!/bin/bash

DIR="$HOME/persoonlijk/superfiles/kleiner/dagboek"
ENTRY="$DIR/entry"
INDEX="$DIR/index.md"
WEEK=$(date +%Y-%V)
FILE="$ENTRY/entry_week${WEEK}.md"
NEWFILE=0

mkdir -p "$ENTRY"

if [ ! -f "$FILE" ]; then
    echo -e "---\ntitle: $WEEK -- Dagboek\n---\n" > "$FILE"
    echo "[[entry/entry_week${WEEK}.md]]" >> "$INDEX"
    NEWFILE=1
fi

TS="## $(date '+%Y-%m-%d %H:%M:%S')"
echo -e "\n$TS\n" >> "$FILE"

LINE=$(wc -l < "$FILE")
vim +"normal! ${LINE}G" +startinsert "$FILE"

if awk "/^$TS\$/ {subsect=1; next} subsect && NF {exit 1}" "$FILE"; then
    sed -i "/^$TS\$/,/^\(## \|$\)/{ /^$TS\$/d; /^## /!d }" "$FILE"
    sed -i '/^$/N;/^\n$/d' "$FILE"
    [ $NEWFILE -eq 1 ] && rm "$FILE"
fi

