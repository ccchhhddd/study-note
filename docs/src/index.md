# notes.github.io


个人CS笔记网站，先随便玩玩
[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://ccchhhddd.github.io)

## 内容

```@eval
dirs = ["Optimization"]

"总篇数：$(sum(map(file -> length(readdir(joinpath(@__DIR__,"..","src",file))), dirs)))"
```

### 优化

```@contents
Pages = map(file -> joinpath("Optimization", file), readdir("Optimization"))
```
