FROM bigdata-worker:0.3
ADD file:8daabf68a739a2748b484a4ff7b9a73f88ef02610a3a8b8fd473a7f9d9290b6b in /
ENV LANG=en_US.UTF-8
CMD ["/usr/bin/bash"]
MAINTAINER firefoxmmx<firefoxmmx@163.com>
WORKDIR /etc/pacman.d
RUN /bin/sh -c mv mirrorlist mirrorlist.bak
RUN /bin/sh -c echo 'Server = http://mirrors.163.com/archlinux/$repo/os/$arch' > mirrorlist
RUN /bin/sh -c echo '[archlinuxcn]' >> /etc/pacman.conf
RUN /bin/sh -c echo 'SigLevel = Optional TrustAll' >> /etc/pacman.conf
RUN /bin/sh -c echo 'Server = http://mirrors.163.com/archlinux-cn/$arch' >> /etc/pacman.conf
RUN /bin/sh -c cp /etc/pacman.conf /etc/pacman.conf.bak
RUN /bin/sh -c cat /etc/pacman.conf.bak |sed 's/SigLevel\s*=\sRequired\sDatabaseOptional/SigLevel\t= Optional TrustAll/g' > /etc/pacman.conf
RUN /bin/sh -c echo 'nameserver 114.114.114.114' > /etc/resolv.conf
RUN /bin/sh -c pacman -Sy
RUN /bin/sh -c pacman -S --noconfirm glibc archlinux-keyring
RUN /bin/sh -c gpg -k
RUN /bin/sh -c curl -s https://keybase.io/heftig/pgp_keys.asc/\?fingerprint\=a2ff3a36aaa56654109064ab19802f8b0d70fc30 | gpg --with-colons --import-options import-show --dry-run --import
RUN /bin/sh -c pacman -S --noconfirm vim jdk8-openjdk openssh vim-airline ruby grep iputils zsh tar awk inetutils net-tools shadow scala maven
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk
ADD file:52cf4854d0d4f1e83dbb250bd906ecd3bd9ec46fedb3144c4eae09fd76fd050b in /root/
RUN /bin/sh -c mkdir /var/run/sshd
RUN /bin/sh -c echo 'root:root' | chpasswd
RUN /bin/sh -c sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/g' /etc/ssh/sshd_config
WORKDIR /etc/ssh
RUN /bin/sh -c ssh-keygen -t dsa -P '' -f /etc/ssh/ssh_host_dsa_key
RUN /bin/sh -c ssh-keygen -t rsa -P '' -f /etc/ssh/ssh_host_rsa_key
RUN /bin/sh -c mkdir /root/.ssh
RUN /bin/sh -c ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN /bin/sh -c cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
ENV HADOOP_VERSION=3.1.3
WORKDIR /opt
ADD file:70b5b3b95b6baac25ae6b87d49d3f2798d77e92d066b46c9edb0d78b66b82ed0 in .
RUN /bin/sh -c ls
WORKDIR /opt/hadoop-3.1.3
ADD multi:a9a86f154869c539f23c9c7cab3b6f0b91cece2f2a0bf6e0476b440ba638b1b3 in etc/hadoop/
ENV HADOOP_HOME=/opt/hadoop-3.1.3
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/hadoop-3.1.3/bin:/opt/hadoop-3.1.3/sbin
ENV HDFS_NAMENODE_USER=root
ENV HDFS_DATANODE_USER=root
ENV YARN_NODEMANAGER_USER=root
ENV HDFS_SECONDARYNAMENODE_USER=root
ENV YARN_RESOURCEMANAGER_USER=root
ENV HADOOP_CLASSPATH=
ENV SCALA_HOME=/usr/share/scala
ENV SPARK_VERSION=2.3.1
WORKDIR /opt
ADD file:647b5614beef08ec74f0a7ae860f50f6b6067dd7b652a86a7a5cbafde2b8694d in .
RUN /bin/sh -c mv spark-${SPARK_VERSION}-bin-without-hadoop spark-${SPARK_VERSION}
WORKDIR /opt/spark-2.3.1
ADD file:85c987c9b2e00f19cd0f5a76f60ca715b601d52fae361d4dff27d1ec9b09b232 in conf/
RUN /bin/sh -c cp conf/slaves.template conf/slaves
ENV SPARK_HOME=/opt/spark-2.3.1
ENV SPARK_CONF=/opt/spark-2.3.1/conf
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/hadoop-3.1.3/bin:/opt/hadoop-3.1.3/sbin:/opt/spark-2.3.1/bin:/opt/spark-2.3.1/sbin
WORKDIR /opt
ADD file:89e37f356d17d6ba6acc2270a1629a9c4dd7fe1654a567a38462f4e412368af9 in .
RUN /bin/sh -c mv apache-zookeeper-3.6.2-bin zookeeper-3.6.2
WORKDIR /opt/zookeeper-3.6.2
ADD file:9b4f28da0db2cd7e92e08e23e663998509d188186a767270a84baf1740ab45d7 in conf/
ENV ZOOKEEPER_HOME=/opt/zookeeper-3.6.2
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/hadoop-3.1.3/bin:/opt/hadoop-3.1.3/sbin:/opt/spark-2.3.1/bin:/opt/spark-2.3.1/sbin:/opt/zookeeper-3.6.2/bin
ENV HBASE_VERSION=2.2.5
WORKDIR /opt
ADD file:0105bd72980d702de4ae28c9e5e758c7396e7128a34463b3f6b6e6ac23dbece6 in .
WORKDIR /opt/hbase-2.2.5
ADD multi:d63df28d05637ae8ff23648dbb7d6cf25c764bd19e8f6a47a79cb9462a67a27d in conf/
ENV HBASE_HOME=/opt/hbase-2.2.5
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/hadoop-3.1.3/bin:/opt/hadoop-3.1.3/sbin:/opt/spark-2.3.1/bin:/opt/spark-2.3.1/sbin:/opt/zookeeper-3.6.2/bin:/opt/hbase-2.2.5/bin
ENV HBASE_MANAGER_ZK=false
ENV HBASE_CONF=/opt/hbase-2.2.5/conf
ENV HIVE_VERSION=3.1.2
WORKDIR /opt
ADD file:458fef229bd24da6d6ab2f1fec8a746e5c92d8d1702b1efb2e801873a3f14afc in .
RUN /bin/sh -c mv apache-hive-${HIVE_VERSION}-bin hive-${HIVE_VERSION}
WORKDIR /opt/hive-3.1.2
ADD multi:8915bc75cbe88ed3eef0520eb298356c189ab1f221a2f03afb5fc6041e3c90a2 in conf/
RUN /bin/sh -c mv lib/log4j-slf4j-impl-2.10.0.jar lib/log4j-slf4j-impl-2.10.0.jar.bak
RUN /bin/sh -c mv lib/guava-19.0.jar lib/guava-19.0.jar.bak
ENV HIVE_HOME=/opt/hive-3.1.2
ENV HIVE_CONF=/opt/hive-3.1.2/conf
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/hadoop-3.1.3/bin:/opt/hadoop-3.1.3/sbin:/opt/spark-2.3.1/bin:/opt/spark-2.3.1/sbin:/opt/zookeeper-3.6.2/bin:/opt/hbase-2.2.5/bin:/opt/hive-3.1.2/bin
RUN /bin/sh -c cp $HADOOP_HOME/share/hadoop/common/lib/guava-27.0-jre.jar $HIVE_HOME/lib/
ADD file:dd4a30423e1cd14d91b55257a41cc36e484067eda90e0cc8aca9ace6542e8b63 in lib/
ENV TEZ_VERSION=0.9.2
WORKDIR /opt
ADD file:17c0d7f87d7403d7cba9a9148a9386560c244648d6907648cd87220c6e5fef9e in .
RUN /bin/sh -c mv apache-tez-${TEZ_VERSION}-bin tez-${TEZ_VERSION}
WORKDIR /etc/profile.d
ADD file:8420508a294f827da80d15a99b4f0caf452c5d36ec1a11779508b92e4cdc9f75 in .
ENV TEZ_HOME=/opt/tez-0.9.2
RUN /bin/sh -c mv $TEZ_HOME/lib/slf4j-log4j12-1.7.10.jar $TEZ_HOME/lib/slf4j-log4j12-1.7.10.jar.bak
WORKDIR /root
RUN /bin/sh -c echo "export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:\$(hadoop classpath):\$TEZ_HOME/*:\$TEZ_HOME/lib/*.jar:\$SPARK_HOME/jars/*" >> .bashrc
WORKDIR /
EXPOSE 22
VOLUME [/hdfs-root]
CMD ["/usr/bin/sshd" "-D"]
