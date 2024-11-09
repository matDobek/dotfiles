#!/usr/bin/env bash

dotfiles_dir=$HOME/main/friday/dotfiles

#================
# Wayland
#================

function hyprland () {
  mkdir -p ~/.config/hypr
  ln -sf $dotfiles_dir/hypr/hyprland.conf ~/.config/hypr/hyprland.conf
}

function waybar () {
  rm -rf ~/.config/waybar
  mkdir -p ~/.config/waybar

  ln -sf $dotfiles_dir/waybar/* ~/.config/waybar/
}

#================
# X
#================

function xserver () {
  ln -sf $dotfiles_dir/system/.xkb_layout.xkb ~/
  ln -sf $dotfiles_dir/system/.xinitrc ~/
}


function xmonad () {
  mkdir -p ~/.xmonad

  ln -sf $dotfiles_dir/xmonad/xmonad.hs ~/.xmonad/
  ln -sf $dotfiles_dir/xmonad/background.jpg ~/.xmonad/
}

#================
# eww
#================

function eww () {
  mkdir -p ~/.config/eww
  mkdir -p ~/.config/eww/modules

  ln -sf $dotfiles_dir/eww/eww.scss ~/.config/eww/
  ln -sf $dotfiles_dir/eww/eww.yuck ~/.config/eww/

  ln -sf $dotfiles_dir/eww/modules/notifications.sh ~/.config/eww/modules/
  ln -sf $dotfiles_dir/eww/modules/workspaces.sh ~/.config/eww/modules/
}

#================
# custom
#================

function scripts () {
  mkdir -p ~/.local/bin

  ln -sf $dotfiles_dir/scripts/* ~/.local/bin/
}

function wallpapers () {
  mkdir -p ~/.config/wallpapers

  ln -sf $dotfiles_dir/wallpapers/* ~/.config/wallpapers/
}


#================
# alacritty
#================

function alacritty () {
  mkdir -p ~/.config/alacritty

  ln -sf $dotfiles_dir/alacritty/alacritty.yml ~/.config/alacritty/
}

#================
# kitty
#================

function kitty() {
  mkdir -p ~/.config/kitty

  ln -sf $dotfiles_dir/kitty/kitty.conf ~/.config/kitty/
}

#================
# bash
#================

function bash() {
  ln -sf $dotfiles_dir/bash/.bashrc ~/
  ln -sf $dotfiles_dir/bash/.bash_aliases ~/
  ln -sf $dotfiles_dir/bash/.bash_profile ~/
  ln -sf $dotfiles_dir/bash/.inputrc ~/

  if [ ! -f ~/.bash_secrets ]; then
    echo "Make sure to fill out ~/.bash_secrets"
    cp $dotfiles_dir/bash/.bash_secrets.sample ~/.bash_secrets
  fi
}

#================
# git
#================

function git() {
  ln -sf $dotfiles_dir/git/.gitconfig ~/
  ln -sf $dotfiles_dir/git/.gitignore ~/
}

#================
# tmux
#================

function tmux() {
  rm -rf ~/.tmux_sessions
  mkdir -p ~/.tmux_sessions

  ln -sf $dotfiles_dir/tmux/.tmux.conf ~/
  ln -sf $dotfiles_dir/tmux/sessions/* ~/.tmux_sessions/
}

#================
# nvim
#================

function nvim() {
  rm -rf ~/.config/nvim
  mkdir -p ~/.config/nvim

  ln -sf $dotfiles_dir/nvim/init.lua ~/.config/nvim/

  ln -sf $dotfiles_dir/nvim/after ~/.config/nvim/
  ln -sf $dotfiles_dir/nvim/colors ~/.config/nvim/
  ln -sf $dotfiles_dir/nvim/lua ~/.config/nvim/
}

#================
# ruby
#================

function ruby() {
  ln -sf $dotfiles_dir/ruby/.gemrc ~/
}


#================
# gpg
#================

function gpg() {
  mkdir -p ~/.gnupg

  ln -sf $dotfiles_dir/gnupg/gpg-agent.conf ~/.gnupg
}



#================
#================



hyprland
waybar

xserver
xmonad
eww

alacritty
kitty

wallpapers
scripts

bash
git
gpg

tmux
nvim

ruby
