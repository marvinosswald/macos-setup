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
	git-lfs
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
	helm
	git-flow-avh
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
	lens
	kap
	dash
	teamviewer
	docker
)

echo "Installing cask apps..."
brew install --cask ${CASKS[@]}

if [ ! -d $HOME/.zprezto ]; then
	echo "Install prezto"
	git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
	setopt EXTENDED_GLOB
fi

if [ "$SHELL" != "/bin/zsh" ]; then
	echo "Set ZSH as default"
	chsh -s /bin/zsh
fi

echo "Install Valet"
if test ! $(which valet); then
	composer global require laravel/valet
	valet install
fi

if [ ! -f $HOME/.gitconfig ]; then
	echo "Setup Git"
	cp ./templates/gitconfig.template $HOME/.gitconfig
	sed -i "" "s/{{NAME}}/Marvin Osswald/g" $HOME/.gitconfig
	sed -i "" "s/{{EMAIL}}/mail@marvinosswald.de/g" $HOME/.gitconfig
fi

echo "MacOS Setup completed 🤘"
