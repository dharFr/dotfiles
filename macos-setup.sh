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
	$PWD/setup/brew.sh

	# -- NPM ------------------------------------------------------------------
	$PWD/setup/npm.sh
}

main