FROM centos:centos6

# ssh, sudo
RUN yum install -y sudo openssh-server
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ''

# user
RUN useradd -d /home/kitchen -m -s /bin/bash kitchen
RUN echo kitchen:kitchen | chpasswd
RUN echo 'kitchen ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN mkdir /home/kitchen/.ssh
RUN ssh-keygen -f /home/kitchen/.ssh/id_rsa -t rsa -b 2048 -N ''
RUN cp /home/kitchen/.ssh/id_rsa.pub /home/kitchen/.ssh/authorized_keys
RUN chmod 0600 /home/kitchen/.ssh/authorized_keys
RUN chown -Rh kitchen /home/kitchen

# supervisord
RUN yum install -y python-setuptools
RUN easy_install supervisor
ADD files/etc/supervisord.conf /etc/supervisord.conf

# mysql
RUN yum install -y mysql-server
RUN rmdir /var/lib/mysql && ln -s /data/symfony2/db1s1/mysql /var/lib/mysql
ADD files/etc/my.cnf /etc/my.cnf
ADD files/init /init

EXPOSE 3306 22

CMD ["/usr/bin/supervisord"]
