#!/bin/bash

# --------------------------------------------------------------------------
# | Helpers Functions |
# --------------------------------------------------------------------------
cmd_exists() {
	[ -x "$(command -v "$1")" ] \
		&& printf 1 \
		|| printf 0
}
print_success() {
	printf "\e[0;32m ✔ $1\e[0m\n"
}

print_error() {
	printf "\e[0;31m ✖ $1 $2\e[0m\n"
}

print_info() {
	printf "\n\e[0;33m $1\e[0m\n\n"
}

print_result() {
	[ $1 -eq 0 ] \
		&& print_success "$2" \
		|| print_error "$2"
}

function main() {
	# Ensure the OS is Mac OS X
	if [ "$(uname -s)" != "Darwin" ]; then
		print_error "Sorry, this script is for Mac OS X only!"
		exit
	fi
	
	# -- Make sure we use ZSH shell ----------------------------------------
	if [ $SHELL != $(which zsh) ]; then 
		print_info "Switching to ZSH as a default shell. Please restart the script once done."
		chsh -s $(which zsh) 
	else 
		print_info "Already using ZSH shell. All good 👍"
	fi


	# --------------------------------------------------------------------------
	# | Installation |
	# --------------------------------------------------------------------------
	print_info "Installation (this may take a while)"

	# -- Check for XCode Command Line Tools ----------------------------------------
	#
	if [ -z `xcode-select -p` ]; then
		print_error "Before going through this, you may want to install XCode Command Line tools by running : xcode-select --install"
		exit
	else
		print_success "XCode Command Line Tools"
	fi
	
	# -- Install zim for ZSH ------------------------------------------------------------------
	if [ ! -d "${ZDOTDIR:-${HOME}}/.zim" ]; then
		$PWD/setup/zim-setup.zsh		
	fi

	# -- Homebrew ------------------------------------------------------------------
	if [ $(cmd_exists "brew") -eq 0 ]; then
		print_info "installing homebrew..."
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		print_result $? "homebrew"
		sleep 10
	else
		print_success "homebrew"
	fi

	# Make sure we’re using the latest Homebrew
	brew update

	# Upgrade any already-installed formulae
	brew upgrade

	# Install GNU core utilities (those that come with OS X are outdated)
	brew install coreutils
	echo "Don’t forget to add $(brew --prefix coreutils)/libexec/gnubin to \$PATH."
	# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
	brew install findutils
	# Install Bash 4
	brew install bash

	# Install wget with IRI support
	brew install wget --enable-iri

	# Install more recent versions of some OS X tools
	brew tap homebrew/dupes
	brew install homebrew/dupes/grep

	# Install other useful binaries
	brew install ack
	brew install git
	brew install lynx
	# brew install node # see bash/function.sh => setup-nodejs
	brew install tree
	brew install macvim --override-system-vim
	brew install editorconfig
	brew install markdown
	brew install --HEAD hub
	brew install z
	brew install nvm
	mkdir ${HOME}/.nvm

	# Install native apps
	brew tap caskroom/cask

	# OSX apps
	brew cask install 1password
	brew cask install gpgtools
	brew cask install dropbox
	brew cask install firefox
	brew cask install google-chrome
	brew cask install opera
	brew cask install opera-next
	brew cask install vlc
	brew cask install airfoil
	brew cask install skype
	brew cask install deezer
	brew cask install slack
	#brew cask install steam

	# dev
	brew cask install charles
	brew cask install iterm2
	brew cask install sublime-text
	#brew cask install virtualbox

	# OSX quick look plugins (from https://github.com/sindresorhus/quick-look-plugins)
	brew cask install qlcolorcode
	brew cask install qlstephen
	brew cask install qlmarkdown
	brew cask install quicklook-json
	brew cask install qlprettypatch
	brew cask install quicklook-csv
	brew cask install betterzipql
	brew cask install qlimagesize
	brew cask install webpquicklook
	brew cask install suspicious-package
	brew cask install quicklookase
	brew cask install qlvideo
	brew cask install provisionql


	# Remove outdated versions from the cellar
	brew cleanup

	# install lastest node.js
	nvm install --lts
	nvm alias default lts/*

	# install usefull global packages
	npm install -g coffee-script
	npm install -g eslint
	npm install -g coffeelint
	npm install -g jsonlint
	npm install -g yo
	npm install -g trash-cli # dependency for _Safeguard rm_ alias
	npm install -g gifsicle  # dependency for _mov2gif_ function
}

main