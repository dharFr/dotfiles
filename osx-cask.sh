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

	# --------------------------------------------------------------------------
	# | Installation |
	# --------------------------------------------------------------------------
	print_info "Installation (this may take a while)"

	# -- Check for XCode Command Line Tools ----------------------------------------
	#
	if [ $(cmd_exists "clang") -eq 0 ]; then
		print_error "Before going through this, you may want to install XCode Command Line tools by running : xcode-select --install"
		exit
	else
		print_success "XCode Command Line Tools"
	fi

	# -- Homebrew ------------------------------------------------------------------
	if [ $(cmd_exists "brew") -eq 0 ]; then
		print_info "installing homebrew..."
		ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
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
	brew install phantomjs
	brew install macvim --override-system-vim
	# brew install z

	# Install native apps
	brew tap phinze/homebrew-cask
	brew install brew-cask

	# OSX apps
	brew cask install dropbox
	brew cask install firefox
	brew cask install google-chrome
	brew cask install google-chrome-canary
	brew cask install opera
	brew cask install opera-next
	brew cask install adium
	brew cask install vlc
	brew cask install airfoil
	brew cask install skype
	brew cask install spotify
	brew cask install steam

	# dev
	brew cask install charles
	brew cask install iterm2
	brew cask install macvim
	brew cask install sublime-text
	brew cask install virtualbox

	# OSX quick look plugins (from https://github.com/sindresorhus/quick-look-plugins)
	brew cask install qlcolorcode
	brew cask install qlstephen
	brew cask install qlmarkdown
	brew cask install quicklook-json
	brew cask install qlprettypatch
	brew cask install quicklook-csv
	brew cask install webp-quicklook
	brew cask install suspicious-package


	# Remove outdated versions from the cellar
	brew cleanup
}

main
