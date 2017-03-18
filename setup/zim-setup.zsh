#!/usr/bin/env zsh

if [ ! -d "${ZDOTDIR:-${HOME}}/.zim" ]; then
	echo "Cloning zim repository to ${ZDOTDIR:-${HOME}}/.zim"
	git clone --recursive https://github.com/Eriner/zim.git ${ZDOTDIR:-${HOME}}/.zim

	echo "prepend the initialization templates to configs"
	setopt EXTENDED_GLOB
	for template_file ( ${ZDOTDIR:-${HOME}}/.zim/templates/* ); do
		user_file="${ZDOTDIR:-${HOME}}/.${template_file:t}"
		touch ${user_file}
		( print -rn "$(<${template_file})$(<${user_file})" >! ${user_file} ) 2>/dev/null
	done
		
	echo "zim installed. Make sure to open a new terminal and run 'source \${ZDOTDIR:-\${HOME}}/.zlogin' to finish optimization"
fi
