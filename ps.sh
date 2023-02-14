#!/bin/bash
# Собственная реализация ps ax методом анализа /proc


#find /proc/ -maxdepth 1 -type d -name [0-9]*| awk 'FS="/" {print $3}'
#dirs[]='find /proc/ -maxdepth 1 -type d -name [0-9]*'
#dirs=( $(find /proc/ -maxdepth 1 -type d -name [0-9]*) )
printf "%-10s %-6s %-3s %-30s \n"  PID TTY STAT TIME COMMAND 
for i in `ls /proc/ |egrep "^[0-9]"|sort -n`
#for i in "${dirs[@]}"
    do       
        if test -f /proc/$i/status ; then 
            STAT=`cat /proc/$i/status|grep State: |awk '{print $2}'`
        else 
            STAT=''
        fi
        if test -f /proc/$i/cmdline ; then 
            COMMAND=`cat /proc/$i/cmdline`
        else 
            COMMAND=''
        fi  
        if test -h /proc/$i/fd/0 ; then 
            TTY=`ls -l  /proc/$i/fd/0|awk '{print $11}'|sed -e 's/\/dev\///g'`
            if 
                

        else 
            TTY='?'
        fi    

        #echo $i,$STAT| column -t -c 20 -s ","
        printf "%-10s %-6s %-3s %-30s \n"   $i $TTY $STAT $COMMAND
    done
