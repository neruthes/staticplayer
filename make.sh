#!/bin/bash

REPODIR="$PWD"

case $1 in
    build)
        mkdir -p dist
        cat html/main.html > dist/player.html
        ;;
    install)
        touch install_dirs.txt
        IFS=$'\n'
        for idir in $(cat install_dirs.txt); do
            echo "[INFO] Installing 'player.html' to '$idir'."
            cat $REPODIR/dist/player.html > $idir/player.html
            cd $idir && find | cut -c3- | sort > .find.txt
        done
        ;;
    easy_install)
        ./make.sh build
        ./make.sh install
        ;;
esac
