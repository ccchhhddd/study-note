# chd的学习文档分享空间

欢迎共同学习交流！
![Stable](https://img.shields.io/badge/Docs-Updating...-blue.svg?style=flat-square)

本地编译markdown文件到html请使用如下命令：
```shell
julia --project=docs/ -e 'using Pkg; Pkg.update(); Pkg.instantiate()'
julia --project=docs/ docs/make.jl
``` 

PS:`./src`中包含了文档中的一些代码与相关资源
