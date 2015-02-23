#!/bin/bash
##
# Use the WIKI dataset, trains and tests a cluster.
# Need HADOOP and MAHOUT
# To prepare and generate data:
# ./genData_Kmeans.sh
# To run:
# ./run_Kmeans.sh
##

echo "Preparing Kmeans data dir"

#read -p "Please Enter WORK_DIR: " WORK_DIR
WORK_DIR=/tmp/mahout-work-${USER}
echo "WORK_DIR=$WORK_DIR data should be put in $WORK_DIR/data-kmeans"

#read -p "Please Enter MAHOUT_HOME: " MAHOUT_HOME
#echo "MAHOUT_HOME=$MAHOUT_HOME"


if [ "$HADOOP_HOME" != "" ]; then
  echo "Checking the health of DFS..."
  $HADOOP_HOME/bin/hadoop fs -ls 
  if [ $? -eq 0 ];then 
    echo "DFS is healthy... "

    ${MAHOUT_HOME}/bin/mahout org.apache.mahout.clustering.syntheticcontrol.kmeans.Job
  else
    echo " HADOOP is not running. Please make sure you hadoop is running. "
  fi
fi
