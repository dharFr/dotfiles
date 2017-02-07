#!/usr/bin/env bash

# This loads NVM
if [ -s $(brew --prefix nvm)/nvm.sh ]; then
  source $(brew --prefix nvm)/nvm.sh
  export NVM_DIR="$HOME/.nvm"
  nvm use default

  # nvm use will not, by default, create a "current" symlink. Set
  # $NVM_SYMLINK_CURRENT to "true" to enable this behavior, which is sometimes
  # useful for IDEs. See https://github.com/creationix/nvm#usage
  export NVM_SYMLINK_CURRENT="true"

  # Create symlink to current node in /usr/bin/node
  # Useful for Sublime Text to find node
  if [ ! -s /usr/local/bin/node ]; then
    echo "Creating symlink to node in /usr/local/bin/node (password required)..."
    sudo ln -s $NVM_DIR/current/bin/node /usr/local/bin/node
  fi

  # Add completion for npm commands
  source <(npm completion)
else
  echo "Couldn't find nvm.sh folder. Run : > brew install nvm"
fi