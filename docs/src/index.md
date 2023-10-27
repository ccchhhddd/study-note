# chd的学习文档分享空间

![img](assets/home.png)




!!! tip

    * [综合能源系统设计优化平台开发项目github仓库](https://github.com/ccchhhddd/IES-DOPT)
    * [个人笔记网站github仓库](https://github.com/ccchhhddd/study-notes)
    

欢迎共同学习交流！
![Stable](https://img.shields.io/badge/Docs-Updating...-blue.svg?style=flat-square)

## 学习文档内容

```@eval
dirs = ["Optimization","Front_end","Mac_share"]
"总篇数：$(sum(map(file -> length(readdir(joinpath(@__DIR__,"..","src",file))), dirs)))"
```
### 网页构建
```@contents
Pages = map(file -> joinpath("Web_build", file), readdir("Web_build"))
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
Pages = map(file -> joinpath("mac_share", file), readdir("Mac_share"))
```
