+++
date = "2014-06-17T11:28:57+09:00"
draft = false
title = "Docker Sharing"
tags = ["docker"]
+++

dockerインストールしてみた、docker触ってみたい、dockerでnginx立ててみた、
dockerでwordpressやってみた、とかとか。結局、日常開発でどう使えばいいんだっけ？の質問の答えに
なってない。

開発環境がLinux、Ubuntuでvim派だと docker run 時に -v オプション付けてhostとcontainerの
リソースを共有できるが、開発環境がMacだと間にVMが挟んでるのでややこしくなる。

Vagrant使ったことある方は、vm.synced_folder 一発で解決できるんじゃないと思うかも知りませんが、
boot2dockerではカスタムvagrant boxを使わないとできないみたい。

boot2dockerが推奨してるのは、sambaサーバー経由でフォルダ共有ということなので、設定してみた。

```
$ docker run -v /var/app/ --name app busybox
$ docker run --name app-samba --rm -v /usr/local/bin/docker:/docker -v /var/run/docker.sock:/docker.sock svendowideit/samba app
```

ここまでやると、finderから cifs://192.168.59.103, smb://192.168.59.103 にアクセスして、Guestユーザーで/var/appに入れる。

docker-nginx, docker-nodeで、ソースフォルダを /var/app/nginx/html, /var/app/nodejs にした理由もここにある。

nginx、nodeをsambaサーバーのVolumesを使って起動する

```
### nodeの例：
$ docker run -p 3000:3000 --volumes-from samba-server -i -t dongri/node bash
bash-4.1# cd /var/app/nodejs/
bash-4.1# npm install
bash-4.1# nodemon index.js
17 Jun 08:12:18 - [nodemon] v1.2.0
17 Jun 08:12:18 - [nodemon] to restart at any time, enter `rs`
17 Jun 08:12:18 - [nodemon] watching: *.*
17 Jun 08:12:18 - [nodemon] starting `node index.js`
Express server listening on port 3000

### nginxの例：
$ docker run -p 80:80 --volumes-from samba-server -i -t dongri/nginx

```

ここまでやったら、macから/var/appにソースを入れて好きなように開発できる。

### 課題

ソースはgitで管理してるので、いちいちsambaにコピーするのが面倒。。。

どなたかよい解決方法あればお願いします！

### 追記(2014.06.18)

@yungsang がvagrant書いてくれたので、そちらも

[Re: Dongri's Blog - docker-sharing](http://qiita.com/yungsang/items/98dead73d54d580d4b78)

```
$ vim Vagrantfile
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "boot2docker"

  config.vm.box = "yungsang/boot2docker"

  config.vm.network :forwarded_port, guest: 2375, host: 4243, disabled: true

  config.vm.network :private_network, ip: "192.168.33.10"

  config.vm.synced_folder ".", "/var/app", type: "nfs"

  # Fix busybox/udhcpc issue
  config.vm.provision :shell do |s|
    s.inline = <<-EOT
      if ! grep -qs ^nameserver /etc/resolv.conf; then
        sudo /sbin/udhcpc
      fi
      cat /etc/resolv.conf
    EOT
  end

  # Adjust datetime after suspend and resume
  config.vm.provision :shell do |s|
    s.inline = <<-EOT
      sudo /usr/local/bin/ntpclient -s -h pool.ntp.org
      date
    EOT
  end

  config.vm.provision :shell do |s|
    s.inline = <<-EOT
      docker rm -f nodejs || true
    EOT
  end

  config.vm.provision :docker do |d|
    d.build_image "/var/app/node/", args: "-t dongri/node"
    d.run "nodejs", image: "dongri/node", args: "-p 3000:3000"
  end

  config.vm.network :forwarded_port, guest: 3000, host: 3000
end
```

```
$ git clone git@github.com:dongri/Dockerfiles.git
$ cd Dockerfiles
$ edit Vagrantfile
$ vagrant up
$ open http://localhost:3000
```

ありがとうございます！
