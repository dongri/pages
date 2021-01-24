# Install hugo
```
$ cd go/src/github.com
$ mkdir gohugoio
$ cd gohugoio
$ git clone https://github.com/gohugoio/hugo.git
$ cd hugo
$ go install
```

# Start Local server
```
$ hugo serve

$ open http://localhost:1313/
```

# Public
```
$ cd public
$ git pull origin master
```

# Deploy
```
$ ./deploy.sh
```
