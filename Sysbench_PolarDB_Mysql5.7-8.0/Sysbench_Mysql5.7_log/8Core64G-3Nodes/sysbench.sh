#!/bin/sh
LUA=/usr/share/sysbench/oltp_read_write.lua
SIZE=100000000
DB=mysql
#HOST=pc-0iw162qaide5441z8.mysql.polardb.japan.rds.aliyuncs.com
HOST=pc-0iw7xr702y48yl2c1.rwlb.japan.rds.aliyuncs.com
PORT=3306
USER=sbtest
PASSWORD=Test1234
DBNAME=sbtest
usage()
{
  echo "Usage: ./sysbench.sh <prepare|run|cleanup> <num of threads>"
  exit "${1}"
}
#chack argumets
if [ "${1}" = "" -o $# -gt 3 ]; then
  usage 1
elif [ "${2}" = "" ]; then
  THREADS=1
else
  THREADS=${2}
fi
echo "Running command: sysbench ${LUA} --db-driver=${DB} --mysql-host=${HOST} --mysql-port=${PORT} --mysql-user=${USER} --mysql-password=${PASSWORD} --mysql-db=${DBNAME} --table-size=${SIZE} --tables=500 --events=0 --time=60 --db-ps-mode=disable --percentile=95 --report-interval=1 --threads=${THREADS} ${1}"
sysbench ${LUA} --db-driver=${DB} --mysql-host=${HOST} --mysql-port=${PORT} --mysql-user=${USER} --mysql-password=${PASSWORD} --mysql-db=${DBNAME} --table-size=${SIZE} --tables=500 --events=0 --time=120 --db-ps-mode=disable --percentile=95 --report-interval=1 --threads=${THREADS} ${1}
