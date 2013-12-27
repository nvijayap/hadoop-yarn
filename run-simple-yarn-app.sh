#!/bin/bash

#-----------------------------------------------------------------------
# bash script to try out simple hadoop yarn app on Mac OS X and Linux
#-----------------------------------------------------------------------

# generate the simple yarn app jar and place it in HDFS /apps dir
mvn clean package
echo; echo "=> Creating /apps dir in HDFS ..."
hadoop fs -mkdir -p /apps
echo; echo "=> Placing jar in /apps dir in HDFS ..."
hadoop fs -put -f target/simple-hadoop-yarn-1.0-SNAPSHOT.jar /apps

# Let Hadoop/Yarn know where the classes are
export HADOOP_CLASSPATH=target/classes

# run the simple yarn app
UNIX_COMMAND=/bin/date            # feel free to change
CONTAINERS=9                      # feel free to change
OS_NAME=$(uname -s)

echo; echo "=> Running the simple yarn app ..."
if [ "$OS_NAME" == "Darwin" ]; then
  time yarn com.sansthal.hadoop.yarn.Client $UNIX_COMMAND $CONTAINERS \
  hdfs://localhost:9000/apps/simple-hadoop-yarn-1.0-SNAPSHOT.jar
elif [ "$OS_NAME" == "Linux" ]; then        # Hortonworks Sandbox Version 2
  time yarn com.sansthal.hadoop.yarn.Client $UNIX_COMMAND $CONTAINERS \
  hdfs://sandbox.hortonworks.com:8020/apps/simple-hadoop-yarn-1.0-SNAPSHOT.jar
else
  echo "=> Not Tested on ${OS_NAME}!"
fi
