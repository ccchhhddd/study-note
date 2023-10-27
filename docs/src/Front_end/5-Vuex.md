# Vuex

## 1.vuex 是什么? 

1. 概念：专门在 Vue 中实现集中式状态（数据）管理的一个 Vue 插件，对 vue 应 用中多个组件的共享状态进行集中式的管理（读/写），也是一种组件间通信的方 式，且适用于任意组件间通信。 
2. Github 地址: https://github.com/vuejs/vuex 

## 2.什么时候使用Vuex?

1. 多个组件依赖于同一状态
2. 来自不同组件的行为需要变更同一状态

## 3.逻辑图：

![vuex](https://vuex.vuejs.org/vuex.png)

## 4.基本使用

1.具体案例

```
//index.js

// 该文件用于创建Vuex中最为核心的store

import Vue from 'vue'
// 引入Vuex
import Vuex from 'vuex'
Vue.use(Vuex)
// 准备actions——用于相应组件中的动作
// 业务逻辑写在action里面
const actions = {
    // jia(context,value){
    //     context.commit('JIA',value)
    // },
    // jian(context,value){
    //     context.commit('JIAN',value)
    // },
    oddjia(context,value){
        // console.log(state,context,value)
        if(context.state.sum % 2 == 1){
        context.commit('ODDJIA',value)
        }
    },
    timejia(context,value){
        setTimeout(()=>{
            context.commit('TIMEJIA',value)
        },500)
    }
}
// 准备mutations——用于操作数据（state）
const mutations = {
    JIA(state,value){
        state.sum += value
    },
    JIAN(state,value){
        state.sum -= value
    },
    ODDJIA(state,value){
        state.sum += value
    },
    TIMEJIA(state,value){
        state.sum += value
    }
}
// 准备state——用于存储数据
const state = {
    sum:0 //当前的和
}

// 创建store
export default new Vuex.Store({
    actions,
    mutations,
    state
})

//组件Count.vue

<template>
  <div>
    <h1> 当前求和为{{ $store.state.sum }}</h1>
    <select v-model="n">
        <option :value="1">1</option>
        <option :value="2">2</option>
        <option :value="3">3</option>
    </select>
    <button @click="increment">+</button>
    <button @click="decrement">-</button>
    <button @click="incrementodd">当前求和为奇数再加</button>
    <button @click="incrementwait">等一等再加</button>
  </div>
</template>

<script>
export default {
    name:'MyCount',
    data(){
        return{
            n:1,//用户选择的数字
            
        }
    },
    methods:{
        increment(){
            // 这里直接跳过了action（中间没有牵扯业务逻辑），所以直接用commit
            this.$store.commit('JIA',this.n)
        },
        decrement(){
            this.$store.commit('JIAN',this.n)
        },
        incrementodd(){
            this.$store.dispatch('oddjia',this.n)  
        },
        incrementwait(){
            this.$store.dispatch('timejia',this.n)     
        }
    },

}
</script>

```

2.组件中读取vuex中的数据：$store.state.sum

3.组件中修改vuex中的数据：$store.dispatch('action中的方法名'，数据)或$store.commit('mutations中的方法名'，数据)



### 5.getters的使用

1.概念：当state中的数据需要经过加工后再使用时，可以使用getters加工

2.在store.js中追加getters配置

```
const getters = {
    bigsum(state){
        return state.sum*10
    }
}

// 创建并暴露store
export default new Vuex.Store({
    ...
    getters

})
```

3.组件中读取数据：$store.getters.bigsum



### 6.四个map方法的使用

##### 1.mapState方法：

帮我们映射state中的数据为计算属性

```
computed:{
        // 1.靠程序员自己写的代码
        // he(){
        //     return this.$store.state.sum
        // },
        // xuexiao(){
        //     return this.$store.state.subject
        // },
        // xueke(){
        //     return this.$store.state.school
        // },

        // 2.借助mapState生成计算属性，从state中读取数据。（对象写法）
        // ...mapState({sum:'sum',school:'school',subject:'subject'}),

        // 3.借助mapState生成计算属性，从state中读取数据。（数组写法）
        ...mapState(['sum','school','subject']),
        }
```

##### 2.mapGetters方法：

用于帮助我们映射getters中的数据为计算属性

```
computed:{    
    // 1.靠程序员自己写的代码
        // bigsum(){
        //     return this.$store.getters.bigsum 
        // },
        // 2.借助mapGetters生成计算属性，从getters中读取数据。（数组写法）
        ...mapGetters(['bigsum'])
        }
```

##### 3.mapActions方法：

用于帮助我们生成与actions对话的方法，即包含$store.dispatch（xxx）的函数

```
methods:{
    // 1.程序员手写法
        // incrementodd(){
        //     this.$store.dispatch('oddjia',this.n)  
        // },
        // incrementwait(){
        //     this.$store.dispatch('timejia',this.n)     
        // }

        // 2.借助mapActions生成的方法，方法会调用dispatch去联系actions(对象写法)
        ...mapActions({incrementodd:'oddjia',incrementwait:'timejia'})

}
```

##### 4.mapMutations方法：

用于帮助我们生成与mutations对话的方法，即包含$store.commit(xxx)的函数

```
  methods:{ 
    // 1.程序员手写
        // increment(){
        //     // 这里直接跳过了action（中间没有牵扯业务逻辑），所以直接用commit
        //     this.$store.commit('JIA',this.n)
        // },
        // decrement(){
        //     this.$store.commit('JIAN',this.n)
        // },

        // 2.借助mapMutations生成对应的方法，方法会调用commit去联系mutations(对象写法)
        ...mapMutations({increment:'JIA',decrement:'JIA'}),
        }
```



### 7.模块化+命名空间

**1.目的：**让代码更好维护，让更多数据分类更加明确

**2.修改`store.js`**

```
// 求和相关配置
const countOptions= {
    namespaced:true,
    mutations:{...},
    getters:{
        bigsum(state){
            return state.sum*10
        }
    }
}

// 人员相关配置
const personOptions= {
    namespaced:true,
    actions:{...},
    mutations:{...},    
}

// 创建并暴露store
export default new Vuex.Store({
    modules:{
      a:countOptions,
      b:personOptions
    }
})
```

**3.开启命名空间后，组件中读取state数据：**

```
//1.自己直接读取
this.$store.state.a.list
//2.借助mapState读取
...mapState('a',['sum','school'])
```

**4.开启命名空间后，组件中读取getters数据：**

```
 //1.自己直接读取
 this.$store.getters['b/fisrtpersonname']
 //2.借助mapGetters读取
 ...mapGetters('a',['bigsum'])
```

**5.开启命名空间后，组件中调用dispatch**

```
 //1.自己直接读取
 this.$store.dispatch['b/addpersonwang',person]
 //2.借助mapActions;
 ...mapActions('a',{increment:'oddjia',incrementwait:'timejia'})
```

**6.开启命名空间后，组件中调用commit**

```
 //1.自己直接commit
 this.$store.commit['b/ADDPERSON',person]
 //2.借助mapMutations:
 ...mapMutations('a',{increment:'JIA',decrement:'JIAN'})
```



## 5.vue-router

### 1.相关理解

#### 1.vue-router 的理解 

vue 的一个插件库，专门用来实现 **SPA 应用** 

#### 2.对 SPA 应用的理解 

1.单页 Web 应用（single page web application，SPA）。 

2.整个应用只有**一个完整的页面**。 

3.点击页面中的导航链接不会刷新页面，只会做页面的**局部更新**。

1. 数据需要通过 ajax 请求获取

#### 3.路由的理解

##### 1.什么是路由?

​	1.一个路由就是一组映射关系（key - value） 

​	2.key 为路径, value 可能是 function 或 component 

##### 2.路由分类

1.后端路由：

​	1.理解：value 是 function, 用于处理客户端提交的请求。

```
2.工作过程：服务器接收到一个请求时, 根据**请求路径**找到匹配的**函数**来处理请求, 返回响应数据。
```

2.前端路由：

​	1.理解：value 是 component，用于展示页面内容。

```
2.工作过程：当浏览器的路径改变时, 对应的组件就会显示。
```



### 2.基本路由

#### 1.基本使用

1.安装vue-router ,命令：npm i vue-router

2.应用插件：Vue.use(VueRouter)

3.编写router配置项：

```
// 该文件专门用于创建整个应用的路由器
import VueRouter from 'vue-router'

// 引入组件
import About from '../pages/About'
import Home from '../pages/Home'

// 创建并暴露一个路由器
export default new VueRouter({
    routes:[
      {
        path:'/about',
        component:About
      },
      {
        path:'/home',
        component:Home
      }, 
    ]
})
```

4.实现切换（active-class 可配置高亮样式）

```
<router-link active-class='active' to='/about'>About</router-link>
```

5.指定展示位置

```
<router-view></router-view>
```



#### 2.几个注意点

​	1.路由组件通常存放在pages文件夹，一般组件通常存放在components文件夹

​	2.通过切换，“隐藏”了的路由组件，默认是被销毁掉的，需要的时候再去挂载

​	3.每个组件都有自己的$route属性，里面存储着自己的路由信息。

​	4.整个应用只有一个router,可以通过组件的$router属性获取到。



### 3.嵌套路由

1.配置路由规则，使用children配置项

```
// 创建并暴露一个路由器
export default new VueRouter({
    routes:[
      {
        path:'/about',
        component:About
      },
      {
        path:'/home',
        component:Home,
        children:[
          {
            // 这里不用加斜杠
            path:'news',
            component:News,
          },
          {
            path:'message',
            component:Message,
          },
        ]
      }, 
    ]
})

```

2.跳转（要写完整路径）

```
<router-link to='/home/news'>News</router-link>
```



### 4.路由的query参数

​	1.传递参数

```
<li v-for="m in messagelist" :key="m.id">
            <!-- 跳转路由并携带query参数，to的字符串写法 -->
            <!-- <router-link :to="`/home/message/detail?id=${m.id}&title=${m.title}`">{{ m.title }}</router-link>&nbsp;&nbsp; -->
        
            <!-- 跳转路由并携带query参数，to的对象写法 -->
            <router-link :to="{
                path:'/home/message/detail',
                query:{
                   id:m.id,
                   title:m.title                     
                }
            }">
                {{ m.title }}
            </router-link>
            &nbsp;&nbsp;
        </li>
```

2.接收参数：

```
 $route.query.id 
 $route.query.title 
```



### 5.命名路由

1.作用：可以简化路由的跳转

2.如何使用

​	1.给路由命名：

```
export default new VueRouter({
    routes:[
      {
        name:'guanyu',
        path:'/about',
        component:About
      },
      {
        path:'/home',
        component:Home,
        children:[
          {
            // 这里不用加斜杠
            path:'news',
            component:News,
          },
          {
            path:'message',
            component:Message,
            children:[
              {
                name:'xiangqing',
                path:'detail',
                component:Detail
              }
            ]
          },
        ]
      }, 
    ]
})
```

2.简化跳转：

```
//1.简化前写完整路径
<router-link :to="{
                path:/home/message/detail',
                query:{
                   id:m.id,
                   title:m.title                     
                }
            }">
//2.简化后直接通过名字跳转
<router-link :to="{
                name:'xiangqing',
                query:{
                   id:m.id,
                   title:m.title                     
                }
            }">
```



### 6.路由的params参数

1.配置路由，声明接收params参数

2.传递参数

注意：路由携带params参数时，若使用to的对象写法，则不能使用path配置项，必须使用name配置！

3.接收参数

```
$route.params.id
$route.params.title
```



### 7.路由的props配置

作用：让路由组件更方便的收到参数

```
{
                name:'xiangqing',
                path:'detail',
                component:Detail,
        // props的第一种写法，值为对象，该对象中的所有key-value都会以props的形式传给Detail组件
        // props:{a:1,b:'hello'}

       // props的第二种写法，值为布尔值，若布尔值为真，就会把该路由组件收到的所有params参数，以props的形式传给Detail组件。
       // props:true

      // props的第三种写法，值为函数,该函数返回的对象中每一组key-value都会通过props传给Detail组件
                props($route){
                  return {
                    id:$route.query.id,
                    title:$route.query.title,
                  }
              }
          }
```



### 8.router-link 的replace属性

​	1.作用：控制路由跳转时操作浏览器历史记录的模式

​	2.浏览器的历史记录有两种写入方式：分别为push和replace,push是追加历史记录，replace是替换当前记录。路由跳转时默认为push

​	3.如何开启replace模式：

​	<router-link replace ='true'>News</router-link>



### 9.编程式路由导航

​	1.作用：不借助router-link实现路由跳转，让路由跳转更加灵活

​	2.具体编码：

```
//$router的5个API
this.$router.push
this.$router.replace
this.$router.forward //前进
this.$router.back //后退
this.$router.go   //可前进可后退
```



### 10.缓存路由组件

1.作用：让不展示的路由组件保持挂载，不被销毁

2.具体编码：

```
<keep-alive include="MyNews">
            <router-view></router-view>
</keep-alive>
```



### 11.两个新的生命周期钩子

1.作用：路由组件所独有的两个钩子，用于捕获路由组件的激活状态。

2.具体名字：

​		1.`activated` 路由组件被激活时触发。

​		2.`deactivated` 路由组件失活时触发。



### 12.路由守卫

#### 1.作用：

对路由进行权限控制

#### 2.分类：

全局守卫、独享守卫、组件内守卫

#### 3.全局守卫：

```
// 全局前置路由守卫——初始化的时候被调用、每次路由切换之前被调用
router.beforeEach((to,from,next)=>{
  console.log(to,from)
  // 这里用to.name==='xinwen' ||to.name='xiaoxi'
  if(to.meta.isAuth){  
    if(localStorage.getItem('school')==='jiaoda'){
    next()
  }else{
      alert('学校名不对，无权限查看!')}
  }else{
    next()
  }
})

// 全局后置路由守卫————初始化的时候被调用，每次路由切换之后被调用
router.afterEach((to,from)=>{
  console.log(from)
  document.title = to.meta.title  || '网页页面'
})
```

#### 4.独享守卫

```
 beforeEnter:(to,from,next)=>{
              console.log(to,from)
              // 这里用to.name==='xinwen' ||to.name='xiaoxi'
              if(to.meta.isAuth){  
                if(localStorage.getItem('school')==='jiaoda'){
                next()
              }else{
                  alert('学校名不对，无权限查看!')}
              }else{
                next()
              }
    }}
```

独享守卫可以和全局路由后置守卫配合使用，但是独享守卫不可以与全局路由前置守卫一起使用，会发生覆盖的情况。

#### 5.组件内守卫

```
// 通过路由规则，进入该组件时被调用
    beforeRouteEnter(to,from,next){
      console.log(to,from)
    if(to.meta.isAuth){  
      if(localStorage.getItem('school')==='jiaoda'){
      next()
    }else{
      alert('学校名不对，无权限查看!')}
    }else{
      next()
    }
    },

// 通过路由规则，离开该组件时被调用
    beforeRouteLeave(to,from,next){
      next()
    }
```



### 13.路由器的两种工作模式

1.对于一个url来说，什么是hash值？——#及其后面的内容就是hsah值

2.hsah值不会包含在HTTP请求中，即：hash值不会带给服务器。

3.hash模式：

​	1.地址中永远带着#好，不美观

​	2.若以后将地址通过第三方手机app分享，若app校验合格，则地址会被标记为不合法。

​	3.兼容性较好

4.history模式：

​	1.地址干净，美观

​	2.兼容性和hash模式相比略差

​	3.应用部署上线时需要后端人员支持，解决刷新页面服务端404的问题。



## 6.Vue UI组件库

该部分无需笔记，直接看官方文档即可

### 1 .移动端常用 UI 组件库 

​	1.Vant https://youzan.github.io/vant 

​	2.Cube UI https://didi.github.io/cube-ui 

​	3.Mint UI http://mint-ui.github.io 



### 2 .PC 端常用 UI 组件库 

1. Element UI https://element.eleme.cn 
2. IView UI https://www.iviewui.co
