#!/bin/bash
##
# Use the Facebook dataset, Run HCC, a connected component algorithm on hadoop.
# Need HADOOP and PEGASUS
# To prepare and generate data:
# ./genData_connectedComponents.sh
# To run:
# ./run_connectedComponents.sh [#_Iterations_of_GenGragh]
##

HDFS_WORK_DIR="/BigDataBench/SNS"
WORK_DIR=`pwd`
which hadoop > /dev/null
status=$?
if test $status -ne 0 ; then
	echo ""
	echo "Hadoop is not installed in the system."
	echo "Please install Hadoop and make sure the hadoop binary is accessible."
	exit 127
fi


if [ $# -ne 1 ]; then
	 echo 1>&2 Usage: $0 [#_Iterations_of_GenGragh]
	 echo 1>&2    ex: $0 10
	 exit 127
fi

let "I=2**$1"
reducers=24
echo "[#_of_nodes] : number of nodes in the graph is" $I
echo "[#_of_reducers] : number of reducers to use in hadoop is" $reducers
echo "[#_Iterations_of_GenGragh] : Iterations_of_GenGragh is" $1

rm -rf concmpt_output_temp

hadoop dfs -rmr concmpt_curbm
hadoop dfs -rmr concmpt_tempbm
hadoop dfs -rmr concmpt_nextbm
hadoop dfs -rmr concmpt_output
hadoop dfs -rmr concmpt_summaryout


#hadoop jar pegasus-2.0.jar pegasus.ConCmpt -D mapred.input.format.class=org.apache.hadoop.mapred.lib.NLineInputFormat -D mapred.line.input.format.linespermap=2500000 $WORK_DIR/data-Connected_Components/Facebook_genGragh_$1.txt concmpt_curbm concmpt_tempbm concmpt_nextbm concmpt_output $I $reducers new makesym
hadoop jar pegasus-2.0.jar pegasus.ConCmpt -D mapred.input.format.class=org.apache.hadoop.mapred.lib.NLineInputFormat -D mapred.line.input.format.linespermap=2500000 $HDFS_WORK_DIR/data-Connected_Components/Facebook_genGragh_$1.txt concmpt_curbm concmpt_tempbm concmpt_nextbm concmpt_output $I $reducers new makesym

rm -rf concmpt_output_temp
