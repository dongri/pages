+++
date = "2015-01-10T11:28:57+09:00"
draft = false
title = "Migrating to Cedar-14 Stack"
tags = ["heroku"]
+++

bamboo-mri-1.9.2 stack 下岗了。

Migrating to the Celadon Cedar-14 Stack

```
$ heroku stack:set cedar-14
stack set, next release on production-app will use cedar-14
Run `git push heroku master` to create a new release on cedar-14

$ git commit --allow-empty -m "Upgrading to Cedar-14"
[master 973c3f7] Upgrading to Cedar-14

$ git push heroku master
```
