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
HDFS_WORK_DIR="/BigDataBench/SNS"
WORK_DIR=`pwd`
echo "WORK_DIR=$WORK_DIR data will be generated in $WORK_DIR/data-kmeans"

#read -p "Please Enter MAHOUT_HOME: " MAHOUT_HOME
#echo "MAHOUT_HOME=$MAHOUT_HOME"

echo "Generate Kmeans data"

WORK_DIR=`pwd`

mkdir $WORK_DIR/data-kmeans
read -p "Please Enter The Iterations of GenGragh: " I

echo "WORK_DIR=$WORK_DIR data will be generated in $WORK_DIR/data-kmeans"

#/////////////////////////////////////////////////////////////////////////////
#Parameters:
# -o:Output graph file name (default:'graph.txt')
# -m:Matrix (in Maltab notation) (default:'0.9 0.5; 0.5 0.1')
# -i:Iterations of Kronecker product (default:5)
# -s:Random seed (0 - time seed) (default:0)
#/////////////////////////////////////////////////////////////////////////////


../../BigDataGeneratorSuite/Graph_datagen/gen_kronecker_graph  -o:$WORK_DIR/data-kmeans/Facebook_genGragh_$I.txt -m:"0.8301 0.558; 0.4638 0.3019" -i:$I

head -4 $WORK_DIR/data-kmeans/Facebook_genGragh_$I.txt > $WORK_DIR/data-kmeans/Facebook_parameters_$I
sed 1,4d $WORK_DIR/data-kmeans/Facebook_genGragh_$I.txt > $WORK_DIR/data-kmeans/Facebook_genGragh_$I.tmp

mv $WORK_DIR/data-kmeans/Facebook_genGragh_$I.tmp $WORK_DIR/data-kmeans/Facebook_genGragh_$I.txt

$HADOOP_HOME/bin/hadoop fs -rmr $HADOOP_WORK_DIR/data-kmeans/Facebook_genGragh_$I.txt

echo "Runing grapt2tf.py"
python graph2tf.py $I


${HADOOP_HOME}/bin/hadoop fs -rmr ${HDFS_WORK_DIR}/data-kmeans/kmeans_input_data
${HADOOP_HOME}/bin/hadoop fs -mkdir -p ${HDFS_WORK_DIR}/data-kmeans
${HADOOP_HOME}/bin/hadoop fs -copyFromLocal ${WORK_DIR}/data-kmeans/kmeans_input_data ${HDFS_WORK_DIR}/data-kmeans/
${HADOOP_HOME}/bin/hadoop fs -rmr /user/root/testdata
${HADOOP_HOME}/bin/hadoop fs -put ${WORK_DIR}/data-kmeans/kmeans_input_data testdata


echo "Successfully Uploaded data to HDFS "




