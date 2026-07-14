#!/bin/bash
file="$1"
running="false"

show_menu (){
    read -p "
   ========================
        LOG ANALYZER
   ========================
   
   1. Summary
   2. Show Errors
   3. Search Keyword
   4. Top Errors
   5. Generate Report
   6. Exit
   
   Choice : " menu
}
summary_log (){
        filename="${file##*/}"
        totallog="$( cat $file | wc -l )"
        info="$( cat $file | grep -i info | wc -l )"
        warning="$( cat $file | grep -i warning | wc -l )"
        error="$( cat $file | grep -i error | wc -l )"
        echo "========= Log Analyzer =========="
        echo "file        : $filename" 
        echo "Totals Logs : $totallog"
        echo "Info        : $info"
        echo "Warning     : $warning"
        echo "Error       : $error"
        echo "================================="
}
show_errors (){
    cat "$file" | grep -i error
}

search_keyword (){
    read -p "Give The Keyword Log : " keyword
    cat "$file" | grep -i "$keyword"
}

top_error () {
   grep -i "ERROR" "$file" |
    while IFS= read -r line; do
        echo "${line#*ERROR}"
    done
}


generate_report () {
    touch report.txt
    {
        echo "==================REPORT=================="
        echo "===================ERROR==================="
        show_errors
        echo "==================TOP ERROR==============="
        top_error
        echo "==================SUMMARY================="
        summary_log
    } > report.txt
    echo "Report has been created"
}
   


if [[ "$file" = "" ]]; then
    echo "Please Input File"
elif [[ -f "$file" ]]; then
    running="true"
    while [ "$running" = "true" ]; do
        sleep 0.6
        show_menu
        case "$menu" in 
            1) summary_log
                ;;
            2) show_errors
                ;;
            3) search_keyword
                ;;
            4) top_error
                ;;
            5) generate_report
                ;;
            6) running="false"
                ;;
        esac
    done
elif [[ -d "$file" ]]; then
    echo "This is Not a File"   
else 
    echo "The File Didnt Exist"  
fi
