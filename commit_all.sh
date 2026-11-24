#!/bin/bash

echo "do you want to commit?"
read ans

if [ "$ans" = "y" ]; then
    echo "commit message"
    read msg
    git add -A
    git commit -a -m "$msg"
    git status
    git push -u origin main
else 
    echo "oh, ok."
fi
