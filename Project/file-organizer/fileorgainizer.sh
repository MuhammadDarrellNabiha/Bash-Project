#!/bin/bash
Folder="$1"

if [ -d  "$Folder" ]; then
	find "$Folder" -type f | while read -r filepath; do
		ext="${filepath##*.}"	
		if [ "$ext" = "jpg" ] || [ "$ext" = "jpeg" ] || [ "$ext" = "png" ]; then
			if [ -d "$Folder/Images" ]; then 
				mv "$filepath" "$Folder/Images"
			else 
				mkdir -p "$Folder/Images"
				mv "$filepath" "$Folder/Images"
			fi
		elif [ "$ext" = "docx" ] || [ "$ext" = "pdf" ] || [ "$ext" = "md" ]; then
			if [ -d "$Folder/Documents" ]; then 
				mv "$filepath" "$Folder/Documents"
			else 
				mkdir -p "$Folder/Documents"
				mv "$filepath" "$Folder/Documents"
			fi
		elif [ "$ext" = "mp3" ] || [ "$ext" = "mp4" ]; then
			if [ -d "$Folder/Video & Audio" ]; then 
				mv "$filepath" "$Folder/Video & Audio"
			else 
				mkdir -p "$Folder/Video & Audio"
				mv "$filepath" "$Folder/Video & Audio"
			fi
		fi
	done
else 
	echo "false"
fi
