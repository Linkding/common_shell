#!/bin/bash
lastline=`tail -1 /home/patrol/zabbix/scripts/portlist1.txt`
porlist=`cat /home/patrol/zabbix/scripts/portlist1.txt` 

echo "{\"data\":["
for i in $porlist
do
        ip1=`echo $i |awk -F ',' '{print $1}'`
        port1=`echo $i |awk -F ',' '{print $2}'`
        if [ "$i" != "$lastline" ];then
                echo "          {\"{#IP}\":\"$ip1\",\"{#PORT}\":\"$port1\",\"{#NAME}\":\"$name\"},"
        else
                echo "           {\"{#IP}\":\"$ip1\",\"{#PORT}\":\"$port1\",\"{#NAME}\":\"$name\"}"
        fi
done
echo "]}"