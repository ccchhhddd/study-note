# github.io
笔记网站，先随便玩玩

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://ccchhhddd.github.io/study-note)

本地编译markdown文件到html请使用如下命令：
```shell
julia --project=docs/ -e 'using Pkg; Pkg.update(); Pkg.instantiate()'
julia --project=docs/ docs/make.jl
``` 

PS:`./src`中包含了文档中的一些代码与相关资源
