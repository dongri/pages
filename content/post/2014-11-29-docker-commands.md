+++
date = "2014-11-29T11:28:57+09:00"
draft = false
title = "Docker Commands"
tags = ["docker"]
+++

* __Installing Docker on Mac OS X__

[https://docs.docker.com/installation/mac/](https://docs.docker.com/installation/mac/)

* __boot2ocker start__

```
$ boot2docker start
```

* __attach__ ( Attach to a running container )

```
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
adead7a08f15        ubuntu:14.04        /bin/bash           About an hour ago   Up 27 minutes                           myubuntu            

$ docker attach myubuntu
root@adead7a08f15:/#
```

* __build__ ( Build an image from a Dockerfile )

```
$ vim Dockerfile
FROM centos:centos6
MAINTAINER Dongri Jin

RUN yum update -y && \
    rpm --import http://nginx.org/keys/nginx_signing.key && \
    yum install -y http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm && \
    yum install -y nginx

EXPOSE 80
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]

$ docker build -t ngix .

$ docker images

$ docker run -d -p 80:80 nginx

$ VBoxManage controlvm "boot2docker-vm" natpf1 "nginx,tcp,127.0.0.1,8080,,80"

$ open http://localhost:8080
```

* __commit__ ( Create a new image from a container's changes )

```
$ docker run -i -t -d nginx                       
ea21748dddd379d8959373cd366b1eb10f4193a68c530c3539fe110b0531bd22

$ docker  docker ps
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS              PORTS               NAMES
ea21748dddd3        nginx:latest        /usr/sbin/nginx -g '   About an hour ago   Up 3 seconds        80/tcp              tender_fermi        

$ docker commit ea21748dddd3 my-nginx
69f023fe647655f984afd0617dd1e65d8b9a2e5e551bac32af5e6436bfe3ac70

$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
my-nginx            latest              69f023fe6476        About an hour ago   267.8 MB
nginx               latest              9bc094d3c806        About an hour ago   267.8 MB
```

* __cp__ ( Copy files/folders from a container's filesystem to the host path )

```
$ docker run -d nginx
69e4211b565349631845e984a5914688a250671764c98c959236fb53d059a709

$ docker ps
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS              PORTS               NAMES
69e4211b5653        nginx:latest        /usr/sbin/nginx -g '   About an hour ago   Up 1 seconds        80/tcp              distracted_curie    

$ docker cp 69e4211b5653:/usr/share/nginx/html/index.html ./

$ ls -l
total 16
-rw-r--r--  1 dongri  staff  332 Nov 29 17:41 Dockerfile
-rw-r--r--  1 dongri  staff  612 Sep 16 22:57 index.html
```


* __diff__ ( Inspect changes on a container's filesystem )

```
$ docker ps
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS              PORTS               NAMES
69e4211b5653        nginx:latest        /usr/sbin/nginx -g '   About an hour ago   Up 3 minutes        80/tcp              distracted_curie    

$ docker diff 69e4211b5653
C /var
C /var/cache
C /var/cache/nginx
A /var/cache/nginx/client_temp
A /var/cache/nginx/fastcgi_temp
A /var/cache/nginx/proxy_temp
A /var/cache/nginx/scgi_temp
A /var/cache/nginx/uwsgi_temp
C /var/run
A /var/run/nginx.pid

```

* __events__ ( Get real time events from the server )

```
$ docker events
[2014-11-29 17:09:17 +0900 JST] d9860be76a657a: (from my-nginx:latest) create
[2014-11-29 17:09:17 +0900 JST] d9860be76a657a: (from my-nginx:latest) start
[2014-11-29 17:09:17 +0900 JST] d9860be76a657a: (from my-nginx:latest) die
[2014-11-29 17:09:42 +0900 JST] 94d8ff9c9b006b: (from nginx:latest) create
[2014-11-29 17:09:42 +0900 JST] 94d8ff9c9b006b: (from nginx:latest) start
[2014-11-29 17:10:19 +0900 JST] 94d8ff9c9b006b: (from nginx:latest) die

```

* __export__ ( Stream the contents of a container as a tar archive)

```
$ docker ps
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS              PORTS               NAMES
69e4211b5653        nginx:latest        /usr/sbin/nginx -g '   About an hour ago   Up 9 minutes        80/tcp              distracted_curie    

$ docker export 69e4211b5653 > nginx.tar
```

* __history__ ( Show the history of an image )

```
$ docker history nginx
IMAGE               CREATED             CREATED BY                                      SIZE
9bc094d3c806        About an hour ago   /bin/sh -c #(nop) ENTRYPOINT [/usr/sbin/nginx   0 B
bc8b862f52f2        About an hour ago   /bin/sh -c #(nop) EXPOSE map[80/tcp:{}]         0 B
6a7c1a5d6e92        About an hour ago   /bin/sh -c yum update -y &&     rpm --import    52.02 MB
7becd8731a8d        About an hour ago   /bin/sh -c #(nop) MAINTAINER Dongri Jin         0 B
70441cac1ed5        3 weeks ago         /bin/sh -c #(nop) ADD file:87e3d5074ec1720805   215.8 MB
5b12ef8fd570        8 weeks ago         /bin/sh -c #(nop) MAINTAINER The CentOS Proje   0 B
511136ea3c5a        17 months ago                                                       0 B

$  
```

* __images__ ( List images )

```
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
my-nginx            latest              69f023fe6476        About an hour ago   267.8 MB
nginx               latest              9bc094d3c806        About an hour ago   267.8 MB
centos              centos6             70441cac1ed5        3 weeks ago         215.8 MB
ubuntu              14.04               c4ff7513909d        3 months ago        225.4 MB
ubuntu              latest              c4ff7513909d        3 months ago        225.4 MB

```

* __import__ ( Create a new filesystem image from the contents of a tarball )

```
$ cat nginx.tar | docker import - nginx:import                                                                                                                                                    254714ba37221092c47f22a886c7f7497ed65da53d42cf24a4f44e0054305af4

$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
nginx               import              254714ba3722        About an hour ago   242.8 MB
my-nginx            latest              69f023fe6476        About an hour ago   267.8 MB
nginx               latest              9bc094d3c806        About an hour ago   267.8 MB

```

* __info__ ( Display system-wide information )

```
$ docker info
```

* __inspect__ ( Return low-level information on a container )

```
$ docker inspect 69e4211b5653
```

* __kill__ ( Kill a running container )

```
$ docker ps                        
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS              PORTS               NAMES
69e4211b5653        nginx:latest        /usr/sbin/nginx -g '   About an hour ago   Up 23 minutes       80/tcp              distracted_curie    

$ docker kill 69e4211b5653
69e4211b5653

$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```

* __load__ ( Load an image from a tar archive )

```
$ docker load < nginx.tar
```


* __login__ ( Register or log in to the Docker registry server )

```
$ docker login
Username: dongri
Password: ***
Email: ***@gmail.com
Login Succeeded

$ docker pull ubuntu

```

* __logs__ ( Fetch the logs of a container )

```
$ docker logs 108233ba9a1d
```

* __port__ ( Lookup the public-facing port that is NAT-ed to PRIVATE_PORT )

```
$ docker run -d -p 80:80 nginx
108233ba9a1df0aa199a8392d052f3c0cd8e7929bdeff6d5fa52ac47a75aa603

$ docker port 108233ba9a1d 80
0.0.0.0:80
```

* __pause__ ( Pause all processes within a container )

```
$ docker pause 108233ba9a1d
108233ba9a1d

$ open http://localhost:8080

```

* __ps__ ( List containers )

```
$ docker ps

$ docker ps -a

$ docker ps -a -q
```

* __pull__ ( Pull an image or a repository from a Docker registry server )

```
$ docker pull golang:1.4rc1
```

* __push__ ( Push an image or a repository to a Docker registry server )

```
$ docker run -i -t -d golang
921dc8b1555af7507f8669883724047b4cc114be0681a07f86def

$ docker ps
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS                   PORTS                NAMES
16f79ec35b99        golang:latest       /bin/bash              About an hour ago   Up 4 seconds                                  focused_newton      
108233ba9a1d        nginx:latest        /usr/sbin/nginx -g '   About an hour ago   Up 15 minutes (Paused)   0.0.0.0:80->80/tcp   nostalgic_almeida   

$ docker commit 16f79ec35b99 dongri/golang
da5a0042ad9ac478c38fc743c8f981f292a9aefd41ac54276a6617c319719ad1

$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
dongri/golang       latest              da5a0042ad9a        About an hour ago   448 MB
nginx               import              254714ba3722        About an hour ago   242.8 MB
my-nginx            latest              69f023fe6476        2 hours ago         267.8 MB
nginx               latest              9bc094d3c806        2 hours ago         267.8 MB
golang              1.4rc1              a9e27473d0f8        2 days ago          467.7 MB
golang              latest              ebd3fd90ae2e        2 days ago          448 MB

$ docker push dongri/golang
The push refers to a repository [dongri/golang] (len: 1)
Sending image list
Pushing repository dongri/golang (1 tags)
511136ea3c5a: Image already pushed, skipping
36fd425d7d8a: Image already pushed, skipping
aaabd2b41e22: Image already pushed, skipping
cd9d7733886c: Image already pushed, skipp
da5a0042ad9a: Image successfully pushed
Pushing tag for rev [da5a0042ad9a] on {https://cdn-registry-1.docker.io/v1/repositories/dongri/golang/tags/latest}
```


* __restart__ ( Restart a running container )

```
$ docker ps
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS                   PORTS                NAMES
16f79ec35b99        golang:latest       /bin/bash              About an hour ago   Up 3 minutes                                  focused_newton      
108233ba9a1d        nginx:latest        /usr/sbin/nginx -g '   About an hour ago   Up 18 minutes (Paused)   0.0.0.0:80->80/tcp   nostalgic_almeida   

$ docker restart 16f79ec35b99
16f79ec35b99
```

* __rm__ ( Remove one or more containers )

```
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS
16f79ec35b99        golang:latest       /bin/bash              About an hour ago   Up 55 seconds
714a086c9e4d        golang:latest       /bin/bash              About an hour ago   Exited (1) 4 minutes ago

$ docker rm 714a086c9e4d
714a086c9e4d

$ docker ps -a          
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS
16f79ec35b99        golang:latest       /bin/bash              About an hour ago   Up About a minute
```

* __rmi__ ( Remove one or more images )

```
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
dongri/golang       latest              da5a0042ad9a        About an hour ago   448 MB
nginx               import              254714ba3722        About an hour ago   242.8 MB
my-nginx            latest              69f023fe6476        2 hours ago         267.8 MB

$ docker rmi 69f023fe6476

$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
dongri/golang       latest              da5a0042ad9a        About an hour ago   448 MB
nginx               import              254714ba3722        About an hour ago   242.8 MB

```

* __run__ ( Run a command in a new container )

```
$ docker run -d nginx

```

* __save__ ( Save an image to a tar archive )

```
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
dongri/golang       latest              da5a0042ad9a        About an hour ago   448 MB
nginx               import              254714ba3722        About an hour ago   242.8 MB

$ docker save nginx > mynginx.tar

```

* __search__ ( Search for an image on the Docker Hub )

```
$ docker search dongri
NAME            DESCRIPTION   STARS     OFFICIAL   AUTOMATED
dongri/coreos                 2                    
dongri/node                   1                    
dongri/nginx                  0                    
dongri/redis                  0                    
dongri/golang                 0
```

* __start__ ( Start a stopped container )

```
docker ps -a
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS                           PORTS
108233ba9a1d        nginx:latest        /usr/sbin/nginx -g '   About an hour ago   Up 27 minutes (Paused)           0.0.0.0:80->80/tcp
269367b4bd87        nginx:latest        /usr/sbin/nginx -g '   About an hour ago   Exited (-1) 28 minutes ago

$ docker start 269367b4bd87
269367b4bd87

$ docker ps
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS                   PORTS                NAMES
108233ba9a1d        nginx:latest        /usr/sbin/nginx -g '   About an hour ago   Up 27 minutes (Paused)   0.0.0.0:80->80/tcp   nostalgic_almeida   
269367b4bd87        nginx:latest        /usr/sbin/nginx -g '   About an hour ago   Up 2 seconds             80/tcp               kickass_perlman     

```


* __stop__ ( Stop a running container )

```
$ docker ps
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS                   PORTS                NAMES
108233ba9a1d        nginx:latest        /usr/sbin/nginx -g '   About an hour ago   Up 27 minutes (Paused)   0.0.0.0:80->80/tcp   nostalgic_almeida   
269367b4bd87        nginx:latest        /usr/sbin/nginx -g '   About an hour ago   Up 2 seconds             80/tcp               kickass_perlman     

$ docker stop 269367b4bd87
```

* __tag__ ( Tag an image into a repository )

```
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
dongri/golang       latest              da5a0042ad9a        About an hour ago   448 MB
nginx               import              254714ba3722        About an hour ago   242.8 MB

$ docker tag 254714ba3722 nginx:export
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
dongri/golang       latest              da5a0042ad9a        About an hour ago   448 MB
nginx               import              254714ba3722        About an hour ago   242.8 MB
nginx               export              254714ba3722        About an hour ago   242.8 MB

```


* __top__ ( Lookup the running processes of a container )

```
$ docker ps
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS                   PORTS                NAMES
108233ba9a1d        9bc094d3c806        /usr/sbin/nginx -g '   About an hour ago   Up 38 minutes (Paused)   0.0.0.0:80->80/tcp   nostalgic_almeida   

$ docker top 108233ba9a1d
PID                 USER                COMMAND
1658                root                nginx: master process /usr/sbin/nginx -g daemon off;
1668                499                 nginx: worker process
```

* __unpause__ ( Unpause a paused container )

```
$ docker ps
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS                   PORTS                NAMES
108233ba9a1d        9bc094d3c806        /usr/sbin/nginx -g '   About an hour ago   Up 38 minutes (Paused)   0.0.0.0:80->80/tcp   nostalgic_almeida   

$ docker unpause 108233ba9a1d
108233ba9a1d

$ open http://localhost:8080

```

* __version__ ( Show the Docker version information )

```
$ docker version
Client version: 1.1.1
Client API version: 1.13
Go version (client): go1.2.1
Git commit (client): bd609d2
Server version: 1.1.2
Server API version: 1.13
Go version (server): go1.2.1
Git commit (server): d84a070
```

* __wait__ ( Block until a container stops, then print its exit code )

```
$ docker wait 108233ba9a1d

$ docker stop 108233ba9a1d
```
