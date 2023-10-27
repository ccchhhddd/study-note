# 个人学习文档分享空间

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://ccchhhddd.github.io/study-note/dev/)

## 学习文档内容

```@eval
dirs = ["Optimization","Front_end","mac_share"]
"总篇数：$(sum(map(file -> length(readdir(joinpath(@__DIR__,"..","src",file))), dirs)))"
```

### 优化

```@contents
Pages = map(file -> joinpath("Optimization", file), readdir("Optimization"))
```

### 前端
```@contents
Pages = map(file -> joinpath("Front_end", file), readdir("Front_end"))
```

### Mac
```@contents
Pages = map(file -> joinpath("mac_share", file), readdir("mac_share"))
```