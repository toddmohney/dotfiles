#!/bin/bash

# Get the directory this script is stored in; assumes dotfiles to be symlinked
# are in the same directory as this file.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DOTFILES=( gitconfig git_template gvimrc pam_environment tmux.conf vimrc vim zsh zshrc)

for dotfile in "${DOTFILES[@]}"
do
    file_path=${DIR}/${dotfile}
    symlink_path=~/.${dotfile}
    echo; echo "Symlinking ${file_path} to ${symlink_path}"
    if [ -f $symlink_path ];
    then
        read -p "${symlink_path} exists, overwrite? (y/n) " -n 1 -r
        if [[ ^[Yy]$ =~ $REPLY ]]
        then
            rm $symlink_path
            ln -s $file_path $symlink_path
            echo " ...overwrote ${symlink_path}"
        else
            echo " ...skipped"
        fi
    else
        echo " ...removing folder ${symlink_path}"
        rm -r $symlink_path
        ln -s $file_path $symlink_path
        echo " ...${symlink_path} re-linked"
    fi
done

# setup gpg agent
ln gpg-agent.conf ~/.gnupg/gpg-agent.conf

# setup window mangaer
ln xmonad/xmobarrc ~/.xmonad/xmobarrc
ln xmonad/xmonad.hs ~/.xmonad/xmonad.hs

# setup X11 env
ln Xresources ~/.Xresources
