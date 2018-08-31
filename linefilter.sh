#!/bin/bash

function help_text() {
    echo "usage: $0 <input file> <target1> [<target2> ...]"
}

if [ $# -lt 2 ]
then
    help_text
    exit
fi

echo "input file: $1"
