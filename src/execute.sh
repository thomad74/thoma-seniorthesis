#!/bin/bash

### PREREQUISITES ###

# tar zxvf hadoop-3.2.1.tar.gz --> UNZIP THE HADOOP FILES each time
# sudo mv hadoop-3.2.1 /usr/local/hadoop --> move the unzipped files to the $HADOOP_HOME directory

# 1. Delete core-site.xml contents --> cd ~/usr/local/hadoop/etc/hadoop sudo nano core-site.xml
# 2. Change hostname in config file --> cd ~/.ssh sudo nano config --> public DNS needs changed from Amazon AWS instance
# 3. Edit hosts file with private IP --> cd ~/usr/local/hadoop/etc/hadoop sudo nano hosts --> private IP followed by namenode or datanode
# 4. Remove localhost keygen from known hosts --> cd ~/.ssh ssh-keygen -f "/home/ubuntu/.ssh/known_hosts" -R "localhost"
# 5. Create new keygen with new IP address --> cd ~/.ssh ssh-keygen -t rsa (press enter when prompted, and 'y' to overwrite)
# 6. Move new keygen to authorized keys --> cd ~/.ssh cat id_rsa.pub >> authorized_keys
# 7. Create input file in correct directory --> cd ~/usr/local/hadoop sudo nano input (or for bigger files scp -r filename ubuntu@ip:/home/ubuntu)
# 8. Copy the script to the namenode server --> cd~/usr/local/hadoop sudo nano execute.sh (copy and paste here)
# 9. Make the script executable --> cd ~/usr/local/hadoop sudo chmod +x execute.sh
# 10. Run the execute.sh script --> cd ~/usr/local/hadoop ./execute.sh

echo "Starting timer: "
start=$SECONDS # start timer #

### Running a MapReduce job on a Hadoop single-node cluster and Hadoop multi-node cluster that are already set-up in an Ubuntu environment ###

echo "Running MapReduce Job: "
# sudo chown -R ubuntu $HADOOP_HOME # change ownership of HADOOP_HOME to ubuntu user #
source .bashrc
cd /usr/local/hadoop/sbin # change into the HADOOP_HOME directory where sbin/ is located #
echo "Starting Distributed File System: "
./start-dfs.sh # start the hadoop distributed file system which includes the namenode, secondary namenode, and datanode(s) #
# if an error occurs about keygen, run ssh-keygen -f "/home/ubuntu/.ssh/known_hosts" -R "localhost" #
echo "Starting Yarn Files: "
./start-yarn.sh # start the yarn files which include resource manager and node managers #
echo "Running MapReduce Job: "
cd ..
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.1.jar wordcount input output # runs the MapReduce job #
# be sure to create input file manually using sudo nano input and put data in here before running job #
echo "Displaying Output of Running MapReduce Job: "
bin/hdfs dfs -cat output/* # displays the output found in the hadoop distributed file system stored in the output file as declared in previous step #
# delete output directory or change name of output directory in jar command to avoid overwriting #
# echo "Stopping All Running Daemons"
# cd ~/usr/local/hadoop/sbin
# ./stop-all.sh
duration=$(( SECONDS - start )) # end timer #
echo "Printing Duration: "
echo $duration
echo "Stopping timer: "
echo "Total Time Including Provisioning of Instances and Execution Time: "
provisioningTime=300
total_time=$(( $provisioningTime + $duration ))
echo $total_time
echo "Deleting Output File to Avoid Overlap"
rm -R output
echo "Thank you for using this tool! Goodbye!"
