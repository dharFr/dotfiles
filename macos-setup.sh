#!/bin/bash -e

. ./setup/_helper-functions.sh

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

	# -- Homebrew -------------------------------------------------------------
	$PWD/setup/brew.sh

	# -- NPM ------------------------------------------------------------------
	$PWD/setup/npm.sh

	# -- Mac App Store --------------------------------------------------------
	$PWD/setup/mas.sh

	# -- Powerline fonts ------------------------------------------------------
	$PWD/setup/powerline-fonts.sh
}

main
