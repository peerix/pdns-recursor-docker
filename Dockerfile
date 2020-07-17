FROM debian:latest
MAINTAINER "atanas argirov" <atanas@argirov.org>

# install gnupg2 & curl
RUN apt update && apt install -y gnupg2 curl netcat tcpdump

# add powerdns repo
COPY apt.pdns.repo /etc/apt/sources.list.d/pdns.list
COPY apt.pdns.pref /etc/apt/preferences.d/pdns 
RUN curl https://repo.powerdns.com/CBC8B383-pub.asc | apt-key add -
# get envsubst
# RUN curl -L https://github.com/a8m/envsubst/releases/download/v1.1.0/envsubst-`uname -s`-`uname -m` -o /usr/local/bin/envsubst && chmod +x /usr/local/bin/envsubst
# update repo
RUN apt update && apt install --no-install-recommends -y pdns-recursor python3 python3-pip python3-setuptools && python3 -m pip --no-cache-dir install envtpl

EXPOSE 53 53/udp

COPY recursor.conf.tmpl /etc/powerdns/recursor.conf.tmpl
COPY docker-entrypoint.sh .

RUN mkdir /var/run/pdns-recursor

ENTRYPOINT [ "./docker-entrypoint.sh" ]

CMD [ "/usr/sbin/pdns_recursor","--config-dir=/etc/powerdns" ]
