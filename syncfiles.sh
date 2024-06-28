#!/bin/bash

# Should be able to sync chosen files
save_dir="$HOME/personal/dotfiles/backups/"

# Directories that you want to save
directories=(
    "$HOME/.config/nvim"
    "$HOME/.config/i3"
    "$HOME/.tmux"
    #"$HOME/.config/polybar"
)

files_to_save=(
    ".profile"
    ".zshrc"
    "alacritty.toml"
    ".p10k.zsh"
    "tmux.conf"
    "picom.conf"
)

file_saver () {
    files=("$@")
    tosearch="-name ${files[0]}"
    for file in ${files[@]}; do
        tosearch="$tosearch -o -name $file"
    done
    search=$(find ~/ \( -name dotfiles -o -name .cache \) -prune -o -type f \( $tosearch \) -print)
    # -exec rsync -ptiv {} ./backups \;
    echo "$search"
    IFS=$'\n' read -rd '' -a file_dirs <<< "$search"
    mkdir -p "$save_dir"
    for i in "${file_dirs[@]}"; do
        rsync -ptiv $i ./backups
    done
}

dir_saver() {
    dirs=("$@")
    for dir in "${dirs[@]}"; do
        rsync -rptiv --exclude=.git $dir ./backups/$(basename $dir)
    done
}

file_saver "${files_to_save[@]}"
dir_saver "${directories[@]}"


