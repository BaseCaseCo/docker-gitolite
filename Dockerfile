# docker-gitolite: Gitolite container
#
# VERSION: 0.2
#
# AUTHOR:  Ye Liu
# LICENSE: MIT
# COPYRIGHT: Copyright 2016 Ye Liu

FROM debian
MAINTAINER Ye Liu
COPY start.sh /opt/start.sh
RUN \
    apt-get update && \
    apt-get install git openssh-server -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -m -s /bin/bash git && \
    sed -i 's/PermitRootLogin\s\+without-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/session\s\+required\s\+pam_loginuid.so/session optional pam_loginuid.so/' /etc/pam.d/sshd
RUN su -c 'git clone git://github.com/sitaramc/gitolite && mkdir bin && gitolite/install -ln ~/bin' - git
VOLUME ["/home/git/repositories"]
EXPOSE 22
CMD ["/bin/bash", "/opt/start.sh"]
