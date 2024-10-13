+++
title = "Let's Encryptでワイルドカード証明書発行してみた"
date = 2018-03-23T23:37:02+09:00
tags = ['https', 'letsencrypt']
+++

Let's Encryptがワイルドカード証明書サポートしたので設定してみた。

## certbot
certbotの最新版をgithubから持ってくる

```
$ git clone https://github.com/certbot/certbot.git
```

## ワイルドカード証明書の取得
```
$ ./certbot-auto certonly --manual \
-d *.nilth.com -d nilth.com \
-m dongrium@gmail.com \
--agree-tos \
--manual-public-ip-logging-ok \
--preferred-challenges dns-01 \
--server https://acme-v02.api.letsencrypt.org/directory
```

* -d *.nilth.com -d nilth.com: ワイルドカード証明書とサブドメイン無しの証明書も含めて取得

* -m sample@example.com: 指定したメールアドレスとに証明書更新の通知を受け取る

* --agree-tos: 利用規約に同意

* --manual-public-ip-logging-ok: サーバーの IPアドレスがログに記録され公開されることを許可します。

* --preferred-challenges dns-01: DNS-01チャレンジタイプで検証するように指定

* --server https://acme-v02.api.letsencrypt.org/directory: ACMEv2 のエンドポイント

```
Requesting to rerun ./certbot-auto with root privileges...
[sudo] password for dongri:
Creating virtual environment...
Installing Python packages...
Installation succeeded.
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Plugins selected: Authenticator manual, Installer None

-------------------------------------------------------------------------------
Would you be willing to share your email address with the Electronic Frontier
Foundation, a founding partner of the Let's Encrypt project and the non-profit
organization that develops Certbot? We'd like to send you email about EFF and
our work to encrypt the web, protect its users and defend digital rights.
-------------------------------------------------------------------------------
(Y)es/(N)o: Y ← 入力
Obtaining a new certificate
Performing the following challenges:
dns-01 challenge for nilth.com

-------------------------------------------------------------------------------
Please deploy a DNS TXT record under the name
_acme-challenge.nilth.com with the following value:

T32vZj4xmZ12QR_kMblVS31p2Czjb7HT-UQyelDPcYE

Before continuing, verify the record is deployed.
-------------------------------------------------------------------------------
Press Enter to Continue
``` 

DNS TXT設定のためこの状態で一旦待つ。ドメインプロバイダでtxtレコードを設定する。
Value-Domainの例をあげると以下のように設定

```
txt _acme-challenge T32vZj4xmZ12QR_kMblVS31p2Czjb7HT-UQyelDPcYE
```

二回出るので、二回設定する。

すぐ反映されてないので反映されるまで待つ。
反映されるかどうかは以下のコマンドで確認。

```
$ dig -t txt nilth.com
$ host -t txt nilth.com
$ dig _acme-challenge.nilth.com any @8.8.8.8
```

反映されたらEnterを押して完了させる。

```
IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/nilth.com/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/nilth.com/privkey.pem
   Your cert will expire on 2018-06-21. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot-auto
   again. To non-interactively renew *all* of your certificates, run
   "certbot-auto renew"
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le
```

## Nginx設定

https://nilth.com

```
server {
    listen 80;
    server_name nilth.com;
    root /usr/share/nginx/html/nilth.com;
    location / {
        return 301 https://$server_name$request_uri;
    }
}

server {
    listen 443 ssl;
    server_name nilth.com;
    ssl_certificate /etc/letsencrypt/live/nilth.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/nilth.com/privkey.pem;
    ssl_session_tickets on;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers AESGCM:HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers on;
    root /usr/share/nginx/html/nilth.com;
}
```

https://girl.nilth.com

```
server {
    listen 80;
    server_name girl.nilth.com;
    root /usr/share/nginx/html/nilth.com/girl;
    location / {
        return 301 https://$server_name$request_uri;
    }
}

server {
    listen 443 ssl;
    server_name girl.nilth.com;
    ssl_certificate /etc/letsencrypt/live/nilth.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/nilth.com/privkey.pem;
    ssl_session_tickets on;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers AESGCM:HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers on;
    root /usr/share/nginx/html/nilth.com/girl;
}
```

これで、ドメインとサブドメインが同じ証明書でアクセスできるようになった。
更新時は以下のコマンドでいけるらしい

```
$ ./certbot-auto renew
```

昔みたいにサブドメイン作成する度に `/certbot-auto certonly --webroot ***` 打たなくて良くなった。

## 追記
更新で `$ ./certbot-auto renew --force-renewal` にすると

```
The error was: PluginError('An authentication script must be provided with --manual-auth-hook when using the manual plugin non-interactively.',) 
```
こんなエラーで更新出来なかった。
```
$ ./certbot-auto certonly --manual \
-d *.nilth.com -d nilth.com \
-m dongrium@gmail.com \
--agree-tos \
--manual-public-ip-logging-ok \
--preferred-challenges dns-01 \
--server https://acme-v02.api.letsencrypt.org/directory
```
もう一回TXT認証させて更新。
