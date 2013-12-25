#!/bin/bash

#
# bash script to try out hadoop yarn on Mac OS X and Linux
# (the compile part)
#

mkdir -p bin

export CLASSPATH=\
lib/hadoop-yarn-api-3.0.0-SNAPSHOT.jar:\
lib/hadoop-common-3.0.0-SNAPSHOT.jar:\
lib/hadoop-yarn-common-3.0.0-SNAPSHOT.jar:\
lib/hadoop-yarn-client-3.0.0-SNAPSHOT.jar:\
lib/commons-cli-1.2.jar:\
lib/commons-logging-1.1.2.jar:\
lib/log4j-1.2.17.jar

javac -d bin $(find src -name \*.java)
