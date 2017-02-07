#!/usr/bin/env bash

# Create a new directory and enter it
function md() {
  mkdir -p "$@" && cd "$@"
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX
}

#Start an HTTP server from a directory, optionally specifying the port
function server {
  local port="${1:-8000}"
  open "http://localhost:${port}/"
  python -m SimpleHTTPServer "$port"
}


# grailsenv - Dynamically switch your GRAILS_HOME
# grailsenv [VERSION]
# Try to switch your GRAILS_HOME property to 'grails-VERSION'
# according to the current value
#
# if a 'grails-VERSION' directory exists in the same folder,
# exports a new GRAILS_HOME and add it to the PATH
#
# Without parameters, displays the current GRAILS_HOME value
function grailsenv {


    # without arguments, log available grails folders
    # or check for application.properties file
    if [ -v $1 ]; then
        if [ -f 'application.properties' ]; then
          echo "> reading grails version from application.properties file..."
          __version=`awk -F= '/app.grails.version/ {print $2}' application.properties`
          echo "> found version $__version in application.properties"
        else
          echo ""
          echo "Available versions: "
          gvm list grails
        fi
    else
        __version=$1
    fi

    if [ ! -v $__version ]; then
        gvm use grails $__version
    fi
}

function grailsrun {

  gr_port="8080"
  gr_ip="localhost"
  gr_host=0

  usage() {
    echo "Launch 'grails run-app' with options."
    echo ""
    echo " -h | --help Display help"
    echo " -r | --remote-host Run 'grails run-app' with -Dserver.host={your-ip} option"
    echo " -p | --port Run 'grails run-app' with -Dserver.port={value}"
    echo ""
    echo "Example:"
    echo "> grailsrun -r -p 9090"
    echo "will run => grails -Dserver.host={your-ip} -Dserver.port=9090 run-app "
    echo ""
    echo "> grailsrun -p 8081"
    echo "will run => grails -Dserver.port=8081 run-app "
  }

  while [ "$1" != "" ]; do
    case $1 in
      -p | --port ) shift
                  gr_port=${1}
                  ;;
      -r | --remote-host ) gr_host=1
                  ;;
      -h | --help ) usage
                  exit 1
    esac
    shift
  done

  if [ $gr_host = 1 ]; then
    gr_ip="`ifconfig eth0 | grep inet\ addr:| awk {'print $2'} | sed s/.*://`"
  fi

  echo "| Launching: grails -Dserver.host=$gr_ip -Dserver.port=$gr_port run-app"
  echo ""
  grails -Dserver.host=$gr_ip -Dserver.port=$gr_port run-app
}



# Apply svn sub-command to every newly created file (marked with ? in 'svn status')
# Example :
#
# Add every new file
# > svn-allnew add
#
# Still works with extra parameters
# > svn-allnew add --force
function svn-allnew {
  if [ -z $1 ]; then
    echo "Please add an svn-subcommand as a parameter (try 'svn help')"
  else
    svn st | grep '^\?' | awk '{print $2}' | xargs svn $*
  fi
}

# Apply svn sub-command to every deleted file (marked with ! in 'svn status')
# Example :
#
# Delete every missing file from repo
# > svn-alldeleted delete
#
# Still works with extra parameters
# > svn-alldeleted delete --force
function svn-alldeleted {
  if [ -z $1 ]; then
    echo "Please add an svn-subcommand as a parameter (try 'svn help')"
  else
    svn st | grep '^!' | awk '{print $2}' | xargs svn $*
  fi
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
  tree  -aC -I '.git|node_modules|bower_components|as3corelib|.sass-cache|.DS_Store' --dirsfirst -L $levels $@ | less -FRNX
}
alias t=tre

# Whiteboard Picture Cleaner - Shell one-liner/script to clean up and beautify photos of whiteboards!
# See : https://gist.github.com/lelandbatey/8677901
function whiteboardConvert {

  local __output

  if [ -x convert ]; then
    echo "You'll need imageMagick to run this one ^^"
    echo "> brew install imagemagick"
  elif [ -z $1 ]; then
    echo "Need an input file as 1st parameter"
  else
    if [ -z $2 ]; then
      __output="whiteboardConvert.jpg"
    else
      __output=$2
    fi
    echo "Cleaning Whiteboard Picture:"
    echo "$1 => $__output"
    convert $1 -morphology Convolve DoG:15,100,0 -negate -normalize -blur 0x1 -channel RBG -level 60%,91%,0.1 $__output
    echo done
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

  if [ -z $JIRA_ROOT ]; then
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
  local __branch=`git symbolic-ref --short HEAD 2> /dev/null`;

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

  if [ -z $__issue ] && [ ! -z $__branch ]; then
    __issue=$__branch
  fi

  local __url="${JIRA_ROOT}";

  if [ ! -z $__issue ]; then
    __url="${__url}browse/${__issue}";
  fi

  if $__open; then
    open $__url;
  else
    echo $__url;
  fi
}

function jira2md {
  local __link=`jira -l $1`
  local __label=`echo $__link | sed 's/^.*browse\///'`
  echo "[$__label]($__link)"
}

# Create a data URL from a file
function dataurl() {
  local mimeType=$(file -b --mime-type "$1");
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
    -i $1 \
    -s ${3:-600x400} \
    -pix_fmt rgb24 \
    -r 10 \
    -f gif - | \
    gifsicle --optimize=3 > $2
}