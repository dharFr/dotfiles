
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export DOT_FILES="$HOME/.dotfiles"

# Don't display startup logs from Vim shell
alias _echo="[ -z \"$MYVIMRC\" ] && echo"

_echo "bash init...."
## Load .bash_prompt, .functions and .extra from $DOT_FILES
# .extra can be used for settings you don’t want to commit
for file in $DOT_FILES/.{bash_prompt,exports,aliases,functions,extra}; do
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

# This loads NVM
if [ -s $(brew --prefix nvm)/nvm.sh ]; then
  source $(brew --prefix nvm)/nvm.sh
  export NVM_DIR=~/.nvm
  nvm use 0.11

  # Create symlink to nvm current version
  # Should be removed after https://github.com/creationix/nvm/pull/447 merged
  if [ ! -f ~/.nvm/current ]; then
    ln -s $NVM_DIR/$(nvm current) $NVM_DIR/current
  fi

  # Create symlink to current node in /usr/bin/node
  # Useful for Sublime Text to find node
  if [ ! -s /usr/bin/node ]; then
    echo "Creating symlink to node in /usr/bin/node (password required)..."
    sudo ln -s $NVM_DIR/current/bin/node /usr/bin/node
  fi
else
  echo "Couldn't find nvm.sh folder. Run : > brew install nvm"
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
