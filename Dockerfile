FROM debian:buster
MAINTAINER Adrian Dvergsdal [atmoz.net]

# Steps done in one RUN layer:
# - Install packages
# - OpenSSH needs /var/run/sshd to run
# - Remove generic host keys, entrypoint generates unique keys
RUN apt-get update && \
    apt-get -y install openssh-server rsyslog supervisor && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/log/*.log && \
    mkdir -p /var/run/sshd && \
    rm -f /etc/ssh/ssh_host_*key*

COPY rootfs /

EXPOSE 22

ENTRYPOINT ["/entrypoint"]
