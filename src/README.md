# 1. Configure of frps serving for bookstack in LAN

## 1.1 Specify following variables in `.env` file for your domain.

```bash
# nginx-proxy environments

# The port your App listen on.
VIRTUAL_PORT: 80

# The (sub)domain of your application.
VIRTUAL_HOST: "sub.domain.com"


## frps listen port, if you use another one, you must make "bind_port" as the same in frps.ini .
FRPS_BIND_PORT=7001

## Deploy root path, default is current directory.
FRPS_INSTALL_ROOT_PATH='./'

## Directory name for configuration file of frps, default is cfgs at current directory.
FRPS_CFGS_DIR='cfgs'



# Selfsigned certificates parameters for `1_init.sh`

## Location for selfsigned certificate creation.
SELFSIGNED_CERTS_ROOT_PATH='./selfsigned_rootCA'

## Server domain for CA, here is same as FRPS_SERVER_DOMAIN for selfsigned certificates.
CA_SERVER_DOMAIN='domain.com'

## Server domain for frps deployment.
FRPS_SERVER_DOMAIN='domain.com'

## Server ip for frps deployment.
FRPS_SERVER_IP='192.168.0.1'
```


## 1.2 Specify following variables in `cfgs/frps.ini` file for your domain.
Just refer to official document.
The most required variables are:

* `token` : token for authentication between frpc and frps.
* `subdomain_host` : subdomain for frps routing.


# 2. Initialize services environment

Run the following script to generate selfsigned certificates for frps and frpc.

```bash
./1_init.sh
```

# 3. Launch:

```bash
docker compose up -d
```

