#!/bin/bash

# this script will run in two modes: normal, guest
# in normal mode it points the .vimrc and .vim to this
# in guest mode it will attempt to create a .vimrc_guest
# and .vim_guest and then add a vimg alias to load this
# vim install

MODE="$1"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

usage() {
    echo "Usage: boot.sh [mode=normal|guest]"
}

# function to see if a path is a symbolic link
# if so reset it to our related files
# if not, warn the user and prompt for abort or overwrite
link() {
    # if a file or dir but not symlink prompt for removal
    if [ ! -L "$2" ] && ( [ -f "$2" ] || [ -d "$2" ] ); then
        echo -n "Warning: $2 is not a symlink, remove? [y/n] "
        read p
        if [ "$p" = "y" ]; then
            if [ -d "$2" ]; then
                rm -rf "$2"
            elif [ -f "$2" ]; then
                rm "$2"
            fi
        else
            echo "aborting"
            exit 1
        fi
    fi

    if [ -L "$2" ]; then
        rm "$2"
    fi

    ln -s "$1" "$2"
}

normal() {
    link "$DIR/.vim" "$HOME/.vim"
    link "$DIR/.vimrc_code" "$HOME/.vimrc"
}

guest() {
    echo "guest"
}

if [[ -z "$MODE" ]] || [[ "$MODE" != "normal" && "$MODE" != "guest" ]]; then
    echo "Error: mode not defined"
    usage
    exit 1
fi

echo "booting vim: $MODE"

$MODE # executes mode function

