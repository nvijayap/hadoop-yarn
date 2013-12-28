hadoop-yarn
===========

<b>Simple Hadoop Yarn (With Use Case: Send Email using Yarn)</b>

<b>Tested on</b> -

* Mac OS X 10.9 using java version "1.7.0_40"

and

* Hortonworks Sandbox Version 2.0<br>
(http://hortonworks.com/products/hortonworks-sandbox/)<br>
using java version "1.6.0_24"

<b>PREREQ</b>:<br>
You need to have installed Hadoop 2 on your Mac,<br>
or be using Hortonworks Sandbox Version 2.0<br>

<b>NOTE</b>:<br>
Prior knowledge of Hadoop source code,<br>
especially within this area helps -<br>
hadoop-common/hadoop-yarn-project/hadoop-yarn/hadoop-yarn-applications

<b>RUNNING</b>:<br>
Just run the BASH script (run-simple-yarn-app.sh)<br>
It will do a maven build, and then run the yarn client.

<b>USAGE</b>:<br>
$ ./run-simple-yarn-app.sh<br>
=> Usage: ./run-simple-yarn-app.sh -c <unix_command> -n <number_of_yarn_containers>

<b>SAMPLE RUN</b>:<br>
$ ./run-simple-yarn-app.sh -c /usr/bin/who -n 9

<b>EXTRAS (Use Case: Send Email)</b>:<br>
Want to send email from all the yarn Containers?<br>
Place the sendemail ruby script in accessible location<br>
(/bin, /usr/bin, or some other standard location of PATH,<br>
or mention the full path in run script).<br>
$ ./run-simple-yarn-app.sh -c 'sendemail <your_email_address> <your_email_password>' -n 9

