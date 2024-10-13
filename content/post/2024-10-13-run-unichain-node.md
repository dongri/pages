+++
title = "Unichain node (sepolia) 起動"
date = 2024-10-13T18:25:29+09:00
tags = ['unichain', 'node']
+++

Unichain node (sepolia) を起動するメモ

# 環境
```
Cloud: aws
OS: ubuntu 24
Instance: t2.xlarge(16GM Memory, 400GB SSD)
```

# docker, docker-compose install
```
# docker install
$ sudo apt update
$ sudo apt upgrade

$ curl -sSL https://get.docker.com/ | sh

$ docker version
 Version:           27.3.1

$ sudo service docker start
$ sudo systemctl enable docker
$ sudo usermod -aG docker ubuntu
$ exit

$ docker ps

# docker-compose install
$ sudo curl -L "https://github.com/docker/compose/releases/download/v2.29.7/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
$ docker-compose version
Docker Compose version v2.29.7
```

# unichain
```
$ git clone https://github.com/Uniswap/unichain-node.git
$ cd unichain-node
$ vim .env.sepolia
OP_NODE_L1_BEACON=https://ethereum-sepolia-beacon-api.publicnode.com

$ docker-compose up -d
$ curl -d '{"id":1,"jsonrpc":"2.0","method":"eth_syncing","params":[]}' -H "Content-Type: application/json" http://localhost:8545 | jq

# logs
$ docker logs -f unichain-node-op-node-1
$ docker logs -f unichain-node-execution-client-1
```
