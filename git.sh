#!/bin/bash
if [ -z "$1" ]
then
    echo "Usage: git.sh 'your commit'"
else
    if git add -A
    then
        if git commit -m "$1"
        then
            git push -u origin master
        fi
    fi
fi

