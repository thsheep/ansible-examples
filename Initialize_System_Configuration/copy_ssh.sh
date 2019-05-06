#!/usr/bin/env bash

cat ./host | while read line
do
    echo "正在处理：${line}"
    ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no rpa-user@${line}
done
