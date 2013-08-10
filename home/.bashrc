
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export DOT_FILES="$HOME/.dotfiles"

echo "bash init...."
## Load .bash_prompt, .functions and .extra from $DOT_FILES
# .extra can be used for settings you don’t want to commit
for file in $DOT_FILES/.{bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && source "$file"
  echo "|- loaded $file"
done

for file in $DOT_FILES/utils/**/*.sh; do
  . $file
  echo "|- loaded $file"
done
unset file

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

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# If possible, add tab completion for many more commands
[ -f /etc/bash_completion ] && source /etc/bash_completion

# Node Setup
export PATH=$HOME/local/bin:$PATH
if [ ! -x $HOME/local/bin/node ]; then 
  echo "node isn't installed in '$HOME/local/bin/node'. Check your install or run 'setup-nodejs' to install it properly"
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

# This loads NVM
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh

if [ -f $DOT_FILES/.post_extra ]; then
  source $DOT_FILES/.post_extra
  echo "|- loaded $DOT_FILES/.post_extra"
fi
