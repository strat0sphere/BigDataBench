#!/bin/bash

HDFS_WORK_DIR="/BigDataBench/e-commerce/data-naivebayes"
${HADOOP_HOME}/bin/hadoop fs -rmr /Bayes-result
spark-submit --class cn.ac.ict.bigdatabench.NaiveBayesClassifier $JAR_FILE ${HDFS_WORK_DIR}/testdata ${HDFS_WORK_DIR}/Bayes/model ${HDFS_WORK_DIR}/Bayes-result
  

