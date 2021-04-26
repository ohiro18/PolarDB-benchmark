#!/bin/sh

TOTAL_EVENT_COUNT=$1
CONCURRENT_PROCESS=$2

echo "Start FailOver testing right now."

#seq 1000 | xargs -t -P10 -n1 ./fot.sh
seq ${TOTAL_EVENT_COUNT} | xargs -P${CONCURRENT_PROCESS} -n1 ./fot.sh

echo "ALL DONE"
