#!/usr/bin/env bash

if [ -d "$(brew --prefix z)" ]; then
	# shellcheck disable=SC1091
	. /usr/local/etc/profile.d/z.sh
fi
