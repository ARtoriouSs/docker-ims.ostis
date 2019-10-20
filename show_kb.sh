#!/bin/bash

if [[ $1 = "-h" || $1 = "--help" ]]; then
    printf "\nUsage: ./show_kb.sh - Shows the contents of kb in currently working container\n\n"
    exit 0
fi

docker run ostis bash -c "tree /ostis/kb"
