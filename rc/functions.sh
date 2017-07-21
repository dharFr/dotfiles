#!/usr/bin/env bash

# Create a new directory and enter it
function md() {
	mkdir -p "$@" && cd "$@" || return
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
	local port="${1:8000}";
	sleep 1 && open "http://localhost:${port}/" &
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
}

# Start a PHP server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
function phpserver() {
	local port="${1:-4000}"
	local ip
	ip="$(ipconfig getifaddr en1)"
	sleep 1 && open "http://${ip}:${port}/" &
	php -S "${ip}:${port}";
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
# Defaults to 3 levels deep, do more with `t 5` or `t 1`
# pass additional args after
# See : https://gist.github.com/wesbos/1432b08749e3cd2aea22fcea2628e2ed
function tre() {
	local levels=${1:-3}; shift
	tree  -aC -I '.git|node_modules|bower_components|as3corelib|.sass-cache|.DS_Store' --dirsfirst -L "$levels" "$@" | less -FRNX
}
alias t=tre

# Whiteboard Picture Cleaner - Shell one-liner/script to clean up and beautify photos of whiteboards!
# See : https://gist.github.com/lelandbatey/8677901
function whiteboardConvert {
	local __output

	if [ -x convert ]; then
		echo "You'll need imageMagick to run this one ^^"
		echo "> brew install imagemagick"
	elif [ -z "$1" ]; then
		echo "Need an input file as 1st parameter"
	else
		if [ -z "$2" ]; then
			__output="whiteboardConvert.jpg"
		else
			__output="$2"
		fi
		echo "Cleaning Whiteboard Picture:"
		echo "$1 => $__output"
		convert "$1" -morphology Convolve DoG:15,100,0 -negate -normalize -blur 0x1 -channel RBG -level 60%,91%,0.1 "$__output"
		echo "done"
	fi
}

# JIRA link from the command-line
# Open JIRA according to either the current git branch or the provided parameter
#
# Usage: jira [options]         open the current branch name as a JIRA issue
#    or: jira [options] [issue] open the given JIRA issue
#
# Options:
#  -h | --help : Display help
#  -l | --link : Output issue URL to std out instead of opening it in the browser
#
# Setup:
# Set JIRA_ROOT variable in your environment before use
#  e.g : export JIRA_ROOT='https://jira.yourdomain.com/'
#
# See : https://gist.github.com/dharFr/ff092917ffad831f9a38
function jira {

	if [ -z "$JIRA_ROOT" ]; then
		echo "Please set JIRA_ROOT variable in your environment";
		echo " e.g : export JIRA_ROOT='https://jira.yourdomain.com/'";
		return 1;
	fi

	usage() {
		echo "JIRA link from the command-line"
		echo "Open JIRA according to either the current git branch or the provided parameter"
		echo ""
		echo "Usage: jira [options]         open the current branch name as a JIRA issue"
		echo "   or: jira [options] [issue] open the given JIRA issue"
		echo ""
		echo "Options: "
		echo " -h | --help : Display help"
		echo " -l | --link : Output issue URL to std out instead of opening it in the browser"
		echo ""
		echo "Setup: "
		echo "Set JIRA_ROOT variable in your environment before use"
		echo " e.g : export JIRA_ROOT='https://jira.yourdomain.com/'"
		echo ""
		echo "See : https://gist.github.com/dharFr/ff092917ffad831f9a38"
	}

	local __issue;
	local __open=true;
	local __branch
	__branch="$(git symbolic-ref --short HEAD 2> /dev/null)";

	while [ "$1" != "" ]; do
		case $1 in
			-l | --link ) __open=false
									;;
			-h | --help ) usage
									return 1
									;;
			* ) __issue=$1
									;;
		esac
		shift
	done

	if [ -z "$__issue" ] && [ ! -z "$__branch" ]; then
		__issue="$__branch"
	fi

	local __url="${JIRA_ROOT}";

	if [ ! -z "$__issue" ]; then
		__url="${__url}browse/${__issue}";
	fi

	if $__open; then
		open "$__url";
	else
		echo "$__url";
	fi

	unset -f usage;
}

function jira2md {
	local __link
	local __label
	__link=$(jira -l "$1")
	__label=$(echo "$__link" | sed 's/^.*browse\///')
	echo "[$__label]($__link)"
}

# Create a data URL from a file
function dataurl() {
	local mimeType
	mimeType=$(file -b --mime-type "$1")
	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8";
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}

# Convert movie to gif
# Alternatively, thefollowing could be used if gifsicle dependency is missing :
# > ffmpeg -i $1 -vf scale=${3:-600x400} -r 30 $2
function mov2gif() {
	ffmpeg \
		-i "$1" \
		-s "${3:-600x400}" \
		-pix_fmt rgb24 \
		-r 10 \
		-f gif - | \
		gifsicle --optimize=3 > "$2"
}

# Determine size of a file or total size of a directory
function fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* ./*;
	fi;
}

# Compare original and gzipped file size
function gz() {
	local origsize
	local gzipsize
	local ratio
	origsize=$(wc -c < "$1");
	gzipsize=$(gzip -c "$1" | wc -c);
	ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l);
	printf "orig: %d bytes\n" "$origsize";
	printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio";
}

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
function json() {
	if [ -t 0 ]; then # argument
		python -mjson.tool <<< "$*" | pygmentize -l javascript;
	else # pipe
		python -mjson.tool | pygmentize -l javascript;
	fi;
}

# Pick a random value from the provided arguments
# > randomPick one two three four
# two
# > randomPick one two three four
# one
function randomPick() {
	printf "%s\n" "$@" | sort -R | head -n 1;
}
