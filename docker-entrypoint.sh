#!/bin/sh

: "${PDNS_local_port:=53}"
: "${PDNS_local_address:=0.0.0.0}"
: "${PDNS_allow_from:=0.0.0.0/0}"

export PDNS_local_port PDNS_local_address PDNS_allow_from

CONFIG_FILE=/etc/powerdns/recursor.conf
PDNS_USER=root

#/usr/local/bin/envsubst < /etc/dnsdist/dnsdist.conf.tmpl > $config_file

envtpl < /etc/powerdns/recursor.conf.tmpl > ${CONFIG_FILE}

chown ${PDNS_USER}: ${CONFIG_FILE}

exec "$@" 
