#!/bin/bash

REPODIR="$PWD"

case $1 in
    build)
        # We might have a more sophisticated build process in the future...
        mkdir -p dist
        cat html/main.html > dist/player.html
        ;;

    install)
        touch install_dirs.txt
        install_dirs="$(cat install_dirs.txt)"
        if [[ -z "$install_dirs" ]]; then
            echo "[ERROR] No installation destination found. Please specify at least one in 'install_dirs.txt'."
            exit 0
        fi
        IFS=$'\n'
        for idir in $install_dirs; do
            echo "[INFO] Installing 'player.html' to '$idir'."
            cat $REPODIR/dist/player.html > $idir/player.html
            cd $idir
            rm .find.txt 2>/dev/null
            for format in flac ape m4a wav aiff aif mp3; do
                find -name "*.$format" | cut -c3- | sort >> .find.txt
            done
        done
        ;;

    easy_install)
        ./make.sh build
        ./make.sh install
        ;;

esac
