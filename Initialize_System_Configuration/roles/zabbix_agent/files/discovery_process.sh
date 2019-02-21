#!/usr/bin/env bash

top -bw 1000 -n 1 > /tmp/.top.txt
proc_array=`tail -n +8 /tmp/.top.txt | awk '{a[$NF]+=$10}END{for(k in a)print a[k],k}'|sort -gr|head -10|cut -d" " -f2`

length=`echo "${proc_array}" | wc -l`
count=0
echo '{'
echo -e '\t"data":['
echo "$proc_array" | while read line
do
    echo -en '\t\t{"{#PROCESS_NAME}":"'$line'"}'
    count=$(( $count + 1 ))
    if [ $count -lt $length ];then
        echo ','
    fi
done
echo -e '\n\t]'
echo '}'