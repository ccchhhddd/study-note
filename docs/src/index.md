# study-note 个人学习文档分享空间

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://ccchhhddd.github.io/study-note/dev/)

## 内容

```@eval
dirs = ["Optimization"]
"总篇数：$(sum(map(file -> length(readdir(joinpath(@__DIR__,"..","src",file))), dirs)))"
```

### 优化

```@contents
Pages = map(file -> joinpath("Optimization", file), readdir("Optimization"))
```

### 前端
```@contents
Pages = map(file -> joinpath("Front-end", file), readdir("Front-end"))
```
