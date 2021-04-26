#!/bin/sh
mkdir -p logs
thread=100
echo "prepare data using default settings, ref sysbench SIZE"  >> logs/sysbench_read_write_0_prepare.log
./sysbench.sh prepare ${thread} >> logs/sysbench_read_write_0_prepare.log
echo "data had been successfully initialized."  >> logs/sysbench_read_write_0_prepare.log
