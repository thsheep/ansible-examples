#!/usr/bin/env bash

mode=$1
name=$2
process=$3
mem_total=$(cat /proc/meminfo | grep "MemTotal" | awk '{printf "%.f",$2/1024}')
cpu_total=$(( $(cat /proc/cpuinfo | grep "processor" | wc -l) * 100 ))

function mempre {
    mem_pre=`tail -n +8 /tmp/.top.txt | awk '{a[$NF]+=$10}END{for(k in a)print a[k],k}' | grep "\b${process}\b$" | cut -d" " -f1`
    echo "$mem_pre"
}

function memuse {
    mem_use=`tail -n +8 /tmp/.top.txt | awk '{a[$NF]+=$10}END{for(k in a)print a[k]/100*'''${mem_total}''',k}' | grep "\b${process}\b$" | cut -d" " -f1`
    echo "$mem_use" | awk '{printf "%.f",$1*1024*1024}'
}

function cpuuse {
    cpu_use=`tail -n +8 /tmp/.top.txt | awk '{a[$NF]+=$9}END{for(k in a)print a[k],k}' | grep "\b${process}\b$" | cut -d" " -f1`
    echo "$cpu_use"
}

function cpupre {
    cpu_pre=`tail -n +8 /tmp/.top.txt | awk '{a[$NF]+=$9}END{for(k in a)print a[k]/('''${cpu_total}'''),k}' | grep "\b${process}\b$" | cut -d" " -f1`
    echo "$cpu_pre"
}


case $name in
    mem)
        if [ "$mode" = "pre" ];then
            mempre
        elif [ "$mode" = "avg" ];then
            memuse
        fi
    ;;
    cpu)
        if [ "$mode" = "pre" ];then
            cpupre
        elif [ "$mode" = "avg" ];then
            cpuuse
        fi
    ;;
    *)
        echo -e "Usage: $0 [mode : pre|avg] [mem|cpu] [process]"
esac