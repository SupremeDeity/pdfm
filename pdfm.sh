#!/bin/bash

# Prints help to screen
print_help() {
	echo -e "usage: pdfm <args>\n"

	echo "The following args can be passed to pdfm: "
	echo -e "init\t\t Initializes a git repo and creates a track file."
	echo -e "add\t\t Tracks files using trackfile."
	echo -e "-l | --list \t Prints track file with location."
	echo -e "-h | --help \t Prints this help menu."
	echo -e "-v | --version \t Prints PDFM version."
	exit
}

print_unknown() {
	echo -e "Unknown or mismatched arguments. Use --help for help."
	exit
}

# Prints PDFM version to screen
print_version() {
	echo "PDFM v1.0.0"
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

printTrack() {
	git_dir=$(git rev-parse --show-toplevel)
	file="$git_dir/track.pdfm"

	if [ -f "$file" ]; then
		local crdir="$PWD"
		cd "$git_dir"

		echo -e "Track File Location: $file"
		# Due to -n incomplete line may be read. This should be fine in most cases.
		# https://unix.stackexchange.com/questions/482517/why-does-this-while-loop-not-recognize-the-last-line
		while IFS= read -r line || [ -n "$line" ];
		do
			if [ -n "$line" ]; then
				[[ $line =~ ^#.* ]] && continue
				echo $line
			fi
		done < "$file"

		cd $crdir
	else
		echo "The current repository is not managed by PDFM."
	fi

	exit
}

# Track Modified, deleted, new files
add() {
	git_dir=$(git rev-parse --show-toplevel)
	file="$git_dir/track.pdfm"
	
	if [ -f "$file" ]; then
		local crdir="$PWD"
		cd "$git_dir"
		# Due to -n incomplete line may be read. This should be fine in most cases.
		# https://unix.stackexchange.com/questions/482517/why-does-this-while-loop-not-recognize-the-last-line
		while IFS= read -r line || [ -n "$line" ];
		do
			if [ -n "$line" ]; then
				[[ $line =~ ^#.* ]] && continue
				git add "$line"
			fi
		done < "$file"
	
		cd $crdir
	else
		echo "The current repository is not managed by PDFM."
	fi

	exit
}

# Atleast a single argument should be provided
if [ ! $# -gt 0 ]; then
	print_help
else
	while [ "$1" != "" ]; do
		case $1 in
			init 						)	init
							;;
			add 						)	add
							;;
			-l | --list            		)   tfList
							;;
			-h | --help 				) 	print_help
							;;
			-v | --version				) 	print_version
							;;
			* 							) 	print_unknown
							;;
			
		esac
		shift
	done
fi
