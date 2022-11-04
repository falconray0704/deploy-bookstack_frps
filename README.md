# deploy-bookstack_frps
Deploy frps behind nginx by docker compose, which serving for bookstack-vhost in LAN.

```bash
./run.sh 
Usage:
./run.sh -c <cmd> -l "<item list>"
eg:
./run.sh -c deploy -l "bookstack_frps"
Supported cmd:
deploy
Supported items:
bookstack_frps
```

