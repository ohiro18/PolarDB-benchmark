#!/bin/sh
DATE=`date '+%Y%m%d%H%M'`
mkdir $DATE

# thread=500
# echo "prepare data using default settings, ref sysbench SIZE"  >> ${DATE}/sysbench_read_write_main.log
# ./sysbench.sh prepare ${thread} >> ${DATE}/sysbench_read_write_main.log

for thread in 500 1000 1500
do
    echo "Time: $(date +"%Y%m%d%H%M%S"), now running sysbench with thread of: " + ${thread}  >> ${DATE}/sysbench_read_write_${thread}.log
  ./sysbench.sh run ${thread} >> ${DATE}/sysbench_read_write_${thread}.log
done
# echo "cleaning data up."  >> ${DATE}/sysbench_read_write_main.log
# ./sysbench.sh cleanup ${thread} >> ${DATE}/sysbench_read_write_main.log
