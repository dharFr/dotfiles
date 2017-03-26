# shellcheck disable=SC2148

#
# User configuration sourced by interactive shells
#

# Source zim
if [[ -s "${ZDOTDIR:-${HOME}}"/.zim/init.zsh ]]; then
	# shellcheck disable=SC1090
	source "${ZDOTDIR:-${HOME}}"/.zim/init.zsh
fi

export DOT_FILES="$HOME/.dotfiles"

# Don't display startup logs from Vim shell
function _printf() {
	[[ -z "$MYVIMRC" ]] && printf "%s" "$@"
}

# Clear line
_CL="\\033[0K\\r"

# As `tty` returns something like `/dev/ttys000`,
# we use `${variable#*prefix}` to remove `prefix` from `variable` (in our case /dev/)
_tmp="$DOT_FILES/.tmp-${$(tty)#*/dev/}"

_printf "🤖  Configuring shell...\\n"
touch "$_tmp"
## Load a few scripts from $DOT_FILES
# .extra & .post_extra can be used for settings you don’t want to commit
for _file in $DOT_FILES/rc/{exports,aliases,functions,extra,hub,z,nvm,post_extra}.sh; do
	if [ -r "$_file" ]; then
		_printf " - loading $_file $_CL";
		sleep 0.05;
		# Save outputs from sourced files so we can print them afterward
		# shellcheck disable=SC1090
		source "$_file" >> "$_tmp"
		_printf " - loading $_file ✔ $_CL";
		sleep 0.05;
	fi
done
_printf "🤘  All done \\n"
cat "$_tmp"

# Cleanup everything
rm -f "$_tmp"
unset  _printf, _tmp _CL _file
