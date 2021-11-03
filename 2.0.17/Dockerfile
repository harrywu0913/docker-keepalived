FROM library/alpine:3.11

MAINTAINER "harrywu0913" <1248120122@qq.com>

ENV KEEPALIVED_VERSION 2.0.17

# Download, build and install Keepalived
RUN set -x \
    && echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.11/main/" > /etc/apk/repositories \
    && apk update \
    && apk --no-cache add \
    curl \
    gcc \
    ipset \
    ipset-dev \
    iptables \
    iptables-dev \
    libnfnetlink \
    libnfnetlink-dev \
    libnl3 \
    libnl3-dev \
    make \
    musl-dev \
    openssl \
    openssl-dev \
    autoconf \
    automake \
    && tempDir="$(mktemp -d)" \
    && chmod 777 "${tempDir}" \
    && curl -fSL "http://keepalived.org/software/keepalived-${KEEPALIVED_VERSION}.tar.gz" | tar -C "${tempDir}" -xzvf- \
    && cd "${tempDir}/keepalived-${KEEPALIVED_VERSION}" \
    && ./build_setup \
    && ./configure --disable-dynamic-linking --enable-log-file \
    && make \
    && make install \
    && mkdir -p /etc/keepalived \
    && mkdir /var/log/keepalived \
    && apk --no-cache del \
    gcc \
    ipset-dev \
    iptables-dev \
    libnfnetlink-dev \
    libnl3-dev \
    make \
    musl-dev \
    openssl-dev \
    autoconf \
    automake \
    && rm -rf "${tempDir}"
    #\
    # && ln -sf /dev/stdout /var/log/keepalived/keepalived.log

COPY keepalived.conf notify.sh /etc/keepalived/
COPY docker-entrypoint.sh /usr/local/bin/

# set keepalived as image entrypoint with --dont-fork and --log-console (to make it docker friendly)
# ENTRYPOINT ["/usr/local/sbin/keepalived","--dont-fork","--log-console","--log-detail","--dump-conf","--no-syslog","--log-file=/var/log/keepalived/keepalived.log","$@"]
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["-f","/etc/keepalived/keepalived.conf"]
