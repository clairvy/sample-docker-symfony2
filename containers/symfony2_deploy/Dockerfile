FROM centos:centos6

# ssh, sudo
RUN yum install -y sudo openssh-server
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ''

# user
RUN useradd -d /home/kitchen -m -s /bin/bash kitchen
RUN echo kitchen:kitchen | chpasswd
RUN echo 'kitchen ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && sed -i.bak -e 's/\(Defaults \+\)\(requiretty\)/\1!\2/' /etc/sudoers
RUN mkdir /home/kitchen/.ssh
RUN ssh-keygen -f /home/kitchen/.ssh/id_rsa -t rsa -b 2048 -N ''
RUN cp /home/kitchen/.ssh/id_rsa.pub /home/kitchen/.ssh/authorized_keys
RUN chmod 0600 /home/kitchen/.ssh/authorized_keys
RUN chown -Rh kitchen /home/kitchen

# supervisord
RUN yum install -y python-setuptools
RUN easy_install supervisor
ADD files/etc/supervisord.conf /etc/supervisord.conf

# ruby
RUN yum install -y --enablerepo=centosplus openssl-devel
RUN yum install -y git tar gcc zlib-devel
RUN ( echo 'export PATH=/home/kitchen/.rbenv/bin:$PATH'; echo 'eval "$(rbenv init -)"' ) >> /etc/profile.d/rbenv.sh # or /etc/profile
USER kitchen
RUN git clone https://github.com/sstephenson/rbenv.git /home/kitchen/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /home/kitchen/.rbenv/plugins/ruby-build
ENV PATH /home/kitchen/.rbenv/bin:$PATH
RUN sudo /home/kitchen/.rbenv/plugins/ruby-build/install.sh
ENV HOME /home/kitchen
RUN rbenv install 2.1.2 && rbenv global 2.1.2

# capifony
RUN gem install capifony

USER root

EXPOSE 22

CMD ["/usr/bin/supervisord"]
