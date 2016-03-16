# Options read when launching programs locally with
# ./bin/run-example or ./bin/spark-submit
# - HADOOP_CONF_DIR, to point Spark towards Hadoop configuration files
# - SPARK_LOCAL_IP, to set the IP address Spark binds to on this node
# - SPARK_PUBLIC_DNS, to set the public dns name of the driver program
# - SPARK_CLASSPATH, default classpath entries to append

# Options read by executors and drivers running inside the cluster
# - SPARK_LOCAL_IP, to set the IP address Spark binds to on this node
# - SPARK_PUBLIC_DNS, to set the public DNS name of the driver program
# - SPARK_CLASSPATH, default classpath entries to append
# - SPARK_LOCAL_DIRS, storage directories to use on this node for shuffle and RDD data
# - MESOS_NATIVE_LIBRARY, to point to your libmesos.so if you use Mesos

# Options read in YARN client mode
# - HADOOP_CONF_DIR, to point Spark towards Hadoop configuration files
# - SPARK_EXECUTOR_INSTANCES, Number of workers to start (Default: 2)
# - SPARK_EXECUTOR_CORES, Number of cores for the workers (Default: 1).
# - SPARK_EXECUTOR_MEMORY, Memory per Worker (e.g. 1000M, 2G) (Default: 1G)
# - SPARK_DRIVER_MEMORY, Memory for Master (e.g. 1000M, 2G) (Default: 512 Mb)
# - SPARK_YARN_APP_NAME, The name of your application (Default: Spark)
# - SPARK_YARN_QUEUE, The hadoop queue to use for allocation requests (Default: 
                                                                                             # - SPARK_YARN_DIST_FILES, Comma separated list of files to be distributed with the job.
# - SPARK_YARN_DIST_ARCHIVES, Comma separated list of archives to be distributed with the job.
export JAVA_HOME=${JAVA_HOME}
export HADOOP_CONF_DIR={{spark.spark_env.hadoop_conf_dir}}
export SPARK_HOME=${SPARK_HOME}
##可以启动多个实例
#export SPARK_EXECUTOR_INSTANCES=2
export SPARK_EXECUTOR_CORES={{spark.spark_env.spark_executor_cores}}
export SPARK_EXECUTOR_MEMORY={{spark.spark_env.spark_executor_memory}}
export SPARK_DRIVER_MEMORY={{spark.spark_env.spark_driver_memory}}
##master节点的webui端口
export SPARK_MASTER_WEBUI_PORT=18080
##worker节点的webui端口
export SPARK_WORKER_WEBUI_PORT=18081
export SPARK_WORKER_DIR={{spark.spark_env.spark_worker_dir}}
export SPARK_LOG_DIR={{spark.spark_env.spark_log_dir}}
##为pid文件设置目录，防止默认/tmp目录下长时间运行导致的pid文件丢失。
export SPARK_PID_DIR={{spark.spark_env.spark_pid_dir}}
##为了兼容hive元数据，设置mysql连接器
export SPARK_CLASSPATH={{spark.spark_env.spark_classpath}}
##启动参数里设置zookeeper，提供master节点的高可用
export SPARK_DAEMON_JAVA_OPTS="-Dspark.deploy.recoveryMode=ZOOKEEPER -Dspark.deploy.zookeeper.url={% for host in groups['zookeepers'] %}{% if not loop.last %}{{host}}:2181,{%else%}{{host}}:2181{% endif %}{% endfor %} -Dspark.deploy.zookeeper.dir=/spark"
##设置这个为了兼容hadoop下面的一些lib库，比如snappy
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}
