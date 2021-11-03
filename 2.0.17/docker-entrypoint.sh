#!/bin/sh
set -ex

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- /usr/local/sbin/keepalived --dont-fork --log-detail --dump-conf --no-syslog --log-console --log-file=/var/log/keepalived/keepalived.log "$@"
fi

exec "$@"
