#!/usr/bin/env bash

# List all files colorized in long format
alias ll="ls -Gl"
alias lla="ls -Gla"
alias npmeu="npm --registry http://registry.npmjs.eu/"
# npm alias for offline mode.
# e.g. `npmoffline install <package-I-already-installed>`
# See https://soledadpenades.com/2015/05/31/npmoffline-installing-npm-packages-from-the-cache/
alias npmoffline="npm --cache-min 9999999 "

# Safeguard rm
# see https://github.com/sindresorhus/guides/blob/master/how-not-to-rm-yourself.md#safeguard-rm
alias rm='rm -i'

# prevent obvious git typo
alias gti='echo " 🚗 💨" && git'

# Always use color output for `ls`
if [[ "$OSTYPE" =~ ^darwin ]]; then
	alias ls="command ls -G"
else
	alias ls="command ls --color"
	export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
fi

# Flash debug logs shortcut
alias flog='tail -f ~/Library/Preferences/Macromedia/Flash\ Player/Logs/flashlog.txt'
