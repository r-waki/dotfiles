#!/bin/bash
#
#######################################
# dotfiles deploy home directory
# Globals : REPLY
# Argument: None
# Returns : None
#
#######################################

set -eu

function doIt () {
    rsync --exclude=".git/" \
        --exclude="install.sh" \
        --exclude="README.md" \
        --exclude="setup.sh" \
        -avh . ~ ;
    source ~/.bashrc
}


read -rp "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
echo "";

if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt;
fi;

