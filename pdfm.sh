#!/bin/bash

# Prints help to screen
print_help() {
	echo -e "usage: pdfm <subcommand> <args> [options]\n"

	echo "There are following options: "
	echo -e "init\t\t Initializes a git repo and creates a track file."
	echo -e "add\t\t Tracks files using trackfile argument."
	echo -e "-h | --help \t Prints this help menu."
	echo -e "-v | --version \t Prints PDFM version."

	exit
}

# Prints PDFM version to screen
print_version() {
	echo "PDFM v0.1"
	exit
}

# (Re)Initializes Git Repo and other prerequsites
init() {
	git init

	echo > $PWD/track.pdfm
	echo "PDFM is now tracking $PWD"
	echo "Please edit $PWD/track.pdfm to add required files/directories"

	exit
}
# Track Modified, deleted, new files
add() {
	git_dir=$(git rev-parse --show-toplevel)
	file="$git_dir/track.pdfm"

	# Due to -n incomplete line may be read. This should be fine in most cases.
	# https://unix.stackexchange.com/questions/482517/why-does-this-while-loop-not-recognize-the-last-line
	while IFS= read -r line || [ -n "$line" ];
	do
		git add "$line"
	done < "$file"

	exit
}

# Atleast a single argument should be provided
if [ ! $# -gt 0 ]; then
	print_help
else
	while [ "$1" != "" ]; do
		case $1 in
			init )			init
							;;
			add )			add "$@"
							;;
			-h | --help ) 	print_help
							;;
			-v | --version) print_version
							;;
			* ) 			print_help
							;;
			
		esac
		shift
	done
fi
