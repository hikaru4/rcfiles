#!/bin/bash
set -x

home_dir=~
rcfile_dir=~/rcfiles


mkdir -p ~/.logs/

for rc_file in bashrc tmux.conf vimrc flake8 gitconfig Xmodmap; do
    rm ${home_dir}/.${rc_file}
    ln -s ${rcfile_dir}/${rc_file} ${home_dir}/.${rc_file}
done
