#!/bin/bash

HDFS_WORK_DIR="/BigDataBench/SNS/data-Connected_Components"
echo "Internation I:"
read I
spark-submit --class cn.ac.ict.bigdatabench.ConnectedComponent $JAR_FILE $HDFS_WORK_DIR/Facebook_genGragh_$I.txt
