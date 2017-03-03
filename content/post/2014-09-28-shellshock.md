+++
date = "2014-09-28T11:28:57+09:00"
draft = false
title = "ShellShock"
tags = ["linux", "security"]
+++


<blockquote class="twitter-tweet" lang="en"><p>bash 脆弱性 ｷﾀ━(ﾟ∀ﾟ)━! <a href="http://t.co/a4anqJxILC">pic.twitter.com/a4anqJxILC</a></p>&mdash; Dongri Jin (@dongriat) <a href="https://twitter.com/dongriat/status/514962923010019328">September 25, 2014</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>


3日ほど経ちましたが、あのshellshockについて見かけた記事ををまとめてみた。

当日は社内で二人で「楽しく」対応したが、ある意味面白かった。


* BASHの脆弱性でCGIスクリプトにアレさせてみました  
[http://www.walbrix.com/jp/blog/2014-09-bash-code-injection.html](http://www.walbrix.com/jp/blog/2014-09-bash-code-injection.html)

* 先程から騒ぎになっているbashの脆弱性について  
[http://blog.ueda.asia/?p=3967](http://blog.ueda.asia/?p=3967)

* bashの脆弱性(CVE-2014-6271) #ShellShock の関連リンクをまとめてみた  
[http://d.hatena.ne.jp/Kango/20140925/1411612246](http://d.hatena.ne.jp/Kango/20140925/1411612246)

* bashの脆弱性がヤバすぎる件  
[https://x86-64.jp/blog/CVE-2014-6271](https://x86-64.jp/blog/CVE-2014-6271)

* bash脆弱性への対応  
[http://qiita.com/tomohisaota/items/8a8049eea11ece3781b3](http://qiita.com/tomohisaota/items/8a8049eea11ece3781b3)

* 2014/09/24に発表されたBash脆弱性と解決法(RedHat系)  
[http://qiita.com/richmikan@github/items/5f54114a46e64178133d﻿](http://qiita.com/richmikan@github/items/5f54114a46e64178133d﻿)

* AWS Elastic Beanstalk bash脆弱性への対応  
[http://qiita.com/dongri/items/5a1fd49e091438ef37d7](http://qiita.com/dongri/items/5a1fd49e091438ef37d7)

この後もいろんな記事出たが、省略

### 対応内容
```
$ env x='() { :;}; echo vulnerable' bash -c 'echo bash test'
vulnerable
bash test

$ sudo yum clean all

$ sudo yum update bash

$ env x='() { :;}; echo vulnerable' bash -c 'echo bash test'
bash test
$
```
