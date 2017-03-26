#!/bin/bash

# --------------------------------------------------------------------------
# | Helpers Functions |
# --------------------------------------------------------------------------
cmd_exists() {
	if [ -x "$(command -v "$1")" ]; then
		printf 1
	else
		printf 0
	fi
}
print_success() {
	printf "\e[0;32m ✔ %s\e[0m\n" "$1"
}

print_error() {
	printf "\e[0;31m ✖ %s %s\e[0m\n" "$1" "$2"
}

print_info() {
	printf "\n\e[0;33m %s\e[0m\n\n" "$1"
}

print_result() {
	if [ "$1" -eq 0 ]; then
		print_success "$2"
	else
		print_error "$2"
	fi
}

