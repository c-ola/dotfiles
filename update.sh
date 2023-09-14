#!/bin/bash

# This script is meant to sync all of my local dotfiles to this git repo
# It can also sync the local files with the contents of the repo (use at own risk) also cant do it yet

#a1=$(wc -l < $1)

cp -r $HOME/.config/{nvim,alacritty} .

#cp -r $HOME/.config/allacritty/{themes/} .

cp -r $HOME/.config/xournalpp/{colornames.ini,palette.gpl,settings.xml} .

cp $HOME/{.zshrc,.p10k.zsh,.profile} .
    
