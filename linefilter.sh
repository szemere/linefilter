#!/bin/bash

function main {
    check_arguments "$@"
    read_the_file "$@"

    # preprocess
    parse_define_macros
    apply_define_macros
    remove_comments_and_empty_lines

    # apply scope
}


################################
# input handling
################################

function check_arguments {

    # number of arguments
    if [ $# -lt 2 ]
    then
        echo "usage: $0 <input file> <target1> [<target2> ...]"
        exit
    fi

    # input file
    if [ ! -r $1 ]
    then
        echo "$1 is not a file or not readable."
        exit
    fi

    if [ ! -s $1 ]
    then
        # file is empty, output should be empty too.
        exit
    fi

}

function read_the_file {
    readarray lines < $1
}


################################
# macros
################################

function parse_define_macros {
    defines_index=0
    for index in ${!lines[*]}
    do
        if [ -n "${lines[$index]}" ] # line is not empty
        then
            if [[ "${lines[$index]}" == \#define* ]]
            then
                defines[defines_index]="${lines[$index]}"
            fi
        fi
    done
}

function apply_macro {
    macro_name=$1
    shift
    tmp=$@
    macro_value=${tmp} # without the " it will strip the string

    echo "$macro_name"
    echo "$macro_value"

    # replace WHOLE WORDS in lines.
}

function apply_define_macros {
    for index in ${!defines[*]}
    do
        apply_macro ${lines[$index]:7}
    done
}

function remove_comments_and_empty_lines {
    for index in ${!lines[*]}
    do
        if [[ "${lines[$index]}" == \#* ]]
        then
            unset 'lines[index]'
            continue
        fi

        tmp=${lines[$index]:0:1}
        if [ -z $tmp ]
        then
            unset 'lines[index]'
            continue
        fi
    done
}


################################
# helper stuffs
################################

function print_variables {
    echo -e "\n\n\ncontent of lines:"
    for index in ${!lines[*]}
    do
        echo -n "${lines[$index]}"
    done
    echo "end of content"

    echo -e "\n\n\ncontent of defines"
    for index in ${!defines[*]}
    do
        echo "${defines[$index]}"
    done
    echo "end of content"
}


################################
main "$@"
#print_variables
