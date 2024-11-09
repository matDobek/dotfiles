#!/usr/bin/env bash

function install() {
  asdf plugin add $1
  asdf install $1 latest
  asdf local $1 latest
}

cd ~

install erlang
install elixir

install ruby
install python

install nodejs

install golang
install rust

install lua
