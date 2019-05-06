#!/usr/bin/env bash

BACKUPDIR="/db_apps/mysql_backup"                                     #定义备份文件路径
KEEPTIME=7                                                             #定义需要删除的文件距离当前的天数
DELFILE=`find $BACKUPDIR -type f -mtime +$KEEPTIME -exec ls {} \;`     #找到天数大于7天的文件
for delfile in ${DELFILE}                                              #循环删除满足天数大于七天的文件
do
rm -f $delfile
done