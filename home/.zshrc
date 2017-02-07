#
# User configuration sourced by interactive shells
#

# Source zim
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

export DOT_FILES="$HOME/.dotfiles"

# Don't display startup logs from Vim shell
alias _echo="[[ -z \"$MYVIMRC\" ]] && echo"

_echo "bash init...."
## Load .bash_prompt, .functions and .extra from $DOT_FILES
# .extra can be used for settings you don’t want to commit
for file in $DOT_FILES/rc/{exports,aliases,functions,extra,z,nvm}.sh; do
  _echo "|- loading $file"
  [ -r "$file" ] && source "$file"
done
unset file