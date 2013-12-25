#!/bin/bash

#
# bash script to try out hadoop yarn on Mac OS X and Linux
# (the run part)
#

export PATH=$JAVA_HOME/bin:$PATH

# jps             ; sleep 3 # basic check 1
# hadoop fs -ls   ; sleep 3 # basic check 2
# hadoop fs -ls / ; sleep 3 # basic check 3

#-----------------------------
# compile the simple yarn app
#-----------------------------
./compile-simple-yarn-app.sh

# create the jar
(cd bin; jar cf ../simple-yarn.jar $(find . -name \*.class))

# place the jar in HDFS
hadoop fs -mkdir -p /apps
hadoop fs -rm /apps/simple-yarn.jar
hadoop fs -put simple-yarn.jar /apps

# Let Hadoop/Yarn know where the classes are
export HADOOP_CLASSPATH=bin

# Cleanup, and check embedded command output creation after running
/bin/rm -f /tmp/stdouterr # placed in /tmp (within Client.java) for easier debugging


#---------------------------
# run the simple yarn app
#---------------------------

#----------------------------------
# *** This Hangs !!! *** ...
# yarn com.sansthal.hadoop.yarn.Client /bin/date 2 \
#   hdfs://sandbox.hortonworks.com:8020/apps/simple-yarn.jar
#----------------------------------

#----------------------------------
# *** This Works Fine *** ...
#----------------------------------
OS_NAME=$(uname -s)
if [ "$OS_NAME" == "Darwin" ]; then
  yarn com.sansthal.hadoop.yarn.Client /bin/date 1 \
    hdfs://localhost:9000/apps/simple-yarn.jar
elif [ "$OS_NAME" == "Linux" ]; then
  yarn com.sansthal.hadoop.yarn.Client /bin/date 1 \
    hdfs://sandbox.hortonworks.com:8020/apps/simple-yarn.jar
else
  echo "=> Not Tested on ${OS_NAME}!"
fi

