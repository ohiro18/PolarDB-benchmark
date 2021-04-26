#!/bin/sh
#DATE=`date '+%Y%m%d%H%M'`
#mkdir $DATE

# thread=500
# echo "prepare data using default settings, ref sysbench SIZE"  >> ${DATE}/sysbench_read_write_main.log
# ./sysbench.sh prepare ${thread} >> ${DATE}/sysbench_read_write_main.log

for c in 500 1000 1500 2000 2500 3000 3500 4000 4500 5000 5500 6000 6500 7000 7500 8000 8500 9000 9500 10000 10500
do
    #echo "Time: $(date +"%Y%m%d%H%M%S"), now running pgbench with c of: " + ${c}  >> ${DATE}/pgbench_read_write_${c}.log
 # pgbench -M prepared -n -r -P 1 -f ./rw.sql -c ${c} -j 25 -T 120 -D scale=20000 -D range=2000000000  >> ${DATE}/pgbench_read_write_${c}.log
    echo "***********************************************************************"
    echo "Time: $(date +"%Y%m%d%H%M%S"), now running pgbench with c of: " + ${c}  
  pgbench -M prepared -n -r -P 1 -f ./rw.sql -c ${c} -j 25 -T 120 -D scale=20000 -D range=2000000000  
done
