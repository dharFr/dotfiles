#
# User configuration sourced by interactive shells
#

# Source zim
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

export DOT_FILES="$HOME/.dotfiles"

# Don't display startup logs from Vim shell
alias _printf="[[ -z \"$MYVIMRC\" ]] && printf"

# Clear line
_PAD="                                           "
_CL="$_PAD\\r"

_printf "🤖  Configuring shell...\\n"
touch $DOT_FILES/.tmp
## Load a few scripts from $DOT_FILES
# .extra & .post_extra can be used for settings you don’t want to commit
for _file in $DOT_FILES/rc/{exports,aliases,functions,extra,hub,z,nvm,post_extra}.sh; do
  if [ -r $_file ]; then
    _printf " - loading $_file $_CL";
    sleep 0.05;
    # Save outputs from sourced files so we can print them afterward
    source "$_file" >> $DOT_FILES/.tmp
    _printf " - loading $_file ✔ $_CL";
    sleep 0.05;
  fi
done
_printf "🤘  All done $_PAD\\n"
cat $DOT_FILES/.tmp

# Cleanup everything
unalias _printf
unset  _PAD _CL _file
rm -f $DOT_FILES/.tmp
