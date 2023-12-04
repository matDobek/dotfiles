#!/usr/bin/env bash

dotfiles_dir=$HOME/main/friday/dotfiles

#================
# system
#================

ln -sf $dotfiles_dir/system/.xkb_layout.xkb ~/
ln -sf $dotfiles_dir/system/.xinitrc ~/

#================
# xmonad
#================

mkdir -p ~/.xmonad

ln -sf $dotfiles_dir/xmonad/xmonad.hs ~/.xmonad/
ln -sf $dotfiles_dir/xmonad/background.jpg ~/.xmonad/

#================
# eww
#================

mkdir -p ~/.config/eww
mkdir -p ~/.config/eww/modules

ln -sf $dotfiles_dir/eww/eww.scss ~/.config/eww/
ln -sf $dotfiles_dir/eww/eww.yuck ~/.config/eww/

ln -sf $dotfiles_dir/eww/modules/notifications.sh ~/.config/eww/modules/
ln -sf $dotfiles_dir/eww/modules/workspaces.sh ~/.config/eww/modules/

#================
# custom scripts
#================

mkdir -p ~/.local/bin

ln -sf $dotfiles_dir/scripts/* ~/.local/bin/

#================
# alacritty
#================

mkdir -p ~/.config/alacritty

ln -sf $dotfiles_dir/alacritty/alacritty.yml ~/.config/alacritty/

#================
# kitty
#================

mkdir -p ~/.config/kitty

ln -sf $dotfiles_dir/kitty/kitty.conf ~/.config/kitty/

#================
# bash
#================

ln -sf $dotfiles_dir/bash/.bashrc ~/
ln -sf $dotfiles_dir/bash/.bash_aliases ~/
ln -sf $dotfiles_dir/bash/.bash_secrets.sample ~/
ln -sf $dotfiles_dir/bash/.bash_profile ~/
ln -sf $dotfiles_dir/bash/.inputrc ~/

#================
# git
#================

ln -sf $dotfiles_dir/git/.gitconfig ~/
ln -sf $dotfiles_dir/git/.gitignore ~/

#================
# ctags
#================

ln -sf $dotfiles_dir/ctags/.ctags ~/

#================
# tmux
#================

rm -rf ~/.tmux_sessions
mkdir -p ~/.tmux_sessions

ln -sf $dotfiles_dir/tmux/.tmux.conf ~/
ln -sf $dotfiles_dir/tmux/sessions/* ~/.tmux_sessions/

#================
# nvim
#================

rm -rf ~/.config/nvim
mkdir -p ~/.config/nvim

ln -sf $dotfiles_dir/nvim/init.lua ~/.config/nvim/

ln -sf $dotfiles_dir/nvim/after ~/.config/nvim/
ln -sf $dotfiles_dir/nvim/lua ~/.config/nvim/

#================
# ruby
#================

ln -sf $dotfiles_dir/ruby/.gemrc ~/


#================
# gpg
#================

mkdir -p ~/.gnupg

ln -sf $dotfiles_dir/gnupg/gpg-agent.conf ~/.gnupg
