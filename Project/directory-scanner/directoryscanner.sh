#!/bin/bash
folder="$1"
runind="false"

function show_menu(){
	read -p "
================
 Directory Scanner
=================
1. Show File Inside
2. Show Directory Inside
3. Count File
4. Count Directory
5. Search file
6. Exit

Please Choose : " menuchoice
}

function show_file_inside() {
	for i in $(find "$folder" -type f); do
		echo "${i##*/}"	
	done
}

function show_folder_inside() {
	for i in $(find "$folder" -type d); do 
		if ! [[ "$i" = "$folder" ]]; then
			echo "${i##*/}"
		fi
	done
}
function count_file() {
	countfile="$(find "$folder" -type f | wc -l)"
	echo "$countfile"
}
function count_directory() {
	countdirectory="$(find "$folder" -type d | wc -l)"
	echo "$((countdirectory - 1))"
}
function search_file() {
	read -p "Filename : " filename
	if ! [[ "$filename" = "" ]]; then
		find "$folder" -type f -name "$filename"
	else
		echo "Please give the Filename"
	fi	
}

if [[ "$folder" = "" ]]; then
	echo "Please Include a Directory"
	exit 1
elif [[ -d "$folder" ]]; then
	runind="true"
	while [ "$runind" = "true" ]; do
		sleep 1
		show_menu
		case "$menuchoice" in
	
				1) show_file_inside
					;;
				2) show_folder_inside
					;;
				3) count_file
					;;
				4) count_directory
					;;
				5) search_file
					;;
				6) runind="false"
					;;
		esac
	done
elif [[ -f "$folder" ]]; then
	echo "This is not a Directory"
	exit 1
else
 	echo "Directory Not Found"
fi

