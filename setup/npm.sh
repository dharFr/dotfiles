#!/usr/bin/env bash

# install lastest node.js
nvm install --lts
nvm alias default lts/*

# install usefull global packages
npm install -g coffee-script
npm install -g eslint
npm install -g coffeelint
npm install -g jsonlint
npm install -g yo
npm install -g emoj      # Fondamental! ♥  😍  😁  🎉  😂  😄  🙌
npm install -g trash-cli # dependency for _Safeguard rm_ alias
npm install -g gifsicle  # dependency for _mov2gif_ function
