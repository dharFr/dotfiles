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

# Prefer French and use UTF-8
export LANG="fr_FR.UTF-8"

# Color settings
export CLICOLOR=1
#export LSCOLORS=ExFxCxDxBxegedabagacad #old one
export LSCOLORS=GxFxCxDxBxegedabagaced

# If possible, add tab completion for many more commands
[ -f /etc/bash_completion ] && source /etc/bash_completion

# ruby conf I guess?
if [ -d $HOME/.rbenv/bin ]; then
	export PATH="$HOME/.rbenv/bin:$PATH"
	eval "$(rbenv init -)"
fi

# GVM setup
[[ -s "$HOME/.gvm/bin/gvm-init.sh" && -z $(which gvm-init.sh | grep '/gvm-init.sh') ]] && source "$HOME/.gvm/bin/gvm-init.sh"

# This loads NVM
[[ -s /home/oad/.nvm/nvm.sh ]] && . /home/oad/.nvm/nvm.sh
