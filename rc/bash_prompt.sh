#!/usr/bin/env bash
# shellcheck disable=SC1004

############################################
# Modified from emilis bash prompt script
# from https://github.com/emilis/emilis-config/blob/master/.bash_ps1
#
# Modified for Mac OS X by
# @corndogcomputer
#
# Customized by @_dhar
###########################################

# Fill with minuses
# (this is recalculated every time the prompt is shown in function prompt_command):
fill="--- "

# Colors please
#black='\[\e[0;30m\]'
#darkGray='\[\e[1;30m\]'
gray='\[\e[0;90m\]'
#lightGray='\[\e[0;37m\]'
#blue='\[\e[0;34m\]'
#lightBlue='\[\e[1;34m\]'
green='\[\e[0;32m\]'
#lightGreen='\[\e[1;32m\]'
cyan='\[\e[0;36m\]'
#lightCyan='\[\e[1;36m\]'
red='\[\e[0;31m\]'
#lightRed='\[\e[1;31m\]'
purple='\[\e[0;35m\]'
#lightPurple='\[\e[1;35m\]'
#brown='\[\e[0;33m\]'
Byellow='\[\e[1;33m\]'
yellow='\[\e[0;33m\]'
white='\[\e[1;37m\]'

cEnd='\[\e[m\]'

PROMPT_PREFIX="⚡ "

# Prompt variable:

# PS1="\n$gray"'$fill \t\n'"$white('-_-) $cyan"'${debian_chroot:+($debian_chroot)}\u'"$white@$purple\h$white: $yellow\w$white \n$green\$$white "
PS1="\n$gray"'$fill \t\n'                           # first line filled with dashes and current time on the right
# PS1=$PS1$green"┌┤"                                # ┌─
PS1=$PS1$white'$(echo "$PROMPT_PREFIX")'              # [white] prompt prefix (can be overwrited depending on the env)
# shellcheck disable=SC2154
PS1=$PS1$cyan'${debian_chroot:+($debian_chroot)}\u' # [cyan]  user
PS1=$PS1$white@$purple'\h'$white': '$cEnd           # [white] @ [purple] host [white] : [no-color]

# GIT Bash prompt. See http://mediadoneright.com/content/ultimate-git-ps1-bash-prompt
# [red|green] branch [yellow|Byellow] (depends on we're on a git repo or not)
PS1=$PS1'$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # @4 - Clean repository - nothing to commit
    echo "'$green'"$(__git_ps1 "(%s)"); \
  else \
    # @5 - Changes to working tree
    echo "'$red'"$(__git_ps1 "{%s}"); \
  fi) '$Byellow'"; \
else \
  # @2 - Prompt when not in GIT repo
  echo "'$yellow'"; \
fi)'
PS1=$PS1'\w'$cEnd'\n'                               # current dir [no-color] new line
PS1=$PS1$green"↳  "$cEnd                            # [green] └─▻ [no-color]
# shellcheck disable=SC2154
PS1=$PS1$nc

PS2="$green>$white "

# Reset color for command output
# (this one is invoked every time before a command is executed):
trap 'echo -ne "\033[00m"' DEBUG


function prompt_command {

  # create a $fill of all screen width minus the time string and a space:
  let fillsize=${COLUMNS}-9
  fill=""
  while [ "$fillsize" -gt "0" ]
  do
    fill="-${fill}" # fill with underscores to work on
    let fillsize=${fillsize}-1
  done

  # If this is an xterm set the title to user@host:dir
  case "$TERM" in
    xterm*|rxvt*)
    bname=$(basename "${PWD/$HOME/~}")
    echo -ne "\033]0;${bname}: ${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"
    ;;
    *)
    ;;
  esac

}
PROMPT_COMMAND=prompt_command
