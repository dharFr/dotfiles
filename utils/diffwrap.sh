#!/bin/sh

# use vimdiff for svn diff
#
# Then change your $HOME/.subversion/config file to point at that script:
#
#    [helpers]
#    diff-cmd = /home/oad/.dotfiles/utils/diffwrap.sh

#
# see: http://blog.tplus1.com/index.php/2007/08/29/how-to-use-vimdiff-as-the-subversion-diff-tool/

# Configure your favorite diff program here.
DIFF="/usr/bin/vimdiff"

# Subversion provides the paths we need as the sixth and seventh
# parameters.
LEFT=${6}
RIGHT=${7}

# Call the diff command (change the following line to make sense for
# your merge program).
$DIFF $LEFT $RIGHT

# Return an errorcode of 0 if no differences were detected, 1 if some were.
# Any other errorcode will be treated as fatal.
