#!/bin/bash
PWD=$(pwd)
cd /
# zookeeper
zkServer.sh start
# hadoop
start-all.sh
# spark master
start-master.sh
# spark slaves
start-slaves.sh bigdata:7071
# hive metastore
nohup hive --service metastore > /dev/null &
# hive jdbc
nohup hiveserver2 > /dev/null &
# hbase
start-hbase.sh
cd $PWD
