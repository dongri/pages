+++
date = "2014-06-29T11:28:57+09:00"
draft = false
title = "OAuthSwift"
tags = ["swift", "oauth", "oss"]
+++

先日社内SwiftハッカソンでFlickrのPrivate写真を見せるアプリを作ろうとしたところ、
FlickrのOAuth認証で半日ハマって結局Private写真はだめで、キーワード検索アプリを作った。
その後Githubで検索しても、ちょっと汎用的なiOSのOAuthライブラリがなくて、
Swiftの勉強も含めてOAuthライブラリを書いてみた。(OAuth1.0, OAuth2.0両方対応したつもりであるが)

Github : [https://github.com/dongri/OAuthSwift](https://github.com/dongri/OAuthSwift "OAuthSwift")

使用例：

```
// OAuth1.0
let oauthswift = OAuth1Swift(
    consumerKey:    "********",
    consumerSecret: "********",
    requestTokenUrl: "https://api.twitter.com/oauth/request_token",
    authorizeUrl:    "https://api.twitter.com/oauth/authorize",
    accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
)
oauthswift.authorizeWithCallbackURL( NSURL(string: "oauth-swift://oauth-callback/twitter"), success: {
    credential, response in
    println(credential.oauth_token)
    println(credential.oauth_token_secret)
}, failure: failureHandler)

// OAuth2.0
let oauthswift = OAuth2Swift(
    consumerKey:    "********",
    consumerSecret: "********",
    authorizeUrl:   "https://api.instagram.com/oauth/authorize",
    responseType:   "token"
)
oauthswift.authorizeWithCallbackURL( NSURL(string: "oauth-swift://oauth-callback/instagram"), scope: "likes+comments", state:"INSTAGRAM", success: {
    credential, response in
    println(credential.oauth_token)
}, failure: failureHandler)

```


### 各サービスOAuth関連ページ

* Twitter:   
  [https://dev.twitter.com/docs/auth/oauth]( "oauth")

* Flickr:  
  [https://www.flickr.com/services/api/auth.oauth.html]( "oauth")

* Github:  
  [https://developer.github.com/v3/oauth/]( "oauth")

* Instagram:  
  [http://instagram.com/developer/authentication/]( "oauth")

* Foursquare:  
  [https://developer.foursquare.com/overview/auth]( "oauth")
