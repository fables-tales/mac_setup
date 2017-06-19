#!/bin/bash

sudo xcodebuild -license
git
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
git clone git@github.com:samphippen/dotfiles ~/.dotfiles
brew install chruby
brew install wget
brew install ruby-install
brew install hub
brew install npm
brew install direnv
mkdir -p ~/dev/rspec
git clone git@github.com:rspec/rspec-dev ~/dev/rspec/
