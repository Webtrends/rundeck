#!/usr/bin/env bash

# (Required) Amount of memory used per slave node. This should be in the same
# format as the JVM's -Xmx option, e.g. 300m or 1g.
export SPARK_MEM=1g

# (Required) Set the master program's memory
export SHARK_MASTER_MEM=1g

# (Required) Point to your Scala installation.
export SCALA_HOME="/usr"

# (Required) Point to the patched Hive binary distribution
export HIVE_HOME="<%= @hive_path %>"

# (Optional) Specify the location of Hive's configuration directory. By default,
# it points to $HIVE_HOME/conf
#export HIVE_CONF_DIR="$HIVE_HOME/conf"

# For running Shark in distributed mode, set the following:
export HADOOP_HOME="<%= @hadoop_path %>"
export SPARK_HOME="<%= @spark_home %>"
export MASTER="spark://<%= @master_ip %>:7077"
#export MESOS_NATIVE_LIBRARY=/usr/local/lib/libmesos.so

# (Optional) Extra classpath
#export SPARK_LIBRARY_PATH=""

# Java options
# On EC2, change the local.dir to /mnt/tmp
SPARK_JAVA_OPTS="-Dspark.local.dir=/tmp "
SPARK_JAVA_OPTS+="-Dspark.kryoserializer.buffer.mb=10 "
SPARK_JAVA_OPTS+="-verbose:gc -XX:-PrintGCDetails -XX:+PrintGCTimeStamps "
export SPARK_JAVA_OPTS


source $SPARK_HOME/conf/spark-env.sh