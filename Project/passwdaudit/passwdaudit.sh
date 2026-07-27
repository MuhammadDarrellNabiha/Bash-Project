#!/usr/bin/env bash
running=false
option=$1
file=$2
optionchoice=( "-h" "-iu" "-nu" "-s" "-t" "-a" "-x" "-j" ) 


function interactive_user(){
    nointusrshell=( "nologin" "false" )
    for shellpath in $( awk -F ':' '{print $1 $7}' "$file" ); do 
        shell="${shellpath##*/}"
        user="${shellpath%%/*}"
        nointuser="false"
        for intuser in "${nointusrshell[@]}"; do
            if [[ "$intuser" = "$shell" ]]; then
                nointuser="true"
            fi
        done
        if  [[ ! "$nointuser" = "true" ]]; then
            echo "$user"
        fi
    done 
                 
}

function non_interactive_user(){
    knownshell=( "bash" "fish" "zsh" )
    for shellpath in $( awk -F ':' '{print $1 $7}' "$file" ); do 
        shell="${shellpath##*/}"
        user="${shellpath%%/*}"
        nointuser="false"
        for intuser in "${knownshell[@]}"; do
            if [[ "$intuser" = "$shell" ]]; then
                nointuser="true"
            fi
        done
        if  [[ ! "$nointuser" = "true" ]]; then
            echo "$user"
        fi
    done 
}

function type_shell(){  
    bashcounter=0
    zshcounter=0
    fishcounter=0
    for i in $( awk -F ':' '{print $7}' "$file" ); do
        shell="${i##*/}"
        if [[ "$shell" = "bash" ]]; then
            ((bashcounter++)) 
        elif [[ "$shell" = "zsh" ]]; then
            ((zshcounter++)) 
        elif [[ "$shell" = "fish" ]]; then
            ((fishcounter++))
        fi            
    done

     echo ""$bashcounter" :bash"
     echo ""$zshcounter ":zsh"
     echo ""$fishcounter" :fish"
                 
}


function total_user(){
   totaluser=$(  awk -F ':' '{print $1}' "$file" | wc -l )
   echo "Total User : "$totaluser""
}

function unknown_shell(){
    knownshell=( "zsh" "false" "bash" "fish" "nologin" )
    for i in $( awk -F ':' '{print $7}' "$file" ); do
        shellscan="${i##*/}"
        for shell in "${knownshell[@]}"; do
            if [[ "$shell" = "$shellscan" ]]; then
                known=true
            fi
        done
        if [[ ! "$known" = true ]]; then
            echo "$shellscan"
        fi     
    done                 
}

function all_summary(){
    echo "|========SUMMARY========|"
    total_user
    echo "interactive user" 
        interactive_user | wc -l
    echo "non interactiver user" 
        non_interactive_user | wc -l
    echo "active shell" 
        type_shell
    echo "unknown shell" 
        unknown_shell
}


if [[ -z "$option" &&  -z "$file" ]]; then
    echo "type '-h' for Help"
elif [[ ! -z "$option" ]]; then
    found=false
    for choice in "${optionchoice[@]}"; do
        if [[ "$choice" = "$option" ]]; then
            running=true
            found=true
            break
        fi
    done
    if [[ ! "$found" = true ]]; then
        echo "there is no option called "$option""
        echo "type '-h' for Help"
    fi
fi

if [[ "$running" = true && ! -z "$file" ]]; then
    if [[ -f "$file" ]]; then
    checkpasswdmetadata=$( awk -F ':' 'NR==1{print NF}' "$file" )
        if [[ ! -z "$checkpasswdmetadata" && "$checkpasswdmetadata" = 7 ]]; then
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
                -h) cat instruction.txt
                        ;;
            esac
        else
            echo "ERROR: there is'nt user metadata login in this file"
        fi
    else
        echo "ERROR: The file doesnt exist, please input the correct filepath"
    fi
elif [[ "$running" = true && "$option" = "-h" ]]; then
    cat instruction.txt
elif [[ "$running" = true && ! -z "$option" && -z "$file" ]]; then
    echo "ERROR: Please input the file"
fi
             
    
