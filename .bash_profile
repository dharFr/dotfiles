export DOT_FILES="$HOME/.dotfiles"

echo "bash init..."
## Load .bash_prompt, .functions and .extra from $DOT_FILES
# .extra can be used for settings you don’t want to commit
for file in $DOT_FILES/.{bash_prompt,functions,extra}; do
  [ -r "$file" ] && source "$file"
  echo "| loaded $file"
done

for file in $DOT_FILES/utils/**/*.sh; do
  . $file
  echo "| loaded $file"
done
unset file


# Color settings
export CLICOLOR=1
#export LSCOLORS=ExFxCxDxBxegedabagacad #old one
export LSCOLORS=GxFxCxDxBxegedabagaced

# ruby conf I guess?
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
