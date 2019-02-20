# Using sequenceiq hadoop repository
FROM sequenceiq/hadoop-docker:2.6.0
MAINTAINER Kyle.Bai

# support for Hadoop 2.6.0
# internet url = http://d3kbcqa49mib13.cloudfront.net/spark-1.5.0-bin-hadoop2.6.tgz
RUN curl -s http://10.21.20.152:5000/files/spark-1.5.0-bin-hadoop2.6.tgz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s spark-1.5.0-bin-hadoop2.6 spark
ENV SPARK_HOME /usr/local/spark
RUN mkdir $SPARK_HOME/yarn-remote-client
ADD yarn-conf $SPARK_HOME/yarn-remote-client

RUN $BOOTSTRAP && $HADOOP_PREFIX/bin/hadoop dfsadmin -safemode leave && $HADOOP_PREFIX/bin/hdfs dfs -put $SPARK_HOME-1.5.0-bin-hadoop2.6/lib /spark

ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ENV PATH $PATH:$SPARK_HOME/bin:$HADOOP_PREFIX/bin

# Update boot script
COPY boot_run.sh /etc/boot_run.sh
RUN chown root.root /etc/boot_run.sh
RUN chmod 700 /etc/boot_run.sh
RUN echo 'root:yarnspark' | chpasswd

# Install R
RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum -y install R

# Copy examples
COPY examples/ /root/


ENTRYPOINT ["/etc/boot_run.sh"]
