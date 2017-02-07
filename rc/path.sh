#!/usr/bin/env bash

# brew doctor asked for this one
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# see setup/brew.sh
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH

# ruby conf I guess?
# if [ -d $HOME/.rbenv/bin ]; then
#   export PATH="$HOME/.rbenv/bin:$PATH"
#   eval "$(rbenv init -)"
# fi
# if [ -d $HOME/.rbenv/shims ]; then
#   export PATH="$HOME/.rbenv/shims:$PATH"
#   eval "$(rbenv init -)"
# fi