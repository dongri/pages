+++
date = "2014-04-21T11:28:57+09:00"
draft = false
title = "middleman blog"
tags=["middleman", "blog"]
+++

Octopress, Jekyll, Cabin いろいろあるみたいけど、Middlemanを使ってみようかと思って設置してみた。  

## middleman, middleman-blogインストール

```
$ gem install middleman
$ gem install middleman-blog
```

## middleman プロジェクト作成

```
$ middleman init dongri.github.io --template=blog
```

## レポジトリ設定

```
$ cd dongri.github.io
$ git init
$ git remote add origin git@github.com:dongri/dongri.github.io.git
```

## Gemfile を修正

```
gem "middleman-deploy"
gem "middleman-livereload"
gem "middleman-syntax"
gem "redcarpet"
gem "nokogiri"
```

``bundle install`` する。

## config.rb を設定

```
Time.zone = "Tokyo"

page "archives/*", layout: :post
page "archives/index.html", layout: :layout

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
end

set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true

activate :livereload
activate :directory_indexes
activate :syntax, line_numbers: true

# デプロイの設定
activate :deploy do |deploy|
  deploy.build_before = true
  deploy.method = :git
  deploy.branch = 'master'
end
```

## server起動

```
$ middleman server
```

## New Post

```
$ middleman article new-post
      create  source/2014-04-21-new-post.html.markdown
$
```

## source/2014-04-21-new-post.html.markdown 編集

```
---
layout: post
title: middleman blog
date: 2014-04-21
tags: middleman, blog
---

# ほげほげ

## Code

```

## build & deploy

```
$ middleman build
$ middleman deploy
```

## template & css
theme, templateなどググっても出てこない。  
しょうがなく自分デザイン?してcss組んでこんなページが生まれた。
