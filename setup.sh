#!/usr/bin/env bash

echo "Starting setup"

xcode-select --install

if test ! $(which brew); then
	echo "Installing homebrew..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update homebrew recipes
brew update

PACKAGES=(
	git
	python
	zsh
	php
	mysql@5.7
	composer
	node@14
	yarn
	kubectl
	kubectx
	exa
	stern
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Installing cask..."

CASKS=(
	iterm2
	slack
	spotify
	brave-browser
	discord
	whatsapp
	sublime-text
	tableplus
	alfred
	megasync
	intellij-idea
	viscosity
	prusaslicer
	the-unarchiver
	vlc
	skype
	autodesk-fusion360
	moneymoney
	composer
	lens
	kap
	dash
	teamviewer
	docker
)

echo "Installing cask apps..."
brew install --cask ${CASKS[@]}

echo "Install prezto"

if [ ! -d $HOME/.prezto ]; then
	git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
	setopt EXTENDED_GLOB
fi

echo "Set ZSH as default"

chsh -s /bin/zsh

echo "Install Valet"
if test ! $(which valet); then
	composer global require laravel/valet
	valet install
fi

echo "MacOS Setup completed 🤘"
