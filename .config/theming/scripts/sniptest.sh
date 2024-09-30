#!/bin/bash

# Open sxiv in thumbnail mode
snippet=$(nsxiv -t -o ~/dl/themas/natuur/* | head -n 1)

# Test of snippet is ingesteld
echo "Geselecteerde afbeelding: wal -i $snippet"
