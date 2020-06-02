#!/bin/sh
set -e

if [ "`ls -A /etc/privoxy/`" = "" ]; then
    tar -zxvf /data/config.tgz --strip-components 2 -C /etc/privoxy
    chown privoxy:privoxy /etc/privoxy -R
fi

exec privoxy --no-daemon --user privoxy /etc/privoxy/config