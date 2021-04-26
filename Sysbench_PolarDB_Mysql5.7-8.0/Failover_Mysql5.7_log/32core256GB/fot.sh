#!/bin/sh
HOST=pc-0iw8clrt3229g6gs3.rwlb.japan.rds.aliyuncs.com
PORT=3306
USER=sbtest
PASSWORD=Test1234
DBNAME=sbtest

## default timeout
TIMEOUT_SECONDS=2

for x in {1..10}
do
timeout ${TIMEOUT_SECONDS} mysql -h ${HOST} -P ${PORT}  -D ${DBNAME} -u ${USER} -p${PASSWORD} -e "SELECT FUNC_DO_STH_AND_RET_CURTS($x,$x,$x,$x);"
retVal=$?
if [ $retVal -ne 0 ]; then
  echo "TIMEOUT OCCURRED! EVENT: "$1
fi
done


