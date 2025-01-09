#!/bin/bash

sudo apt-get install -y rust-all

if command -v cargo > /dev/null 2>&1; then
    echo "Installation of rust successful."

    cargo install rebos

    if [ $? -eq 0 ]; then
	echo "Installation of rebos successful."
    else
	echo "Failed to install rebos"
    fi
else
    echo "Failed to install rust"
    exit 1
fi
