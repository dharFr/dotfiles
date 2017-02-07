#!/usr/bin/env bash

if [ -d $(brew --prefix hub) ]; then
    eval "$(hub alias -s)"
fi