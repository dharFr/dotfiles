#!/usr/bin/env bash

# Highlight section titles in manual pages
export LESS_TERMCAP_md="$ORANGE"
export EDITOR=subl

#
# gotta tune that bash_history…
# Mostly from https://github.com/paulirish/dotfiles/blob/cd23b0975a873593d418dfa969cb0c6731e9f35b/.bash_profile#L36-L53
#

# Keep track of when a command was launched http://www.debian-administration.org/users/rossen/weblog/1
export HISTTIMEFORMAT='%F %T '

# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# keep history up to date, across sessions, in realtime
#  http://unix.stackexchange.com/a/48113
export HISTCONTROL=ignoredups:erasedups         # no duplicate entries
export HISTSIZE=100000                          # big big history (default is 500)
export HISTFILESIZE=$HISTSIZE                   # big big history
which shopt > /dev/null && shopt -s histappend  # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# ^ the only downside with this is [up] on the readline will go over all history not just this bash session.

# Required by CoreUtils (see macos-setup.sh)
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH

# Look into local node_modules first
export PATH=./node_modules/.bin:$PATH
