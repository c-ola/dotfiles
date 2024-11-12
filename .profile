# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

TERMINAL=alacritty
export QT_STYLE_OVERRIDE=kvantum

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
. "$HOME/.cargo/env"

export XDG_CONFIG_HOME="$HOME/.config"

export PATH="$PATH:/usr/lib/dart/bin"

export PATH="$PATH:/usr/local/go/bin"

export PATH="$PATH:$HOME/emsdk:$HOME/emsdk/upstream/emscripten"

export PATH="$PATH:$HOME/.nvm/versions/node/v20.10.0/bin" 

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# 
export PATH="$PATH:/home/nikola/Documents/school/elec390/duckietownenv/bin"

export QSYS_ROOTDIR="/home/nikola/intelFPGA_lite/18.1/quartus/sopc_builder/bin"

export LM_LICENSE_FILE="/home/nikola/intelFPGA_lite/licenses/LR-154676_License.dat"
export LS_LICENSE_FILE="/home/nikola/intelFPGA_lite/licenses/LR-154676_License.dat"
export MLGM_LICENSE_FILE="/home/nikola/intelFPGA_lite/licenses/LR-154676_License.dat"
export MLGS_LICENSE_FILE="/home/nikola/intelFPGA_lite/licenses/LR-154676_License.dat"
