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

addalias() {
    F="$1"
    
    if [[ ! -f "$F" ]]; then
        echo "skipping $F"
    fi
        
    if [ -f "$F" ]; then
        R=$(grep 'alias vimu' $F 2> /dev/null | wc -l)
        if [[ "$R" == "0" ]]; then
            # append it since it is not already there
            echo "alias vimu='vim -u ~/.vimrc_guest'" >> $F
        else
            # replace it if it is
            sed "s/alias vimu.*/alias vimu='vim -u ~\/.vimrc_guest'/g" -i $F
        fi
    else
        echo "Warning: $F not a file"
    fi
}

normal() {
    link "$DIR/.vim" "$HOME/.vim"
    link "$DIR/.vimrc_code" "$HOME/.vimrc"
}

guest() {
    # setup .vim folder
    if [[ -e "$HOME/.vim" ]]; then
        IGNORE="0"
        # see if that vim is ours and if so dont warn
        if [[ -s "$HOME/.vim" ]]; then
            LD=$(readlink -f "$HOME/.vim")
            if [[ "$LD" == "$DIR/.vim" ]]; then
                IGNORE="1"
            fi
        fi
        if [[ "$IGNORE" == "0" ]]; then
            echo "Warning: $DIR/.vim/ is installed already"
        fi
    else
        link "$DIR/.vim" "$HOME/.vim"
    fi
    # setup .vimrc_guest
    link "$DIR/.vimrc_code" "$HOME/.vimrc_guest"
    # add alias to .profile, .zshenv or .bash_profile with cmd
    # try .profile
    addalias "$HOME/.zshenv"
    addalias "$HOME/.profile"
    addalias "$HOME/.bash_profile"
}

if [[ -z "$MODE" ]] || [[ "$MODE" != "normal" && "$MODE" != "guest" ]]; then
    echo "Error: mode not defined"
    usage
    exit 1
fi

echo "booting vim: $MODE"

$MODE # executes mode function

