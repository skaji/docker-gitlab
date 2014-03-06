FROM ubuntu:12.04
MAINTAINER Shoichi Kaji (skaji@cpan.org)

## NOTE: you should disable SELinux

ENV DEBIAN_FRONTEND noninteractive
RUN echo "deb http://jp.archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update -y --force-yes

RUN apt-get install openssh-server -y --force-yes
RUN mkdir -m 700 /var/run/sshd && chown root:root /var/run/sshd
RUN bash -c 'echo "root:root" | chpasswd'

ADD debconf-set-selections /root/debconf-set-selections
RUN cat /root/debconf-set-selections | debconf-set-selections && apt-get install mysql-server -y --force-yes

RUN apt-get install redis-server -y --force-yes
RUN mkdir -m 700 /var/run/redis && chown root:root /var/run/redis

RUN apt-get install curl -y --force-yes
ADD start_background /usr/local/bin/start_background
RUN chown root:root /usr/local/bin/start_background && chmod 755 /usr/local/bin/start_background
RUN /usr/local/bin/start_background /usr/sbin/mysqld && /usr/bin/redis-server /etc/redis/redis.conf && sleep 10 && curl https://raw.github.com/akagisho/gitlab-installer/master/ubuntu.sh | bash

EXPOSE 80
EXPOSE 22

ADD all_start /usr/local/bin/all_start
RUN chmod 755 /usr/local/bin/all_start

ADD clean.sh /root/clean.sh
RUN bash /root/clean.sh && rm -f /root/clean.sh

CMD ["/usr/local/bin/all_start"]
