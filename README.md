hadoop-yarn
===========

Simple Hadoop Yarn Application

Tested on -

Mac OS X 10.9 using java version "1.7.0_40"

and Hortonworks Sandbox Version 2.0<br>
(http://hortonworks.com/products/hortonworks-sandbox/)<br>
using java version "1.6.0_24"

PREREQ:<br>
You need to have installed Hadoop 2 on your Mac,<br>
or be using Hortonworks Sandbox Version 2.0<br>

NOTE:<br>
Prior knowledge of Hadoop source code,<br>
especially within this area helps -<br>
hadoop-common/hadoop-yarn-project/hadoop-yarn/hadoop-yarn-applications

RUNNING:<br>
Just run the BASH script (run-simple-yarn-app.sh)<br>
It will do a maven build, and then run the yarn client.

USAGE:<br>
$ ./run-simple-yarn-app.sh
=> Usage: ./run-simple-yarn-app.sh -c <unix_command> -n <number_of_yarn_containers>

SAMPLE RUN:<br>
$ ./run-simple-yarn-app.sh -c /usr/bin/who -n 9

