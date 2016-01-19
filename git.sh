#!/bin/bash
if cd ~/kernel-3.10
then
    if git add -A
    then
        if [ -z "$1" ]
        then
            exit 1
        else
            git commit -m "$1"
        fi
            if git push -u origin master
            then
                exit 0
            fi
    fi
fi
