#/bin/bash
##
# Use the amazon naivebayes dataset, trains and tests a classifier.
# Need HADOOP and MAHOUT
# To prepare and generate data:
# ./genData_naivebayes.sh
# To run:
# ./run_naivebayes.sh
##
 
#bayes-trainmodel
HDFS_WORK_DIR="/BigDataBench/e-commerce/data-naivebayes"
 cd data-naivebayes/
 ${HADOOP_HOME}/bin/hadoop fs -mkdir $HDFS_WORK_DIR/Bayes
 ${HADOOP_HOME}/bin/hadoop fs -rmr $HDFS_WORK_DIR/Bayes/model
 ${HADOOP_HOME}/bin/hadoop fs -put model $HDFS_WORK_DIR/Bayes

 cd ..
echo "Preparing naivebayes-naivebayes data dir"
WORK_DIR=`pwd`

echo "WORK_DIR=$WORK_DIR data will be generated in $WORK_DIR/data-naivebayes"
mkdir ${WORK_DIR}/data-naivebayes

echo "Preparing naivebayes-naivebayes data dir"
mkdir -p ${WORK_DIR}/data-naivebayes/amazonMR1
mkdir -p ${WORK_DIR}/data-naivebayes/amazonMR2
mkdir -p ${WORK_DIR}/data-naivebayes/amazonMR3
mkdir -p ${WORK_DIR}/data-naivebayes/amazonMR4
mkdir -p ${WORK_DIR}/data-naivebayes/amazonMR5

cd ../../BigDataGeneratorSuite/Text_datagen/
./gen_text_data.sh amazonMR1 30 150 100 ${WORK_DIR}/data-naivebayes/amazonMR1
./gen_text_data.sh amazonMR2 30 150 100 ${WORK_DIR}/data-naivebayes/amazonMR2
./gen_text_data.sh amazonMR3 30 150 100 ${WORK_DIR}/data-naivebayes/amazonMR3
./gen_text_data.sh amazonMR4 30 150 100 ${WORK_DIR}/data-naivebayes/amazonMR4
./gen_text_data.sh amazonMR5 30 150 100 ${WORK_DIR}/data-naivebayes/amazonMR5
cd data-naivebayes/

#python dataread.py $1 $2  you can change the number 
#$1:A number of storage folder
#$2:From the first few rows stored
#$1 ad $2 based on amazonMR

python datareadyuce.py 11 10
${HADOOP_HOME}/bin/hadoop fs -rmr $HDFS_WORK_DIR/Bayesclassifier/testdata
${HADOOP_HOME}/bin/hadoop fs -mkdir $HDFS_WORK_DIR/Bayesclassifier

${HADOOP_HOME}/bin/hadoop fs -copyFromLocal ${WORK_DIR}/data-naivebayes/testdata $HDFS_WORK_DIR/Bayesclassifier
echo "Finished copyFromLocal"


