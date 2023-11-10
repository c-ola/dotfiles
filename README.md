# Things to install

Sync dotfiles

## Packages

zsh, build-essential, git, tmux, pip, python3.11-venv, default-openjre-headless

## Other things

Oh my zsh
`sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

make ssh key
`ssh-keygen -t ed25519`

alacritty themes
```
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
```

tmux plugin manager (install with <prefix> I)
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

tmux powerline (sync config with dotfiles)


powerlevel10k
```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

rustup
`curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`

neovim  (also works to just update neovim)
```
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mkdir ~/.local/bin
mkdir ~/applications
mv nvim.appimage ~/applications
sudo ln -s ~/applications/nvim.appimage ~/.local/bin/nvim
```

packer nvim
```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

nvm/npm/node
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
exec zsh
nvm install --lts
```



