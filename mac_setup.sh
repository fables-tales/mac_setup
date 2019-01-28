#!/bin/bash
set -ex

install_encryptme() {
    if [ ! -d /Applications/EncryptMe.app ]
    then
        curl -L 'https://app.encrypt.me/transition/download/osx/latest/' > /tmp/encryptme.dmg
        sudo hdiutil attach -nobrowse /tmp/encryptme.dmg
        cp -r /Volumes/EncryptMe/EncryptMe.app /Volumes/EncryptMe/Applications
        sudo hdiutil unattach /Volumes/EncryptMe
    fi
}

install_mac_apps() {
    if [ ! -f ~/.apps_installed ]
    then
        curl -s 'https://macapps.link/en/chrome-dropbox-alfred-docker-iterm-1password-flux-spectacle-spotify-vlc-slack' | sh
    fi
}

activate_xcode() {
    sudo xcodebuild -license
    git
}

brew_install_the_universe() {
    if [ ! -f /usr/local/bin/brew ]
    then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    formulas="chruby wget ruby-install hub npm direnv redis python3 redis ctags elasticsearch jq watch imagemagick selecta htop vim cmake automake autoreconf libtool"
    for formula in $formulas
    do
        brew install $formula || brew upgrade $formula
    done
}

install_rubies() {
    ruby-install ruby 2.5
    ruby-install ruby 2.2.6
    ruby-install ruby 2.2.7
    ruby-install ruby 2.3
    ruby-install ruby 2.4
}

write_defaults() {
    # screenshot location
    defaults write com.apple.screencapture location $HOME/screenshots

    # no key chooser, prefering repeats instead
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
}

install_go() {
    if [[ -z `which go` ]]
    then
        curl https://dl.google.com/go/go1.10.3.darwin-amd64.pkg > /tmp/go.pkg
        sudo installer -pkg /tmp/go.pkg -target /
    fi
}


install_encryptme
install_mac_apps
brew_install_the_universe
install_rubies
write_defaults
install_go

mkdir -p ~/dev

if [ ! -d ~/dev/rspec ]
then
    mkdir -p ~/dev/rspec
    git clone git@github.com:rspec/rspec-dev ~/dev/rspec/
fi

if [ ! -d ~/.dotfiles ]
then
    git clone git@github.com:samphippen/dotfiles ~/.dotfiles
    cd ~/.dotfiles && rake install
fi
echo "now log off"

