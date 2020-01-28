+++
date = "2015-02-16T11:28:57+09:00"
draft = false
title = "Google OAuth2"
tags = ["oauth"]
+++

Google OAuth2のトークンを手動で取得メモ。通常はWebアプリはブラウザで取得してトークンとか保存すればいいのだが、
hubot scriptでcalendar情報とか取得したい場合は、そうはいかない。

## クライアントID作成

予めGoogle Developer Console画面で、クライアントIDを作成
[https://console.developers.google.com/project](https://console.developers.google.com/project)

## code 取得

```
https://accounts.google.com/o/oauth2/auth
?client_id={client_id}
&redirect_uri={callback_url}
&scope={scope}
&response_type=code
&approval_prompt=force
&access_type=offline
```

scopeは https://www.googleapis.com/auth/calendar.readonly など

GETで上のURLを叩く。認証画面が開き、承認すると、指定したcallback_urlにcodeが返ってくる。

```
{callback_url}?code=4/W30HqfsDKmamqdW*****************
```

## access_token, refresh_token 取得

```
$ curl
-d client_id={client_id}
-d client_secret={client_secret}
-d redirect_uri={callback_url}
-d grant_type=authorization_code
-d code={code} https://accounts.google.com/o/oauth2/token
```

以下のJSON結果が返ってくる

```
{
  "access_token" : "{access_token}",
  "token_type" : "Bearer",
  "expires_in" : 3600,
  "refresh_token" : "{refresh_token}"
}
```

access_tokenの情報を確認してみる。

```
https://www.googleapis.com/oauth2/v1/tokeninfo?access_token={access_token}
```

アクセスする度にexpires\_inが減って行くのがわかる。0になると、access\_tokenは失効されるので、使えない。

## 新しいaccess_tokenを取得
expires\_inで有効期限切れるまえに以下のPOSTで新しいaccess\_tokenを取得

```
$ curl
-d client_id={client_id}
-d client_secret={client_secret}
-d refresh_token={refresh_token}
-d grant_type=refresh_token https://accounts.google.com/o/oauth2/token
```

上の結果、新しいexpires\_inが3600の新しいaccess_tokenが返ってくる。

3600秒以内にaccess_tokenを更新して使えばOK!
