#!/usr/bin/env bash

# Dependencies
# See https://powerline.readthedocs.io/en/latest/installation/osx.html
brew install python
pip install --user powerline-status

echo "Cloning powerline/fonts repository to ${HOME}/.fonts/powerline-fonts..."
git clone git@github.com:powerline/fonts.git "${HOME}/.fonts/powerline-fonts"
echo "Done."
echo "You probably need to run Powerline fonts install script"
echo "> cd ${HOME}/.fonts/powerline-fonts && ./install.sh"
echo "see : https://github.com/powerline/fonts"
