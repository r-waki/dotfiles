#!/bin/bash

set -eu

function exists_rsync () {
    if type rsync > /dev/null ; then
        echo "rsync command exists.";
        return 0;
    else
        echo "rsync command is not exist.";
        return 1;
    fi;
}

if ! exists_rsync; then
    read -rp "You need install the rsync command. Are you sure?(y/n)" -n 1;
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo apt install rsync;
    fi;
fi

read -rp "Do you want to continue deploying?(y/n)" -n 1;
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    ./install.sh
fi
 