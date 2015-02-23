#!/bin/bash

HDFS_WORK_DIR="/BigDataBench/SearchEngine"

${HADOOP_HOME}/bin/hadoop fs -rm -r /spark-pagerank-result
echo "Internation I:"
read I
spark-submit --class cn.ac.ict.bigdatabench.PageRank $JAR_FILE $HDFS_WORK_DIR/data-PageRank/Google_genGraph_$I.txt $I /spark-pagerank-result
