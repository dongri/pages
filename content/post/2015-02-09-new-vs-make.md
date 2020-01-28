+++
date = "2015-02-09T11:28:57+09:00"
draft = false
title = "new vs make"
tags = ["golang"]
+++

## new

[http://golang.org/pkg/builtin/#new](http://golang.org/pkg/builtin/#new)

```
func new(Type) *Type
```

* 組み込み関数 new はメモリの割り当て、第一引数は型であり、値ではない。戻り値はポインタである。


## make

[http://golang.org/pkg/builtin/#make](http://golang.org/pkg/builtin/#make)

```
func make(Type, size IntegerType) Type
```

* 組み込み関数 make は slice, map, chan型のメモリ割り当てとオブジェクトを初期化する。
* new と似ている、第一に引数は型であり、値ではない。new との違いは、make の戻り値はポインタではなく、値である。第一引数の型による。


### まとめ
* new の役割はポインタの処理機か(*T)。make の役割は slice, map, chan 初期化かつ引用を戻す(T)。

```
package main

import "fmt"

func main() {
  i := new(int)
  fmt.Println(&i)
  fmt.Println(*i)
  *i = 1
  fmt.Println(*i)

  mySlice := make([]int, 10, 100)
  fmt.Println(mySlice)
  mySlice[2] = 2
  fmt.Println(mySlice)

  myMap := make(map[string]string)
  fmt.Println(myMap)
  myMap["Android"] = "OnePlus"
  myMap["iOS"] = "iPhone"
  fmt.Println(myMap)

  myChan := make(chan int, 2)
  myChan <- 1
  myChan <- 2
  fmt.Println(myChan)
}
```
