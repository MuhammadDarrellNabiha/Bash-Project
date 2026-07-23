#!/usr/bin/env bash
running=false
option=$1
file=$2
optionchoice=( "-h" "-iu" "-nu" "-s" "-t" "-a" "-x" "-j" ) 

if [[ -z "$option" &&  -z "$file" ]]; then
    echo "type '-h' for Instruction"
elif [[ ! -z "$option" ]]; then
    found=false
    for choice in "${optionchoice[@]}"; do
        if [[ "$choice" = "$option" ]]; then
            running=true
            found=true
        fi
    done
    if [[ ! "$found" = true ]]; then
        echo "there is no option called "$option""
    fi
fi

if [[ "$running" = true && ! -z "$file" ]]; then
    if [[ -f "$file" ]]; then
    usrloginlist=$( awk -F ':' '{print $1 $7}' "$file" | grep -i $USER )
        if ! [[ -z "$usrloginlist" ]]; then
            case "$option" in
                -iu) interactive_user
                        ;;
                -nu) non_interactive_user
                        ;;
                -s) type_shell
                        ;;
                -t) total_user
                        ;;
                -a) all_summary
                        ;;
                -x) unknown_shell
                        ;;
                -j) import_json
                        ;;
            esac
        else
            echo "ERROR: there is'nt user metadata login in this file"
        fi
    fi
elif [[ "$running" = true && "$option" = "-h" ]]; then
    cat instruction.txt
elif [[ "$running" = true && ! -z "$option" && -z "$file" ]]; then
    echo "Please input FILEPATH"
fi
             
    
