#!/bin/bash

#-----------------------------------------------------------------------
# bash script to try out simple hadoop yarn app on Mac OS X and Linux
#-----------------------------------------------------------------------

usage() { echo "=> Usage: $0 -c <unix_command> -n <number_of_yarn_containers>" 1>&2; exit 1; }

while getopts ":c:n:" o; do
  case "${o}" in
    c) c=${OPTARG} ;;
    n) n=${OPTARG} ;;
    *) usage ;;
  esac
done

if [ -z "${c}" ] || [ -z "${n}" ]; then
  usage
fi

echo
echo "=> Unix Command    = ${c}"
echo "=> Yarn Containers = ${n}"

# generate the simple yarn app jar and place it in HDFS /apps dir
echo; echo "=> Generating jar ..."
mvn package -DskipTests -l mvn.log
if [ $? -eq 0 ]; then
  /bin/rm mvn.log
else
  echo "=> Maven build has failed"; exit 2
fi
echo; echo "=> Creating /apps dir in HDFS ..."
hadoop fs -mkdir -p /apps
echo; echo "=> Placing jar in /apps dir in HDFS ..."
hadoop fs -put -f target/simple-hadoop-yarn-1.0-SNAPSHOT.jar /apps

# Let Yarn know where the classes are
export HADOOP_CLASSPATH=target/classes

# run the simple yarn app
OS_NAME=$(uname -s)
echo; echo "=> Running the simple yarn app ..."
if [ "$OS_NAME" == "Darwin" ]; then
  time yarn com.sansthal.hadoop.yarn.Client "${c}" "${n}" \
  hdfs://localhost:9000/apps/simple-hadoop-yarn-1.0-SNAPSHOT.jar
elif [ "$OS_NAME" == "Linux" ]; then        # Hortonworks Sandbox Version 2
  time yarn com.sansthal.hadoop.yarn.Client "${c}" "${n}" \
  hdfs://sandbox.hortonworks.com:8020/apps/simple-hadoop-yarn-1.0-SNAPSHOT.jar
else
  echo "=> Not Tested on ${OS_NAME}!"
fi
echo
