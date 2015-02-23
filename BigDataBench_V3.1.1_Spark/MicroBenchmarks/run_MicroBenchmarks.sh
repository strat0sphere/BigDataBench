#!/bin/bash
##

algorithm=( Sort Grep Wordcount)
if [ -n "$1" ]; then
  choice=$1
else
  echo "Please select a number to choose the corresponding Workload algorithm"
  echo "1. ${algorithm[0]} Workload"
  echo "2. ${algorithm[1]} Workload"
  echo "3. ${algorithm[2]} Workload"
 
  read -p "Enter your choice : " choice
fi

echo "ok. You chose $choice and we'll use ${algorithm[$choice-1]} Workload"
Workloadtype=${algorithm[$choice-1]} 

if [ "x$Workloadtype" == "xSort" ]; then
${HADOOP_HOME}/bin/hadoop fs -rmr /spark-sort-result
spark-submit --class cn.ac.ict.bigdatabench.Sort $JAR_FILE /data-MicroBenchmarks /spark-sort-result

elif [ "x$Workloadtype" == "xGrep" ]; then
${HADOOP_HOME}/bin/hadoop fs -rmr /spark-grep-result
spark-submit --class cn.ac.ict.bigdatabench.Grep $JAR_FILE /data-MicroBenchmarks henry /spark-grep-result

elif [ "x$Workloadtype" == "xWordcount" ]; then
${HADOOP_HOME}/bin/hadoop fs -rmr /spark-wordcount-result
spark-submit --class cn.ac.ict.bigdatabench.WordCount $JAR_FILE /data-MicroBenchmarks /spark-wordcount-result

fi 
