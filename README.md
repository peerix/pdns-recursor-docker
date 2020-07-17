# PowerDNS' recursor Docker image

General purpose pdns recursor container 

## Build

```shell
./build.sh
```

## Run

```shell
./run.sh
```

or manually

```shell
docker run -d \
        --name pdns-recursor \
        --restart=always \
        -p 127.0.0.1:5300:53/udp \
        -p 127.0.0.1:8082:8082/udp \
        -e PDNS_local_address=0.0.0.0 \
        -e PDNS_local_port=53 \
        -e PDNS_webserver=yes \
        -e PDNS_webserver_address=0.0.0.0 \
        -e PDNS_webserver_password=secret \
        -e PDNS_api_key=apikey \
        peerix/pdns-recursor

```

You can use any of the configuration variables available
for pdns recursor, please consult PowerDNS documentation at
https://doc.powerdns.com/recursor/
