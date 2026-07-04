#!/bin/bash
loopon="true"
		
while [ "$loopon" = "true" ]; do
	read -p "
	 ====================
	Counter Program darrell made
	====================

	1. Count Up
	2. Count Down
	3. Even Number
	4. Odd Number
	5. Exit

	What is u Choice : " menu
	num=0
	case "$menu" in

		1) 
			if [[ "$num" -eq 0 ]]; then
				while [ "$num" -le 100 ]; do
					echo "Angka ke $num"
					((num++))
				done
			else
				num=0
				while [ "$num" -le 100 ]; do
					echo "Angka ke $num"
					((num++))
				done
			fi
			;;
		2) 
			if [[ "$num" -eq 100 ]]; then
				until [ "$num" -lt 1 ]; do
					echo "Angka ke $num"
					((num--))
				done
			else
				num=100
				until [ "$num" -lt 1 ]; do
					echo "Angka ke $num"
					((num--))
				done
			fi		
			;;
		3) 
			if [[ "$num" -eq 2 ]]; then
				while [ "$num" -lt 100 ]; do
					echo "Angka ke $num"
					((num += 2))
				done
			else
				num=2
				while [ "$num" -lt 100 ]; do
					echo "Angka ke $num"
					((num += 2))
				done
			fi
			;;
		4)
			if [[ "$num" -eq 1 ]]; then
				while [ "$num" -le 100 ]; do
					echo "Angka ke $num"
					((num += 2))
				done
			else
				num=1
				while [ "$num" -le 100 ]; do
					echo "Angka ke $num"
					((num += 2))
				done
			fi
			;;
		5)	
			echo " terimakasih : )"
			loopon="false"

			;;
		*)
			echo "tidak ada menu yang ada dipilihan : ), silakan pilih yan lain (0 u 0)"
			;;
			
	esac
done
			
