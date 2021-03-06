#!/usr/bin/env bash

# shellcheck disable=SC1091
source ./setup/_helper-functions.sh

# -- Homebrew ------------------------------------------------------------------
if [ "$(cmd_exists "brew")" -eq 0 ]; then
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
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
# Install Bash 4
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
# brew install bash
# brew tap homebrew/versions
# brew install bash-completion2

# Switch to using brew-installed bash as default shell
# if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
#   echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
#   chsh -s /usr/local/bin/bash;
# fi;

# Install wget with IRI support
brew install wget --enable-iri

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen

# Install other useful binaries
brew install ack
brew install dark-mode
brew install git
brew install imagemagick --with-webp
brew install lynx
brew install tree
brew install editorconfig
brew install markdown
brew install --HEAD hub
brew install z
brew install mas
brew install ffmpeg
brew install gifsicle
brew install shellcheck

# nvm setup
brew install nvm

if [ ! -d "$HOME/.nvm" ]; then
	mkdir "$HOME/.nvm"
fi

# Loads nvm
# shellcheck disable=SC1090
source "$PWD"/rc/nvm.sh

# install lastest node.js
nvm install --lts
nvm alias default lts/*

# Install native apps
brew tap caskroom/cask

# OSX apps
brew cask install 1password
brew cask install airfoil
brew cask install deezer
brew cask install dropbox
brew cask install firefox
brew cask install google-chrome
brew cask install gpgtools
brew cask install moom
brew cask install opera
brew cask install opera-next
brew cask install skype
brew cask install slack
# brew cask install steam
brew cask install vlc

# dev
brew cask install charles
brew cask install iterm2
brew cask install sublime-text
#brew cask install virtualbox

# OSX quick look plugins (from https://github.com/sindresorhus/quick-look-plugins)
brew cask install betterzipql
brew cask install provisionql
brew cask install qlcolorcode
brew cask install qlimagesize
brew cask install qlmarkdown
brew cask install qlprettypatch
brew cask install qlstephen
brew cask install qlvideo
brew cask install quicklook-csv
brew cask install quicklook-json
brew cask install quicklookase
brew cask install suspicious-package
brew cask install webpquicklook


# Remove outdated versions from the cellar
brew cleanup

