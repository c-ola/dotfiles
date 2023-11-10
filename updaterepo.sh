# This script is meant to sync all of my local dotfiles to this git repo
# It can also sync the local files with the contents of the repo (use at own risk) also cant do it yet


cp -r $HOME/.config/nvim ./
cp -r $HOME/.config/alacritty/alacritty.yml ./
cp -r $HOME/.config/tmux-powerline ./

cp $HOME/.p10k.zsh .
cp $HOME/.profile .
cp $HOME/.tmux.conf .
cp $HOME/.zshrc .
    
