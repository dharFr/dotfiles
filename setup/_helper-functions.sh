#!/bin/bash

# --------------------------------------------------------------------------
# | Helpers Functions |
# --------------------------------------------------------------------------
cmd_exists() {
	[ -x "$(command -v "$1")" ] \
		&& printf 1 \
		|| printf 0
}
print_success() {
	printf "\e[0;32m ✔ $1\e[0m\n"
}

print_error() {
	printf "\e[0;31m ✖ $1 $2\e[0m\n"
}

print_info() {
	printf "\n\e[0;33m $1\e[0m\n\n"
}

print_result() {
	[ $1 -eq 0 ] \
		&& print_success "$2" \
		|| print_error "$2"
}

