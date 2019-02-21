#!/usr/bin/env bash

NAME=`cat /etc/hostname`
SERVER_IP=10.17.126.36
sudo sed -i "s/Hostname=Zabbix server/Hostname=$NAME/g" /etc/zabbix/zabbix_agentd.conf
sudo sed -i "s/Server=127.0.0.1/Server=SERVER_IP/g" /etc/zabbix/zabbix_agentd.conf
sudo systemctl enable zabbix-agent
sudo systemctl start zabbix-agent
sudo cat /etc/zabbix/zabbix_agentd.conf | grep Hostname=
sudo cat /etc/zabbix/zabbix_agentd.conf | grep Server=
