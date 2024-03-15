# This script is meant to sync all of my local dotfiles to this git repo
# It can also sync the local files with the contents of the repo (use at own risk) also cant do it yet
local type = "None"
while getopts p:t: flag
do
    case "${flag}" in
        p) copypath="default"
            if [ -d ${OPTARG} ]; then
            copypath=${OPTARG}
            else
                exit
            fi;;
        t) type=${OPTARG};;
    esac
done

echo "copying to $copypath"

cp -r $HOME/.config/nvim ./$copypath
cp -r $HOME/.config/alacritty/alacritty.* ./$copypath
cp -r $HOME/.config/tmux-powerline ./$copypath

cp $HOME/.p10k.zsh ./$copypath
cp $HOME/.profile ./$copypath
cp $HOME/.tmux.conf ./$copypath
cp $HOME/.zshrc ./$copypath

if [ "$type" = "i3" ]; then
    rsync -a $HOME/.config/picom.conf ./$copypath/config/
    rsync -a $HOME/.config/i3/config ./$copypath/config/i3/
    rsync -a $HOME/.config/polybar/config.ini ./$copypath/config/polybar/
fi
