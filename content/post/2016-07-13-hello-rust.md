+++
date = "2016-07-13T23:35:22+09:00"
title = "Hello Rust"
tags = ['rust', 'programming']
+++

# Install

```
$ brew search rust
multirust    rust    uncrustify
$ brew install rust

$ rustc --version
rustc 1.10.0
$
```

# hello world

```
$ vim hello.rs
fn main() {
    println!("Hello Rust!");
}

$ rustc hello.rs
$ ./hello
Hello Rust!
$
```
