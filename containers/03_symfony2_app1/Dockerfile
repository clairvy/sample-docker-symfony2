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

# php-apache
RUN rpm -ivh http://dl.iuscommunity.org/pub/ius/stable/Redhat/6/x86_64/epel-release-6-5.noarch.rpm
RUN rpm -ivh http://dl.iuscommunity.org/pub/ius/stable/Redhat/6/x86_64/ius-release-1.0-11.ius.el6.noarch.rpm
RUN yum install -y php54 php54-mbstring php54-xml php54-intl php54-process php54-mysql

# symfony2
RUN cd /usr/local/bin && curl -s https://getcomposer.org/installer | php

# http
RUN mkdir /var/www/dev
RUN ln -s /data/symfony2/app1/webroot/logs /var/www/dev/logs
RUN ln -s /data/symfony2/app1/webroot/Symfony/web /var/www/dev/public_html
ADD files/etc/httpd/conf.d/ /etc/httpd/conf.d/
ADD files/etc/php.ini /etc/php.ini

EXPOSE 80 22

CMD ["/usr/bin/supervisord"]
