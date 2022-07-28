#!/bin/bash

mkdir -p ~/.vim/undo/
mkdir -p ~/.vim/swapfiles/

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim -c "BundleInstall" -c "qa"
