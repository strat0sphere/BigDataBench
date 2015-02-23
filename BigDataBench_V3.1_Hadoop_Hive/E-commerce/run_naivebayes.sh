#!/bin/bash
HDFS_WORK_DIR="/BigDataBench/e-commerce"
WORK_DIR=`pwd`
${MAHOUT_HOME}/bin/mahout testclassifier -m /Bayes/model -d  ${HDFS_WORK_DIR}/data-naivebayes/testdata 

