#!/bin/bash
# spark master
stop-master.sh
# spark slaves
stop-slaves.sh
# hadoop
stop-all.sh
# hive
HIVE_PIDS=$(jps|grep RunJar|sed 's/\(\d*\)\sRunJar/\1/g')
for pid in $HIVE_PIDS; do
  kill $pid
done
# hbase
stop-hbase.sh
# zookeeper
zkServer.sh stop
