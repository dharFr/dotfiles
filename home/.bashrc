
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export DOT_FILES="$HOME/.dotfiles"

# Don't display startup logs from Vim shell
alias _echo="[ -z \"$MYVIMRC\" ] && echo"

_echo "bash init...."
## Load .bash_prompt, .functions and .extra from $DOT_FILES
# .extra can be used for settings you don’t want to commit
for file in $DOT_FILES/rc/{bash_prompt,exports,aliases,functions,extra,z,nvm}.sh; do
  [ -r "$file" ] && source "$file"
  _echo "|- loaded $file"
done

for file in $DOT_FILES/utils/**/*.sh; do
  . $file
  _echo "|- loaded $file"
done
unset file
unalias _echo

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Prefer French and use UTF-8
export LANG="fr_FR.UTF-8"

# Color settings
export CLICOLOR=1
#export LSCOLORS=ExFxCxDxBxegedabagacad #old one
export LSCOLORS=GxFxCxDxBxegedabagaced

# Enable vi key bindings in bash
set -o vi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# If possible, add tab completion for many more commands
[ -f /etc/bash_completion ] && source /etc/bash_completion

# brew doctor asked for this one
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

if [ -d $(brew --prefix hub) ]; then
    eval "$(hub alias -s)"
fi

# ruby conf I guess?
if [ -d $HOME/.rbenv/bin ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi
if [ -d $HOME/.rbenv/shims ]; then
  export PATH="$HOME/.rbenv/shims:$PATH"
  eval "$(rbenv init -)"
fi

# GVM setup
[[ -s "$HOME/.gvm/bin/gvm-init.sh" && -z $(which gvm-init.sh | grep '/gvm-init.sh') ]] && source "$HOME/.gvm/bin/gvm-init.sh"


if [ -f $DOT_FILES/.post_extra ]; then
  source $DOT_FILES/.post_extra
  echo "|- loaded $DOT_FILES/.post_extra"
fi
