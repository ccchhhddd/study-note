## 3.Vue2笔记

nodejs

node express

webpack

### 1.Vue核心+组件化编程

#### 1.初识Vue：

要点：

1.想让Vue工作，就必须创建一个Vue实例，且要传入一个配置对象；

2.root容器里的代码符合html规范，只不过混入了一些特殊得Vue语法

3.root容器里的代码被称为[vue模版]

4.容器和实例一一对应

5.注意区分js表达式和js代码（语句）

**表达式：**一个表达式会产生一个值，可以放在任何一个需要值的地方

(1).a

(2)a+b

(3)demo(1)

(4)x===y?'a':'b'    [三目表达式]

**js代码（语句）**

(1)if(){}

(2)for(){}





#### 2.模版语法

v-bind ====>简写为   ：

vue 模版语法有2大类：

**1.插值语法：**

功能：用于解析标签体内容

写法：{{xxx}},xxx是js表达式，且可以直接读取到data中的所有属性。

**2.指令语法：**

功能：用于解析标签（包括：标签属性、标签体内容、绑定事件.....）

举例：v-bind:href="xxx"或简写为  :href="xxx"，xxx同样要写js表达式且可以直接读取到data中的所有属性

备注：Vue中有很多的指令，且形式都是：v-????,此处我们只是拿v-bind举例子

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>模版语法</title>
    <script type="text/javascript" src="../js/vue.js"></script>
</head>
<body>
    <div id="root">
    <h1>插值语法</h1>
    <h3>你好，{{name}}</h3>
    <hr/>
    <h1>指令语法</h1>
    <a v-bind:href="school.url.toUpperCase()">点我去百度</a>
    <a :href="school.url">点我又去百度</a>
    </div>

    <script type="text/javascript">
    new Vue({
        el:"#root",
        data:{
            name:'chd',
            school:{
                name:"chdchd",
                url:"https://www.baidu.com/?tn=15007414_20_dg"

            }
            
        }
    })
    </script>
    
</body>
</html>
```



#### 3.数据绑定

Vue中有2种数据绑定方式：

1.单项绑定（v-bind）：数据只能从data流向页面。

2.双向绑定（v-model）:数据不仅能从data流向页面，还能从页面流向data

备注：

​	1.双向绑定一般都应用在表单类元素上（如：input、select等）

​	2.v-model:value 可以简写为 v-model，因为v-model默认收集的就是value值

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>数据绑定</title>
    <script type="text/javascript" src="../js/vue.js"></script>
</head>
<body>
    <div id ="root">
        <!-- 普通写法 -->
        单项数据绑定：<input type="text" v-bind:value="name"><br/>
        双项数据绑定：<input type="text" v-model:value="name"><br/>

        <!-- 简写 -->
        单项数据绑定：<input type="text" :value="name"><br/>
        双项数据绑定：<input type="text" v-model="name"><br/>
        
        <!-- 如下代码是错误的,因为v-model只能应用在表单类元素(输入类元素)上
        <h2 v-model:x="name">nihao</h2> -->
    </div>
    
</body>

<script type="text/javascript">
    new Vue({
        el:'#root',
        data:{
            name:"chd"
        }

    })
</script>    
</html>
```





#### 4.el与data的两种写法

data与el的2种写法

##### 1.el有2种写法

（1) new Vue时候配置el属性

（2）先创建Vue实例，随后再通过vm.$mount('#root')指定el的值

##### 2.data有两种写法

（1）对象式

（2）函数式

如何选择：组件运用时要用函数式

##### 3.一个重要的原则：

由Vue管理的函数，一定不要写箭头函数，一旦写了箭头函数，this就不再是Vue实例了

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <script type="text/javascript" src="../js/vue.js"></script>
</head>
<body>
    <div id ="root">
        <h1>你好，{{name}}</h1>
    </div>
    
</body>

    <script type="text/javascript">
        // const v = new Vue({
        //     //el:'#root',//第一种写法
        //     data:{
        //         name:'chd'
        //     }
        // })
        // console.log(v)
        // v.$mount('#root')//第二种写法
        // 定时器演示
        // console.log(v)
        // setTimeout(() => {
        //     v.$mount('#root')
        // },1000);
    new Vue({
        el:'#root',
        // //data的第一种写法：对象式
        // data:{
        //     name:'hello'
        // }
        
        //data的第二种写法：函数式（组件时必须使用）
        data:function(){
            console.log('@@@',this)
            return{
                name:'chhd'
            }
        }
    })
    </script>
  
</html>
```



#### 5.理解MVVM

**vue的设计受到了MVVM的启发**

**MVVM模型：**

1.M:模型（Model）:对应data中的数据

2.V：试图（View）:模版

3.VM：视图模型（ViewModel）:Vue实例对象

**观察发现**

1.data中所有的属性，最后都出现在vm上

2.vm身上所有的属性，以及Vue原型上所有属性，在Vue模版中都可以直接使用

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <script type="text/javascript" src="../js/vue.js"></script>
</head>
<body>
    <div id ="root">
        <h1>学校名称：{{name}}</h1>
        <h1>学校地址：{{address}}</h1>  
        <h1>测试一下1:{{1+1}}</h1>
        <h1>测试一下1:{{_c}}</h1>
        <!-- VIEW -->
    </div>
    
</body>

<script type="text/javascript">
    vm = new Vue({//VIEWMODEL
        el:'#root',
        data:{
            name:'hello',
            address:'beijing' //MODEL
        }
    })
    console.log(vm)
</script>    
</html>
```



#### 6.数据代理

**1.回顾Object.defineProperty方法**

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>回顾Object.defineProperty方法</title>
    <!-- <script type="text/javascript" src="../js/vue.js"></script> -->
</head>
<body>
    <div id ="root">
        
    </div>
    
<script type="text/javascript">
    let number =20
    let person = {
        name:'ss',
        sex:'nan',
        
    }

    Object.defineProperty(person,'age',{
        // value:18,
        // enumerable:true,//可枚举
        // writable:true,//可修改
        // configurable:true, //控制属性是否被删除 
        
        //当有人读取person的age属性时，get函数(getter)就会被调用，且返回值就是age的值
        get:function(){
            return number
        },


        //当有人修改person的age属性时，set函数（setter）就会被调用，且会收到修改的具体值
        set(value){
            console.log('sss',value)
            number=value
        }
    })  
    console.log(Object.keys(person))
    console.log(person)
</script> 
</body>
</html>
```



**2.何为数据代理**

数据代理：通过一个对象代理对另一个对象中属性的操作（读/写）

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>何为数据代理</title>
    <script type="text/javascript" src="../js/vue.js"></script>
</head>
<body>
    <!-- 数据代理：通过一个对象代理对另一个对象中属性的操作（读/写） -->
<script type="text/javascript">
    let obj={x:100}
    let obj2={y:200}

    Object.defineProperty(obj2,'x',{
      get(){
        return obj.x
      },
      set(value){
        obj.x = value
      }
      //简单来说就是通过改变obj2.x里的数改变了obj的x。这就是一个简单的数据代理
    })
</script>
</body>  
</html>
```



**3.Vue中的数据代理**

```
数据代理就好比右图中的实线部分，实现的功能好比就是将data里的name和address放在vm里。这样在编写代码时更为方便，不用vm._data.name这样的写法，而直接vm.name即可。背后的逻辑也是实现了getter()和setter()的这样一个过程，也就是通过Object.defineProperty进行的实现。
```


```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <script type="text/javascript" src="../js/vue.js"></script>
</head>
<body>
    <div id ="root">
        <h2>学校名称：{{name}}</h2>
        <h2>学校地址：{{address}}</h2>
    </div>


<script type="text/javascript">
    const vm =new Vue({
        el:'#root',
        data:{
            name:'ccchhhddd',
            address:'beijing'
        }
        //埋一个数据劫持的坑
    })
</script> 
</body> 
</html>
```



#### 7.事件处理

##### **1.事件的基本使用：**

1.使用v-on：xxx 或 @xxx 绑定事件，其中xxx是事件名；

2.事件的回调需要配置在methods对象中，最终会在vm上；

3.methods中配置的函数，不要用箭头函数：否则this就不是vm了

4.methods中配置的函数，都是被Vue所管理的函数，this的指向是vm或组件实例对象；

5.@click="demo" 和@click="demo"($event)效果一致，但后者可以传参；

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <script type="text/javascript" src="../js/vue.js"></script>
</head>
<body>
    <div id ="root">
        <h2>{{name}}欢迎你</h2>
        <button v-on:click="showInfo1">点我提示信息（不传参）</button>
        <button v-on:click="showInfo2(66,$event)">点我提示信息2（传参）</button>
    </div>


<script type="text/javascript">



    const vm=new Vue({
        el:'#root',
        data:{
            name:'Beijing'
        },
        methods:{
            showInfo1(event){
                console.log(event.target)
                alert('nihao')
            },
            showInfo2(number,event){//最好别放在data里，会进行无意义的数据代理，这个东西只是用来被别人调用的
                console.log(number,event)
                alert(number)
            }
        }
    })
</script> 
</body> 
</html>
```



**补充概念：JavaScript事件的冒泡**

##### 事件冒泡的概念

事件冒泡是指当一个元素触发了某个事件（例如点击事件），该事件将从最内层的元素开始，逐级向外传播到父元素，直到传播到文档根节点。这种事件传播的过程就是事件冒泡。

##### 事件冒泡的处理方式

在处理事件冒泡时，有两种常用的方式：停止事件冒泡和使用事件委托。

##### 停止事件冒泡

通过停止事件冒泡，可以阻止事件继续向父元素传播。在事件处理函数中，可以使用event.stopPropagation()方法来停止事件冒泡。调用该方法后，事件将不再传播到父元素。



##### 2.事件修饰符

vue中的事件修饰符：

1.prevent:阻止默认事件（常用）

2.stop:阻止事件冒泡（常用）

3.once:事件只触发一次（常用）

4.capture：使用事件的捕获模式 

5.self:只有event.target是当前操作的元素时才触发事件 这个案例相当于阻止了冒泡事件的发生

6.passive:事件的默认行为立即执行，无需等待事件回调执行完毕

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <script type="text/javascript" src="../js/vue.js"></script>
    <style>
        /*  通配符*  */
        *{
            margin-top :20px;
        }
        .demo1{
            height: 50px;
            background-color: aqua;
        }
        .box1{
            padding: 5px;
            background-color: skyblue;
        }
        .box2{
            padding: 5px;
            background-color: orange;
        }
        .list{
            width:200px;
            height: 200px;
            background-color: peru;
            overflow: auto;
        }
        li{
           height: 100px; 
        }
    </style>

</head>
<body>
    <div id ="root">
        <!-- prevent:阻止默认事件（常用） -->
        <a href="https://www.baidu.com/?tn=15007414_20_dg" @click.prevent="showInfo">点击去{{name}}</a>
        <!--stop:阻止事件冒泡（常用） -->
    <div class="demo1" @click.self="showInfo">
        <button @click.stop="showInfo">点点试试</button>
    </div>

    <!--once:事件只触发一次（常用）  -->
    <button @click.once="showInfo">点点试试</button>
</br>
    <!-- capture：使用事件的捕获模式 -->
    <div class="box1" @click.capture="showMsg(1)">
        div1
        <div class="box2" @click="showMsg(2)">
        div2   
        </div>
    </div>
   
    <!-- self:只有event.target是当前操作的元素时才触发事件 这个案例相当于阻止了冒泡事件的发生 -->
    <div class="demo1" @click.self="showInfo">
    <button @click="showInfo">点点试试</button>
    </div>
    <!-- passive:事件的默认行为立即执行，无需等待事件回调执行完毕 -->
    <ul @wheel.passive="demo" class="list">
        <li>1</li>
        <li>2</li>
        <li>3</li>
        <li>4</li>
    </ul>

    </div>


<script type="text/javascript">
    new Vue({
        el:'#root',
        data:{
            name:'百度'
        },
    methods:{
        showInfo(e){
            // e.stopPropagation()
            alert('同学你好')
            //console.log(e.target)
        },

        showMsg(msg){
            console.log(msg)
        },
        demo(){
            for (let i=0;i<100000;i++){
                console.log('#')
            }
            console.log('wanle')
        }
    }
    })
</script> 
</body> 
</html>
```



##### 3.键盘事件

**1.vue中常用的按键别名：**

回车=>enter

删除=>delete(捕获“删除”和“退格键”)

退出=>esc

空格=>space

换行=>tab

上=>up

下=>down

左=>left

右=>right

**2.Vue未提供别名的按键，**可以使用按键原始的key值去绑定，但注意要转为kebab-case(短横线命名)



**3.系统修饰键（用法特殊）**：ctrl、alt、shift、meta

​	(1)配合keyup使用：按下修饰键的同时，再按下其他键，随后释放其他键，事件才被触发

（2）配合keydown使用：正常触发事件



**4.也可以使用keyCode去指定具体的按键（不推荐）**

**5.Vue.config.keyCodes.自定义键名=键码，可以去定制按键别名** （  直接关机键绑事件  【狗头】）



##### 4.事件总结

修饰符可以连写

例如：@keyup.ctrl.y   或者@click.stop.prevent







#### 8.计算属性

**计算属性：**

1.定义：要用的属性不存在，要通过已有属性计算得来

2.原理：底层借助了Object.defineproperty方法提供的getter和setter

3.get函数什么时候执行？

（1）初次读取时会执行一次

（2）当依赖的数据发生变化时会被再次调用

4.优势：与methods实现相比，内部有缓存机制（复用），效率更高，调试方便。

5.备注：

​	1.计算属性最终会出现在vm上，直接读取使用即可

​	2.如果计算属性要被修改，那必须写set函数去响应修改，且set中要引起计算时依赖的数据发生改变。

​	

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <script type="text/javascript" src="../js/vue.js"></script>
</head>
<body>
    <div id ="root">
        姓：<input type="text" v-model="firstname"><br/><br/>
        名：<input type="text" v-model="lastname"><br/><br/>
        测试：<input type="text" v-model="x"><br/><br/>
        姓名：<span>{{fullname}}</span><br/><br/>
        姓名：<span>{{fullname}}</span><br/><br/>
        姓名：<span>{{fullname}}</span><br/><br/>
        姓名：<span>{{fullname}}</span><br/><br/>
        姓名：<span>{{fullname}}</span>
    </div>


<script type="text/javascript">
    const vm = new Vue({
        el:'#root',
        data:{
            firstname:'张',
            lastname:'三',
            x:'你好'
        },
        computed:{
            fullname:{
            //get有什么作用？当有人读取fullname时，get就会被调用，且返回值就作为fullname的值
            //get什么时候调用？1.初次读取fullname时2.所依赖的数据发生变化时
            get() {
                console.log('get被调用')
                //console.log(this)//此处的this=vm
                return this.firstname +'-'+ this.lastname
            },
            //set什么时候调用？当fullName被修改时
            set(value){
                console.log('set被调用',value)    
                const arr = value.split('-')
                this.firstname = arr[0]
                this.lastname = arr[1]
            } 
            }
        }
        
    })
</script> 
</body>
</html>
```



#### 9.监视属性

##### 1.监视属性watch:

1.当被监视的属性变化时，回调函数自动调用，进行相关操作

2.监视的属性必须存在，才能进行监视

3.监视的两种写法;

（1）new Vue时传入watch配置

（2）通过vm.$watch监视

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <script type="text/javascript" src="../js/vue.js"></script>
</head>
<body>
    <div id ="root">
    <h2>今天天气很{{info}}</h2>   
    <button @click="cw">切换天气</button>
    </div>


<script type="text/javascript">
    const vm = new Vue({
        el:'#root',
        data:{
            isHot:true,
        },
        computed:{
            info(){
                return this.isHot ?'炎热':'凉爽'
            }
        },
        methods: {
            cw(){
                this.isHot = ! this.isHot
            }
        },
        //监视的两个方法
        // watch:{
        //     isHot:{
        //     immediate:true,//初始化时让handler调用一下
        //     //handler什么时候调用？当isHot发生改变时。
        //     handler(newvalue,oldvalue){
        //         console.log('info被修改了',newvalue,oldvalue)
        //     }    
        //     }
        // }

    })
    vm.$watch('isHot',{
        immediate:true,//初始化时让handler调用一下
            //handler什么时候调用？当isHot发生改变时。
            handler(newvalue,oldvalue){
                console.log('info被修改了',newvalue,oldvalue)
            } 

    })
</script> 
</body>
</html>
```



##### 2.深度监视

**要点：**

（1）Vue中的watch默认不监测对象内部值的改变（一层）

（2）配置deep:true可以监测对象内部值改变（多层）

**注：**

（1）Vue自身可以监测对象内部值的改变，但Vue提供的watch默认不可以

（2）使用watch时根据数据的具体结构。决定是否采用深度监测

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <script type="text/javascript" src="../js/vue.js"></script>
</head>
<body>
    <div id ="root">
    <h2>今天天气很{{info}}</h2>   
    <button @click="cw">切换天气</button>
    <hr/>
    <h3>a的值是:{{numbers.a}}</h3>
    <button @click="numbers.a++">点我让a+1</button>
    <h3>a的值是:{{numbers.b}}</h3>
    <button @click="numbers.b++">点我让b+1</button>
    <button @click="numbers = {a:666,b:888}">彻底更换numbers</button>
    </div>


<script type="text/javascript">
    const vm = new Vue({
        el:'#root',
        data:{
            isHot:true,
            numbers:{
             a:1,
             b:1  
            }
        },
        computed:{
            info(){
                return this.isHot ?'炎热':'凉爽'
            }
        },
        methods: {
            cw(){
                this.isHot = ! this.isHot
            }
        },
        //监视有两个方法
        //方法一
        watch:{
            isHot:{
            immediate:true,//初始化时让handler调用一下
            //handler什么时候调用？当isHot发生改变时。
            handler(newvalue,oldvalue){
                console.log('info被修改了',newvalue,oldvalue)
            }
        }, 
            // 监视多级结构中某个属性的变化  
            'numbers.a':{
                deep:true,
                handler(){
                    console.log('a被改变了')
                }
            }
        }
        
        //监视多级结构中所有属性的变化
        // numbers:{
        //         deep:true,
        //         handler(){
        //             console.log('numbers中有属性被改变了')
        //         }
        //     }   
        // }
        

    })
</script> 
</body>
</html>
```



##### 3.监视属性_简写

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <script type="text/javascript" src="../js/vue.js"></script>
</head>
<body>
    <div id ="root">
    <h2>今天天气很{{info}}</h2>   
    <button @click="cw">切换天气</button>
    </div>


<script type="text/javascript">
    const vm = new Vue({
        el:'#root',
        data:{
            isHot:true,
        },
        computed:{
            info(){
                return this.isHot ?'炎热':'凉爽'
            }
        },
        methods: {
            cw(){
                this.isHot = ! this.isHot
            }
        },
        //监视有两个方法
        //方法一
        watch:{
            // isHot:{
            // //正常写法
            // immediate:true,//初始化时让handler调用一下
            // //handler什么时候调用？当isHot发生改变时。
            // //deep:true ,//深度监视
            // handler(newvalue,oldvalue){
            //     console.log('info被修改了',newvalue,oldvalue)
            //         }
            //     }
        //简写
        // isHot(newvalue,oldvalue){
        //     console.log("isHot被修改",newvalue,oldvalue)
        // }
        }})
        //正常写法
        // vm.$watch('isHot',{immediate:true,//初始化时让handler调用一下
        //     // //handler什么时候调用？当isHot发生改变时。
        //     // //deep:true ,//深度监视
        //      handler(newvalue,oldvalue){
        //          console.log('info被修改了',newvalue,oldvalue)
        //              }
        //          }

        // )
        //简写 
        vm.$watch('isHot',function(newvalue,oldvalue){
            console.log('info被修改了',newvalue,oldvalue)
        })
   
</script> 
</body>
</html>
```



##### 4.计算属性和监视属性的区别（computed和watch）

1.computed能完成的功能，watch都可以完成

2.watch能完成的功能，computed不一定能完成，例如：watch可以进行异步操作



##### **重要原则：**

1.所被vue管理的函数，最好写成普通函数，这样this的指向才是vm或组件实例对象

2.所有不被Vue所管理的函数（定时器的回调函数，ajax的回调函数、promise回调函数等），最好写成箭头函数，这样this的指向才是vm或组件实例对象。



```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>姓名案例_watch实现</title>
    <script type="text/javascript" src="../js/vue.js"></script>
</head>
<body>
    <div id ="root">
        姓：<input type="text" v-model="firstname"><br/><br/>
        名：<input type="text" v-model="lastname"><br/><br/>
        姓名：<span>{{fullname}}</span><br/><br/>
    </div>


<script type="text/javascript">
    const vm = new Vue({
        el:'#root',
        data:{
            firstname:'张',
            lastname:'三',
            fullname:"张-三"//初始值需要自己设定
        },
        watch:{
            firstname(newvalue){
                setTimeout(() => {//这个地方要写成箭头函数，括号里，没写东西，所以就往外找，this就指定为vm。否则指定为Windows，由js引擎帮忙调用
                    this.fullname = newvalue +'-' +this.lastname
                }, 1000);
                 
            },
            lastname(newvalue){
                this.fullname = this.firstname+'-' + newvalue
            },
            
            }
        }

           
        
        
    )
</script> 
</body>
</html>
```



#### 10.绑定样式

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <style>
        .basic{
            width: 400px;
            height: 100px;
            border: 1px solid black;
        }
        .sad{
            border-color: green;
            background-color: gray;
        }
        .happy{
            border-color: red;
            background-color: yellow;
        }
        .normal{
            border-color: blue;
            background-color: brown;
        }
        .chd1{
            font-style: oblique;
        }
        .chd2{
            font-size: 30px;           
        }
        .chd3{
            border-color: skyblue;
        }
    </style>
    <script type="text/javascript" src="../js/vue.js"></script>
</head>
<body>
    <div id ="root">
    <!-- 绑定class样式--字符串写法，适用于：样式的类别不确定，需要动态指定 -->
    <div class="basic" :class="mood" @click="change">{{name}}</div>
    </br></br>
    <!-- 绑定class样式--数组写法，适用于：适用于要样式个数不确定，名字也不确定 -->
    <div class="basic" :class="arr" >{{name}}</div>
    </br></br>
    <!-- 绑定class样式--数组写法，适用于：适用于要绑定样式个数确定，名字也确定，但要动态决定用不用 -->
    <div class="basic" :class="classobj">{{name}}</div>
    </br></br>
    <!-- 绑定style样式--对象写法 -->
    <div class="basic" :style="styleobj">{{name}}</div>
    
    </div>


<script type="text/javascript">
    const vm=new Vue({
        el:'#root',
        data:{
            name:'ccchhhddd',
            mood:"basic",
            arr:['chd1','chd2','chd3'],
            classobj:{
                chd1:false,
                chd2:false,
            },
            styleobj:{
                fontSize:'40px',
                color: 'red',
                backgroundColor:'green'
            }
        },
        methods: {
            change(){
                const arr =['happy','sad','normal']
                const index = Math.floor(Math.random()*3)
                this.mood = arr[index]
            }
            
        },
    })
</script> 
</body>
</html>
```



#### 11.条件渲染

##### **1.v-if**

写法：

（1）v-if="表达式"

（2）v-else-if="表达式"

（3）v-else="表达式"

适用于：切换频率较低的场景

特点：不展示的DOM元素直接被移除

注意：v-if可以和：v-else-if和v-else 一起使用。但要求结构不能被”打断“



##### **2.v-show**

写法：v-show="表达式"

适用于：切换频率较高的场景

特点：不展示的DOM元素未被移除，仅仅是使用样式隐藏掉



##### **3.备注:**

使用v-if的时候，元素可能无法获取到，而使用v-show一定可以获取到

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <script type="text/javascript" src="../js/vue.js"></script>
</head>
<body>
    <div id ="root">
        <h2>当前的n值是:{{n}}</h2>
        <button @click="n++">点我n+1</button>
        <!-- 使用v-show做条件渲染 -->
        <!-- <h2 v-show="false">欢迎来到{{name}}</h2>     -->

        <!-- 使用v-if做条件渲染 -->
        <!-- <h2 v-if="false">欢迎来到{{name}}</h2> -->

        <!-- 注意： v-if和v-else-if这组结构中间不允许被打断 -->
        <div v-if="n===1">angular</div>
        <div v-else-if="n===2">react</div>
        <div v-else-if="n===3">Vue</div>
        <div v-else>hhh</div>
        

        <!-- v-if和template的配合使用（不能和v-show） -->
        <template v-if="n===1">
            <h2>你好</h2>
            <h2>chd</h2>
            <h2>hhh</h2>
        </template>

    </div>


<script type="text/javascript">
    new Vue({
        el:'#root',
        data:{
            name:'chd',
            n:0
        }
    })
</script> 
</body>
</html>
```



#### 12.列表渲染

##### 1.基本列表

###### v-for指令：

1.用于展示列表数据

2.语法：v-for="(item,index) in xxx" :key='yyy'

3.可遍历：数组、对象、字符串、指定次数

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <script type="text/javascript" src="../js/vue.js"></script>
</head>
<body>
    <div id ="root">
        <!-- 遍历数组(用的最多) -->
    <h2>人员列表</h2>
    <ul>
        <li v-for="(p,index) of persons" :key="index">
            {{p.name}}-{{p.age}}
        </li>
    </ul>

    <!-- 遍历对象 -->
    <h2>汽车信息</h2>
    <ul>
        <li v-for="(value,k) of car" :key="k">
            {{k}}-{{value}}
        </li>
    </ul>
    
    <!-- 遍历字符串 -->
    <h2>测试遍历字符串</h2>
    <ul>
        <li v-for="(char,index) of str" :key="index">
            {{index}}-{{char}}
        </li>
    </ul>

    <!-- 遍历指定次数 -->
    <h2>测试遍历字符串</h2>
    <ul>
        <li v-for="(number,index) of 5" :key="index">
            {{index}}-{{number}}
        </li>
    </ul>
    </div>


<script type="text/javascript">
    new Vue({
        el:'#root',
        data:{
            persons:[
                {id:"001",name:'张三',age:18},
                {id:'002',name:'李四',age:19},
                {id:'003',name:'王五',age:20}
            ],
            car:{
                name:'奥迪A8',
                price:'70万',
                color:'red'
            },
            str:'hello'

        }
    })
</script> 
</body>
</html>
```





##### 2.Vue面试重点题：vue中的key有什么作用？（key的内部原理）

###### 1.虚拟DOM中key的作用：

​		key是虚拟DOM对象的标识，当状态中的数据发生变化时，Vue会根据【新数据】生成【新的虚拟DOM】，随后Vue进行【新虚拟DOM】与【旧虚拟DOM】的差异比较，比较规则如下：



###### 2.对比规则;

(1)旧虚拟DOM 中找到了与新虚拟DOM相同的key:

​		1)若虚拟DOM中的内容没变，直接使用之前的真实DOM

​		2）若虚拟DOM中内容变了，则生成新的真实DOM，随后替换掉页面中之前的真实DOM

（2）旧虚拟DOM中未找到与新虚拟DOM相同的key:

​		创建新的真实DOM，随后渲染到页面



###### 3.用index作为key可能会引发的问题：

​		1）若对数据进行：逆序添加、逆序删除等破坏顺序操作：

​					会产生没有必要的真实DOM更新===》 界面效果没问题，但效率低



​		2）如果结构中还包含输入类的DOM：

​				会产生错误DOM更新 ===》界面有问题



###### 4.开发中如何选择key?

​		1.最好使用每条数据的唯一标识作为key,比如 id、手机号、身份证号、学号等唯一标识

​		2.如果不存在对数据的逆序添加、逆序删除等破坏顺序操作，仅用于渲染列表用于展示，使用index作为key是没有问题的。



##### 3.列表过滤

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>列表过滤</title>
    <script type="text/javascript" src="../js/vue.js"></script>
</head>
<body>
    <div id ="root">
    <h2>人员列表</h2>
    <input type="text" placeholder="输入名字" v-model="keyword">
    <ul>
        <li v-for="(p,index) of filPersons" :key="index">
            {{p.name}}-{{p.age}}-{{p.sex}}
        </li>
    </ul>
    </div>

   


<script type="text/javascript">
    // 用watch实现
    // new Vue({
    //     el:'#root',
    //     data:{
    //         keyword:'',
    //         persons:[
    //             {id:"001",name:'马冬梅',age:19,sex:'女'},
    //             {id:'002',name:'周冬雨',age:20,sex:'女'},
    //             {id:'003',name:'周杰伦',age:21,sex:'男'},
    //             {id:'004',name:'温兆伦',age:22,sex:'男'},
    //         ],
    //         filPersons:[]

    //     },
    //     watch:{
    //         keyword:{
    //             immediate:true,
    //             handler(val){
    //                 this.filPersons = this.persons.filter((p)=>{
    //                 return p.name.indexOf(val) !==-1
    //             })
                
    //         }
    //         }
    //     }
    // })

    new Vue({
        el:'#root',
        data:{
            keyword:'',
            persons:[
                {id:"001",name:'马冬梅',age:19,sex:'女'},
                {id:'002',name:'周冬雨',age:20,sex:'女'},
                {id:'003',name:'周杰伦',age:21,sex:'男'},
                {id:'004',name:'温兆伦',age:22,sex:'男'},
             ],
        },
        computed:{
            filPersons(){
               return this.persons.filter((p)=>{
                 return p.name.indexOf(this.keyword) !==-1   
                })
            }
        }          
        }
    )
</script> 
</body>
</html>

```



##### 4.列表排序

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>列表过滤</title>
    <script type="text/javascript" src="../js/vue.js"></script>
</head>
<body>
    <div id ="root">
    <h2>人员列表</h2>
    <input type="text" placeholder="输入名字" v-model="keyword">
    <button @click="sortType=2">年龄升序</button>
    <button @click="sortType=1">年龄降序</button>
    <button @click="sortType=0">原顺序</button>
    <ul>
        <li v-for="(p,index) of filPersons" :key="p.id">
            {{p.name}}-{{p.age}}-{{p.sex}}
        </li>
    </ul>
    </div>

   


<script type="text/javascript">
// 列表排序用computed实现
    new Vue({
        el:'#root',
        data:{
            keyword:'',
            sortType:0,//0原顺序，1降序，2升序
            persons:[
                {id:"001",name:'马冬梅',age:12,sex:'女'},
                {id:'002',name:'周冬雨',age:11,sex:'女'},
                {id:'003',name:'周杰伦',age:28,sex:'男'},
                {id:'004',name:'温兆伦',age:50,sex:'男'},
             ],
        },
        computed:{
            filPersons(){
               const arr= this.persons.filter((p)=>{
                 return p.name.indexOf(this.keyword) !==-1   
                })

                if(this.sortType){
                    arr.sort((p1,p2)=>{
                        return this.sortType ===1 ? p2.age-p1.age :p1.age-p2.age
                    })
                }

                return arr
            }
        }          
        }
    )
</script> 
</body>
</html>

```



##### 5.vue监测数据改变的原理



data里的每一项数据（包括细分的数据）都有对应的getter和setter,以这样的方式实现数据的监测和修改

**如下图所示：**



```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <script type="text/javascript" src="../js/vue.js"></script>
</head>
<body>
    <div id ="root">
    <h2>学校名称：{{name}}</h2>
    <h2>学校地址：{{address}}</h2>
    </div>
   
<script type="text/javascript">
// 列表排序用computed实现
    const vm =new Vue({
        el:'#root',
        data:{
            name:'chd',
            address:"beijing",
            student:{
                name:'tom',
                age:{
                    sage:20,
                    tage:18
                }
            }            
        },               
        }
    )
</script> 
</body>
</html>

```



##### 6.Vue.set的使用

**用法**：

向响应式对象中添加一个 property，并确保这个新 property 同样是响应式的，且触发视图更新。它必须用于向响应式对象上添加新 property，因为 Vue 无法探测普通的新增 property

 (比如 `this.myObject.newProperty = 'hi'`)

**注意：**

对象不能是 Vue 实例，或者 Vue 实例的根数据对象。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <script type="text/javascript" src="../js/vue.js"></script>
</head>
<body>
    <div id ="root">
    <h2>学校名称：{{name}}</h2>
    <h2>学校地址：{{address}}</h2>
    <hr/>
    <h1>学生信息</h1>
    <button @click="addsex">添加一个性别信息</button>
    <h2>学生姓名：{{student.name}}</h2>
    <h2>学生年龄：真实{{student.age.rage}},对外{{student.age.sage}}</h2>
    <h2 v-if="student.sex">性别:{{student.sex}}</h2>
    <h2>朋友们</h2>
    <ul>
        <li v-for="(f,index) in student.friends" :key="index">
            {{f.name}}---{{f.age}}
        </li>
    </div>
   
<script type="text/javascript">
// 列表排序用computed实现
    const vm =new Vue({
        el:'#root',
        data:{
            name:'chd',
            address:"beijing",
            student:{
                name:'tom',
                age:{
                    sage:20,
                    rage:18
                },
                friends:[
                    {name:'eecc',age:30},
                    {name:'eveve',age:14}
                ]

                
            }            
        },
        methods: {
            addsex(){
                Vue.set(this.student,'sex','男')
                // this.$set(this.student,'sex','男')
            }
        },               
        }
    )
</script> 
</body>
</html>
```



##### 7.Vue监测数据改变的原理

Vue 将被侦听的数组的变更方法进行了**包裹**，所以它们也将会触发视图更新。这些被包裹过的方法包括：

- `push()`	
- `pop()`
- `shift()`
- `unshift()`
- `splice()`
- `sort()`
- `reverse()`

你可以打开控制台，然后对前面例子的 `items` 数组尝试调用变更方法。比如 `example1.items.push({ message: 'Baz' })`



##### 8.总结Vue数据监测

Vue监视数据的原理：

**1.Vue会监视data中所有层次的数据**

**2.如何监测对象的数据？**

​	通过setter实现监视，且要在new Vue时就传入要检测的数据

（1）对象中后追加的属性，Vue默认不做响应式处理

（2）如需给后添加的属性做响应式，请使用如下API:
			Vue.set(targer,propertyName,value)或

​			vm.$set(target,propertyName/index,value)



**3.如何监测数组中的数据？**

​		通过包裹数组更新元素的方法实现，本质就是做了两件事：

​	（1）调用原生对应的方法对数组进行更新

​	（2）重新解析模版，进行更新页面



**4.在Vue修改数组中的某个元素一定要用如下方法：**

​	（1）使用这些API：push()  、pop() 、shift()  、unshift()  、splice()

​		(2)Vue.set()  或 vm.$set()



**注意：**Vue.set() 和vm.$set() 不能给vm或vm的根数据对象 添加属性！！！

```vue
spilce() 的一个用法
this.student.hobby.splice(0,1,'xc')
//Vue.set(this.student.hobby.0,'xc')
//this.$set(this.student.hobby,0,'xc')
```



#### 13.收集表单数据

**若：<input type='text'/>**则v-model收集的是value值。用户输入就是value的值

**若：<input type='radio'/>**,则v-model收集的是value值，且要给标签配置value值

**若：<input type='checkbox'/>**

​	1.没有配置input的value属性，那么收集的就是checked（勾选 or 未勾选，是bool值）

​	2.v-model 的初始值是数组，那么收集的是value组成的数组

**备注：v-model的三个修饰符：**

​	lazy:失去焦点再收集数据

​	number:输入字符串转为有效数字

​	trim:输入收尾空格过滤

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <script type="text/javascript" src="../js/vue.js"></script>
</head>
<body>
    <div id ="root">
      <form @submit.prevent="demo">
        
        账号：<input type="text" v-model.trim="userInfo.account"><br/><br/>
        密码：<input type="password" v-model="userInfo.password"><br/><br/>
        年龄：<input type="number" v-model.number="userInfo.age"><br/><br/>
        性别：
        男<input type="radio" name="sex" v-model="userInfo.sex" value="male">
        女<input type="radio" name="sex" v-model="userInfo.sex" value="female"><br/><br/>
        爱好：
        学习<input type="checkbox" v-model="userInfo.hobby" value="study">
        打游戏<input type="checkbox" v-model="userInfo.hobby" value="play">
        唱歌<input type="checkbox" v-model="userInfo.hobby" value="sing"><br/><br/>
        所属校区
        <select v-model="userInfo.city">
            <option value="">请选择校区</option>
            <option value="beijing">北京</option>
            <option value="shanghai">上海</option>
            <option value="nanjing">深圳</option>
        </select><br/><br/>
        其他信息： 
        <textarea v-model.lazy="userInfo.other"></textarea><br/><br/>
        <input type="checkbox" v-model="userInfo.agree">阅读并接受<a href="http://www.baidu.com">《用户协议》</a>
        <button>提交</button>
    </form>
    </div>


<script type="text/javascript">
    new Vue({
        el:'#root',
        data:{
            userInfo:{
            account:'',
            password:'',
            sex:'',
            age:'',
            hobby:[],
            city:'',
            other:'',
            agree:''
        }
            
        },
        methods: {
            demo(){
               console.log(JSON.stringify(this.userInfo))
            }
        },
    })
</script> 
</body>
</html>
```



#### 14.过滤器

定义：对要显示的数据进行特定格式化后再显示（适用于一些简单逻辑得处理）

语法:

​	1.注册过滤器： Vue.filter(name,callback) 或 new Vue(filters:{})

​	2.使用过滤器：{{ xxx | 过滤器名}}  或 v-bind: 属性 = ‘xxx |过滤器名’

备注：

​	1.过滤器也可以接受额外参数，多个过滤器也可以串联

​	2.并没有改变原本的数据，是产生新的对应的数据



```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <script type="text/javascript" src="../js/vue.js"></script>
    <script type="text/javascript" src="../js/cdn.bootcdn.net_ajax_libs_dayjs_1.11.7_dayjs.min.js"></script>
</head>
<body>
    <div id ="root">
    <h2>显示格式化后的时间</h2> 
     <!--计算属性实现  -->
    <h3> 1现在是:{{fmtTime}}</h3>
    
    <!--methods实现 -->
    <h3> 2现在是:{{getfmtTime()}}</h3>

    <!--过滤器实现 -->
    <h3> 3现在是:{{time | timeFormater}}</h3>

    <!--过滤器实现(传参+串联) -->
    <h3> 4现在是:{{time | timeFormater('YYYY-MM-DD') | mySlice}}</h3>
    </div>


<script type="text/javascript">
    //全局过滤器
    // Vue.filters('mySlice',function(value){
    //     return value.slice(0,4)
    // })
    new Vue({
        el:'#root',
        data:{
            time:1621561377603,//时间戳
        },
        computed:{
            fmtTime(){
                return dayjs(this.time).format('YYYY-MM-DD HH:mm:ss')
            }
        },
        methods: {
            getfmtTime(){
                return dayjs(this.time).format('YYYY年MM月DD日 HH:mm:ss')
            }
        },
        //局部的过滤器
        filters:{
            timeFormater(value,str='YYYY年MM月DD日 HH:mm:ss'){
                return dayjs(value).format(str)
            },
            mySlice(value){
                return value.slice(0,4)
            }
        }
    }            
    )
</script> 
</body>
</html>
```



#### 15.内置指令

**v-bind :** 单向绑定解析表达式，可简写为： xxx

**v-model :** 双向数据绑定

**v-for :** 遍历数组/对象/字符串

**v-on ：** 绑定事件监听，可简写为@

**v-if :** 条件渲染（动态控制节点是否存在）

**v-else :** 条件渲染（动态控制节点是否存在）

**v-show :** 条件渲染（动态控制节点是否展示）



**v-text指令：**

​	1.作用：向其所在的节点中渲染文本内容

​	2.与差值语法的区别：v-text会替换掉节点中的内容，{{xx}}不会



**v-html指令：**

1.作用：向指定节点中渲染包含html结构的内容

2.与差值语法的区别：

​	（1）v-html会替换掉节点中所有的内容，{{xx}}不会

​	（2）v-html可以识别html结构

3.严重注意：v-html有安全性问题

​	（1）在网站上动态渲染任意html是非常危险的，容易导致XSS攻击

​	（2）一定要在可信的内容上使用v-html。永远不要在用户提交的内容上用v-html



**补充cookie:**



**v-clock指令**（没有值）：

​	1.本质是一个特殊属性，Vue实例创建完毕并接管容器后，会删掉v-clock属性

​	2.使用css配合v-cloak可以解决网速慢时页面展示出{{xxx}}的问题。

**v-once指令：**

​	1.v-once所在节点在初次渲染后，被视为静态内容了

​	2.以后数据的改变不会引起v-once所在结构的更新，可以用于优化性能

**v-pre指令：**

​	1.跳过其所在节点的编译过程

​	2.可利用它跳过：没有使用指令语法、没有使用插值语法的节点，会加快编译



#### 16.自定义指令

总结：

一、定义语法：

（1）局部指令：

​		new Vue({

​	directives:{指令名：配置对象}

})

或

new Vue({

​	directives{指令名：回调函数}

})

（2）全局指令

​	Vue.directive{指令名，配置对象） 或Vue.directive(指令名，回调函数)



二、配置对象中常用的3个回调：

​		（1）bind:指令与元素成功绑定时调用

​		（2）inserted:指令所在元素被插入页面时调用

​		（3）update:指令所在模版结构被重新解析时调用



三、备注：

​		1.指令定义时不加v-,但使用时要加v-;

​		2.指令名如果是多个单词，要使用kebab-case命名方式，不要用camelCase命名（驼峰命名法）。



```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <script type="text/javascript" src="../js/vue.js"></script>
</head>
<body>
    <!-- 需求1：定义一个v-big指令，和v-text功能类似，但会把绑定的数值放大10倍
         需求2：定义一个v-fbind指令，和v-bind功能类似，但可以让其所绑定的input元素默认获取焦点。 -->
    <div id ="root">
     <h2>当前的n值是:<span v-text="n"></span></h2>
     <h2>放大10倍后的n值是:<span v-big="n"></span></h2>
     <button @click="n++">点我n+1</button>
     <hr/>
     <input type="text" v-fbind:value="n">
    </div>


<script type="text/javascript">
    new Vue({
        el:'#root',
        data:{
            n:1,
        },
        directives:{
            //big函数何时会被调用？1.指令与元素成功绑定时（一上来）2.指令所在的模版被重新解析时
            big(element,binding){
                element.innerText = binding.value*10
                //console.log(element,binding.value)
            },
            fbind:{
                //指令与元素成功绑定时（一上来）
               bind(element,binding){
                element.value =binding.value
               },
               //指令所在元素被插入页面时
                inserted(element,binding){
                    element.focus()
                },
                //指令所在的模版被重新解析时
                update(element,binding){
                    element.value =binding.value 
                },
            }
            }
        }
    
            
    )
</script> 
</body>
</html>
```

#### 17.生命周期

**生命周期：**

1.又名：生命周期回调函数、生命周期函数、生命周期钩子

2.是什么：Vue在关键时刻帮助我们调用的一些特殊名称的函数

3.生命周期函数的名字不可更改，但函数的具体内容是程序员根据需求编写的

4.生命周期函数中的this指向是vm或组件实例对象	



**常用的生命周期钩子：**

1.mounted:发送ajax请求、启动定时器、绑定自定义事件、订阅消息等【初始化操作】

2.beforeDestroy:清除定时器、解绑自定义事件、取消订阅消息等【收尾工作】



**关于销毁Vue实例：**

1.销毁后借助Vue开发者工具看不到任何信息

2.销毁后自定义事件会失效，但原生DOM事件依然有效

3.一般不会在beforeDestroy操作数据，因为即便操作数据，也不会再触发更新流程了。





**图示：**

![Vue 实例生命周期](https://v2.cn.vuejs.org/images/lifecycle.png)

#### 18.组件化编程

##### **1.Vue中使用组件的三大步骤：**

1.定义组件（创建组件）

2.注册组件

3.使用组件



##### **一、如何定义一个组件？**

使用Vue.extend(options)创建，其中options和new Vue(options)时传入的那个options几乎一样，但区别如下：

1.el不要写，为什么？

——最终所有的组件都要经过一个vm的管理，由vm中的el决定服务哪个容器

2.data必须写成函数，为什么？

——避免组件被复用，数据存在引用关系

备注：使用template可以配置组件结构



##### **二、如何注册组件？**

1.局部注册：靠new Vue的时候传入components选项

2.全局注册：靠Vue.component('组件名'，组件)



##### **三、编写注册组件：**

<school></school>



**1.基本使用.html**

```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <script type="text/javascript" src="../js/vue.js"></script>
</head>
<body>
    <!-- 准备好一个容器 -->
    <div id ="root">
   <!-- 第三步:编写组件标签 -->
    <school></school>
     <hr>
    <student></student>
    </div>


<script type="text/javascript">
    //第一步：创建school组件
    const a =Vue.extend({
        //el:'#root',  //组件定义时，不要写el配置顶，因为最终所有的组件都要被一个vm管理
        template:`
        <div>
        <h2>学校名称：{{schoolname}}</h2>
        <h2>学校地址：{{address}}</h2>
        <button @click='showname'>点我提示学校名</button>
        </div>
        `,
        data(){//函数式
            return{
            schoolname:'jiaoda',
            address:'xian', 
            }},
            methods: {
                showname(){
                    alert(this.schoolname)
                }
            },

        }
    )
    //第二步：创建student组件
    const b =Vue.extend({
        
        //el:'#root',  //组件定义时，不要写el配置顶，因为最终所有的组件都要被一个vm管理
        template:`
        <div>
        <h2>学生姓名：{{name}}</h2>
        <h2>学生年龄：{{age}}</h2>
        </div>
        `,
        data(){
            return{
            name:'chd',
            age:20, 
            }}     
        }
    )


    //创建vm
    new Vue({
        el:'#root',
        //第二步：注册组件（局部注册）
        components:{
            school:a,//组件名在这里定
            student:b
        }  }            
    )
</script> 
</body>
</html>
```



##### 2.几个注意的要点

**1.关于组件名：**

一个单词组成：

​	第一种写法（首字母小写）：school

​	第二种写法（首字母大写）：School

多个单词组成：

​	第一种写法（kebab-case命名）：my-school

​	第二种写法（CamelCase命名）：MySchool(需要Vue脚手架支持)

备注:

​	(1)组件名尽可能回避HTML中已有的元素名称，例如：h2、H2都不行

（2）可以使用name配置项指定组件在开发者工具中呈现的名字



**2.关于组件标签**

​	第一种写法：<school></school>

​	第二种写法：<school/>

​	备注：不用使用脚手架时，<school/>会导致后续组件不能渲染。



**3.一个简写方式：**

 const school =Vue.extend(options) 可简写为：const school = options



##### 3.VueComponent

 关于VueComponent:

​	1.school组件本质是一个名为VueComponent的构造函数，且不是程序员定义的，是Vue.extend生成的。

​	2.我们只需要写<school/>或<school></school>，Vue解析时会帮我们创建school组件的实例对象，即Vue帮我们执行的：new VueComponent(options)

​	3.特别注意：每次调用Vue.extend,返回的都是一个全新的VueComponent !!!

​	4.关于this指向：

​		(1)组件配置中：

​				data函数、methods中的函数、watch中的函数、computed中的函数 它们的this均是【VueComponent实例对象】

​	（2）new Vue(options)配置中：

​			data函数、methods中的函数、watch中的函数、computed中的函数 它们的this均是【Vue实例对象】

​	5.VueComponent的实例对象、以后简称vc（也可称之为：组件实例对象）

Vue的实例对象，以后简称vm

​	6.因为组件是可复用的 Vue 实例，所以它们与 `new Vue` 接收相同的选项，例如 `data`、`computed`、`watch`、`methods` 以及生命周期钩子等。仅有的例外是像 `el` 这样根实例特有的选项。（vm和vc的异同）



##### 4.一个重要的内置关系

1.一个重要的内置关系：VueComponent.prototype.**proto** ===Vue.prototype

2.为什么要有这个关系：让组件实例对象（vc）可以访问到Vue原型上的属性、方法



```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <script type="text/javascript" src="../js/vue.js"></script>
</head>
<body>
    <!-- 准备好一个容器 -->
    <div id ="root">
    <school></school>
    </div>
</body>

<script type="text/javascript">
    Vue.prototype.x=99//得益于VueComponent.prototype.__proto__ === Vue.prototype这个内置重要关系
   const school =Vue.extend({
        name:'school',
        //el:'#root',  //组件定义时，不要写el配置顶，因为最终所有的组件都要被一个vm管理
        template:`
        <div>
        <h2>学校名称：{{schoolname}}</h2>
        <h2>学校地址：{{address}}</h2>
        <button @click='showX'>点我输出X</button>  
        </div>
        `,
        data(){//函数式
            return{
            schoolname:'jiaoda',
            address:'xian', 
            }},
        methods: {
            showX(){
            console.log(this.x)
            },
        },
    })
   const vm=new Vue({
    el:'#root',
    data:{
        msg:'你好'
    },
    components:{
        school
    }
   })
   //console.log(school.prototype.__proto__ === Vue.prototype)
    // function Demo(){
    //     this.a=1
    //     this.b=2
    // }
    // //创建一个Demo的实例对象
    // const d= new Demo()
    
    // console.log(Demo.prototype) //显示原型属性
    // console.log(d.__proto__)//隐式原型属性

    // //程序员通过显示原型属性操作原型对象，追加一个x属性，值为99
    // Demo.prototype.x = 99

    // console.log('@',d)

</script> 

</html>
```

### 2.使用Vue脚手架

#### 1.单文件组件+脚手架简介+相关函数+相关配置

xxxxx.Vue

**1.webpack**

**2.脚手架  Vue CLI  动能：浏览器不能直接识别并运行Vue文件，需要通过脚手架的环境配置的支持**

1. Vue 脚手架是 Vue 官方提供的标准化开发工具（开发平台）。
2. 最新的版本是 4.x。
3. 文档: https://cli.vuejs.org/zh/

**3.模版目录框架**

├── node_modules

 ├── public 

│ ├── favicon.ico: 页签图标

 │ └── index.html: 主页面

 ├── src

 │ ├── assets: 存放静态资源 

│ │└── logo.png 

│ │── component: 存放组件

 │ │ └── HelloWorld.vue

 │ │── App.vue: 汇总所有组件

 │ │── main.js: 入口文件

 ├── .gitignore: git 版本管制忽略的配置

 ├── babel.config.js: babel 的配置文件

 ├── package.json: 应用包配置文件

 ├── README.md: 应用描述文件

 ├── package-lock.json：包版本控制文件



**4.render函数**

关于不同版本的Vue：

​	1.vue.js与vue.runtime.xxx.js的区别：

​		（1）vue.js是完整版的Vue  包含：核心功能+模版解析器

​		（2） vue.runtime.xxx.js是运行版的Vue ,只包含：核心功能，没有模版解析器

​	2.因为vue.runtime.xxx.js没有模版解析器，所以不能使用template配置项，需要使用render函数接收到的createElement函数去指定具体内容。

```
main.js文件
//该文件是整个项目的入口文件
//引入Vue（注意：这里引入的vue只是大的文件夹，并没有指定到核心的vue.js，所以仍需要在下方引入render函数，做模版解析）
import Vue from 'vue'
//引入App组件，它是所有组件的父组件
import App from './App.vue'
//关闭Vue的生产提示
Vue.config.productionTip = false

// 创建Vue的实例对象---vm
new Vue({
  el:'#app',
  // 完成功能：将App组件放入容器中
  render: h => h(App),  //render函数只用在这里写一遍
})

```

**5.vue.config.js配置文件**

使用vue inspect  > output.js 可以查看到Vue脚手架的默认配置

使用vue.config.js可以对脚手架进行**个性化定制**，详情见：https://cli.vuejs.org/zh/config/#vue-config-js



**6.ref属性**

1.被用来给元素或子组件注册引用信息（id的替代者）

2.应用在html标签上获取的是真实DOM元素，应用在组件标签上是组件实例对象（vc）

3.使用方式：

​		打标识：<h1 ref='xxx'>.....</h1>或<School ref='xxx'></SChool>

​		获取：this.$refs.xxx



**7.配置项props**

​	功能：让组件接收外部传来的数据

​		（1）传递数据：

​			<Demo name ='xxx'/>

​		（2）接收数据：

​			第一种方式（只接收）：		

```
 props:['name','age','sex']//简单声明接收。 这里写了，data里就不能有了 
```

​			第二种方式（限制类型）：		

```
// 接收的同时对数据进行类型限制
        // props:{
        //     name:String,
        //     age:Number,
        //     sex:String
        // }
```

​				第三种方式（限制类型、限制必要性、指定默认值）：		

```
props:{
            name:{
                type:String, //name的类型是字符串
                required:true //name是必要的
            },
            age:{
                type:Number,
                default:99 //默认值
            },
            sex:{
                type:String,
                require:true
            }
        }
```

**备注：**props是只读的，Vue底层会监测你对props的修改，如果进行了修改，就会发出警告，若业务需求确实需要修改，那么请复制props的内容到data中一份，然后去修改data中的数据。

如下是一个名叫Student.vue的文件例子

```
<template>
        <div>
        <h1>{{ msg }}</h1>
        <h2>学生姓名：{{name}}</h2>
        <h2>学生年龄：{{Myage}}</h2>
        <button @click="chageage">点我年龄++</button>
        <h2>学生性别：{{sex}}</h2>
        </div>       
</template>

<script>

    export default {
        name:'MyStudent',   
        data(){//函数式
            return{
            msg:'我是一名学生',
            Myage:this.age//这里利用的是props的优先级比data高实现的，也就是说程序先去扫描props里的数据。
            
            }},
            methods:{
                chageage(){
                    this.Myage++
                }
            },
        // props:['name','age','sex']//简单声明接收。 这里写了，data里就不能有了  

        // 接收的同时对数据进行类型限制
        // props:{
        //     name:String,
        //     age:Number,
        //     sex:String
        // }

        // 接收的同时对数据：进行类型限制+默认值的指定+必要性的限制
        props:{
            name:{
                type:String, //name的类型是字符串
                required:true //name是必要的
            },
            age:{
                type:Number,
                default:99 //默认值
            },
            sex:{
                type:String,
                require:true
            }
        }}
</script>

<style>
</style>
```

**8.mixin(混入)**

**功能：**可以把多个组件共用的配置提取成一个混入对象

**使用方法：**

​		第一步定义混合，例如：

{

data(){....},

methods:{....}

....

}

​	第二步使用混入，例如：

（1）全局混入：Vue.mixin(xxx)

（2）局部混入：mixins:['xxx']





**9.插件**

**功能：**用于增强Vue

**本质：**包含install方法的一个对象，install的第一个参数是Vue,第二个以后得参数是插件使用者传递的数据

**定义插件：**

```
export default{
    install(Vue,x,y,z){
        console.log(x,y,z)

    //全局过滤器
    Vue.filter('mySlice',function(value){
        return value.slice(0,4)
    })
    //定义全局指令
    Vue.directive('fbind',{
        //指令与元素成功绑定时（一上来）
        bind(element,binding){
            element.value = binding.value
        },
    //指令所在元素被插入页面时
    inserted(element){
        element.focus()
    },
    //指令所在的模版被重新解析时
    update(element,binding){
        element.value = binding.value
    }
    })

    //定义混入
    Vue.mixin({
        data(){
            return{
                x:100,
                y:200
            }
        }
    })
    //给Vue原型上添加一个方法
    Vue.prototype.hello = ()=>{alert('nihaoya')}
    //添加实例方法
    Vue.prototype.$myMethod = function(){...}
    Vue.prototype.$myProperty = xxxx
}
}

```

**使用插件：**Vue.use()



#### 2.scoped样式

作用：让样式在局部生效，防止冲突

写法：<style scoped>

```
<template>
        <div class="demo">
        <h2>学生姓名：{{name}}</h2>
        <h2 class="qwe">学生性别：{{sex}}</h2>
        
        </div>       
</template>

<script>    
    export default {
        name:'MyStudent',  
        data(){//函数式
            return{
            name:'cccchhhhddd',
            sex:'男'
            }},
          
    
        }
</script>

<!-- 要用less 要安装less-loader 指令：npm i less-loader -->
<!-- 用less的好处：可以嵌套着写 -->
<style lang="less" scoped>
// 不写lang就默认是CSS
/* 加入scoped .demo就不担心存在重复的情况了,但此时demo只能在School组件里使用 */
.demo{
  background-color:pink;
  .qwe{
    font-size:40px;
  }
}
</style>
```



#### 3.Todo-list案例

**组件化编码流程（通用）**

 1.实现静态组件：抽取组件，使用组件实现静态页面效果 

2.展示动态数据： 2.1. 数据的类型、名称是什么？ 2.2. 数据保存在哪个组件？ 

3.交互——从绑定事件监听开始



**注：**父亲给儿子可以传函数、数组.....在此基础上儿子调用先前父亲给儿子传的函数方法，儿子也可以给父亲传数据



##### **总结todolist案例：**

##### 1.组件化编码流程：

​	（1）拆分静态组件：组件要按照功能点拆分，命名不要与html元素冲突。

​	（2）实现动态组件：考虑好数据的存放位置，数据是一个组件在用，还是一些组件在用：

​			1）一个组件再用：放在组件自身即可。

​			2)一些组件在用，放在他们共同的父组件上（状态提升）

​	（3）实现交互：从绑定事件开始

##### 2.props适用于：

​	(1)父组件==>子组件 通信

​	(2)子组件===>父组件 通信 （要求父先给子一个函数）

##### 3.使用v-model时要切记：

v-model绑定的值不能是props传过来的值，因为props是不可以修改的！

##### 4.props传过来的若是对象类型的值：

修改对象中的属性时Vue不会报错，但不推荐这样做



#### 4.webStorage（浏览器存储）

1.存储大小一般支持5MB左右（不同浏览器不一样）

2.浏览器通过Window.sessionStorage和Window.localStorage 属性来实现本地存储机制

3.相关API

```
1. xxxxxxStorage.setItem('key','value');
该方法接受一个键和值作为参数，会把键值对添加到存储中，如果建名存在，则更新其对应的值
2.xxxxxxStorage.getItem('person');
该方法接受一个建名作为参数，返回键名对应的值
3.xxxxxxStorage.removeItem('key');
该方法接受一个建名作为参数，并把该建名从存储中删除
4.xxxxxxStorage.clear()
该方法会清空存储中的所有数据
```

4.备注：

```
1.SessionStorage存储的内容会随着浏览器窗口关闭而消失
2.LocalStorage存储的内容，需要手动清除才会消失
3.xxxxxxStorage.getItem(xxxx) 如果xxx对应的value获取不到，那么getItem的返回值是null
4.JSON.parse(null)的结果依然是null
```



#### 5.组件的自定义事件

​	1.一种组件间通信的方式，适用于： 子组件==>父组件

​	2.使用场景：A是父组件，B是子组件，B想给A传数据，那么就要在A中给B绑定自定义事件（事件的回调在A中）

​	3.绑定自定义事件：

​		1.第一种方式，在父组件中：<Demo @atguigu='test'/>  或<Demo v-on:atguigu='test'/>

​		2.第二种方式，在父组件中：

```
<Demo ref='demo'/>
......
mounted(){
this.$refs.xxx.$on('atguigu',this.test)
}
```

​		3.若想让自定义事件只能触发一次，可以使用once修饰符，或$once方法

4.触发自定义事件：this.$emit('atguigu',数据)

5.解绑自定义事件 this.$off('atguigu')

6.组件上也可以绑定原生DOM事件，需要使用native修饰符

7.注意：通过 this.$refs.xxx.$on('atguigu',回调)绑定自定义事件时，回调要么配置在methods中，要么用箭头函数，否则this指向会出问题。【直接用function,this指的是xxx组件】



#### 6.全局事件总线

1.一种组件间通信的方式，适用于任意组件间通信

2.安装全局事件总线：

```
new Vue({
  ......
  boforeCreate(){
    Vue.prototype.$bus = this //安装全局事件总线，$bus就是当前应用的vm
        },
    .....
})
```

3.使用事件总线：

​	1.接受数据：A组件想接收数据，则在A组件中给$bus绑定自定义事件，事件的回调留在A组件自身

```
methods(){
  demo(data){....}
}
......
mounted(){
  this.$bus.$on('xxxx',this.demo)
}
```

​	2.提供数据：this.$bus.$emit('xxxx',数据)

4.最好在beforeDestroy钩子中，用$off去解绑当前组件所用到的事件







**原理图：**




#### 7.消息订阅与发布（pubsub）

1.一种组件间通信的方式，适用于任意组件间通信

2.使用步骤：

​	1.安装pubsub：npm i pubsub-js

​	2.引入： import pubsub from 'pubsub-js'

​	3.接收数据：A组件想接收数据，则在A组件中订阅消息，订阅的回调留在A组件自身

```
methods(){
demo(data){....}
}
......
mounted(){
this.pid = pubsub.subscribe('xxx',this.demo) //订阅消息
}
```

​	4.提供数据： pubsub.publish('xxx',数据)

​	5.最好在beforeDestroy钩子中，用PubSub.unsubscribe(pid)去取消订阅。



**原理图：**




#### 8.nextTick

**1.语法：** this.$nextTick(回调函数)

**2.作用：** 在下一次DOM更新结束后执行其指定的回调

**3.什么时候用：**当改变数据后，要**基于更新后的新DOM进行某些操作时**，要在nextTick所指定的回调函数中执行

```
handleEdit(todo){
        
            if('isEdit'== undefined){
                todo.isEdit = true
            }
            else{
                this.$set(todo,'isEdit',true)
            }
            // 若没有外包一个东西的话，下面这行代码会执行，但是input还未出现，所以并没有显示相应的结果
            // 这是Vue在考虑效率时设置的形式。 异步？
            // $nextTick官方写法:
            this.$nextTick(function(){
                this.$refs.inputtitle.focus()
            })
            //或者 setTimeout(()=>{
            // this.$refs.inputtitle.focus()
            // })
           },
```



#### 9.Vue封装的过度与动画

1.作用：在插入、更新或移除DOM元素时，在合适的时候给元素添加样式类名。

2.图示：


3.写法：

1.准备好样式：

​			元素进入的样式：

​					1.v-enter :进入的起点

​					2.v-enter-active:进入过程中

​					3.v-enter-to:进入的终点

​			元素离开时的样式：

​					1.v-leave:离开的起点

​					2.v-leave-active:离开过程中

​					3.v-leave-to:离开的终点

2.使用<transition>包裹要过度的元素，并配置name属性：

```
<transition name="hello">
  <h1 v-show="isShow">你好啊！</h1>
</transition>
```

3.备注：若有多个元素需要过度，则需要使用：<transition-group>,且每个元素都要指定key值



例子：

```
<template>
  <div>
    <button @click="isShow = !isShow"> 显示/隐藏</button>
    <!--引入第三方动画 -->
    <transition-group
    appear 
    name="animate__animated animate__bounce"  
    enter-active-class="animate__rubberBand"
    leave-active-class="animate__backOutUp"
    >
        <h1 v-show="!isShow" key="1">你好哈哈哈哈！</h1>
        <h1 v-show="isShow" key="2">ccchhhddd</h1>
    </transition-group>
  </div>
</template>

<script>
import 'animate.css'
export default {
    name:'MyTest3',
    data(){
        return{
            isShow:true
        }
    }
}
</script>

<style scoped>
    h1{
        background-color: orange;
    }
     
</style>
```

### 3.Vue中的ajax

#### 1.前端服务器相关文章与视频

##### 1.用Node.js搭建一个简单Web服务器

https://blog.csdn.net/m0_46171043/article/details/132033934

##### 2.【笔记】 node.js - 开启本地服务器，返回json数据

https://blog.csdn.net/LawssssCat/article/details/103459796

##### 3.FeHelper前端助手浏览器插件 chrome插件-Web开发者助手 FeHelper

https://blog.csdn.net/A598853607/article/details/124118482

可以直接在谷歌应用商店里下载

##### 4.【原生Ajax】全面了解xhr的概念与使用

http://www.shouxieziti.cn/29383.html

xhr、jQuery现阶段用的比较少了，随着Vue和react框架的兴起axios用到比较多了

##### 5.尚硅谷Web前端axios入门与源码解析（视频链接）

https://www.bilibili.com/video/BV1wr4y1K7tq/?spm_id_from=333.337.search-card.all.click&vd_source=ab1c31a8db0c1b9114896077df5b64aa



#### 2.解决跨域问题

协议、域名、端口号都对的上即不存在跨域问题

方法1：cors

方法2：jsonp(需要前后端配合，很巧妙)

方法3：配置代理服务器

1.nginx

2.vue-cli(下面用到的)

##### 方法一：在vue.config.js中添加如下配置

```
devServer: {
    proxy: 'http://localhost:5000'
```

说明：

1.优点：配置简单，请求资源时直接发给前端（8080）即可。

2.缺点：不能配置多个代理，不能灵活的控制请求是否走代理

3.工作方式：若按照上述的代理，当请求了前端不存在的资源时，那么该请求会转发给服务器（优先匹配前端资源）



方法二：编写vue.config.js配置具体代理规则：

```
module.exports = defineConfig({
  // 开启代理服务器(方式2)
  devServer: {
    proxy: {
      '/chd': {
        target: 'http://localhost:5000',
        pathRewrite:{'^/chd':''},
        ws: true,//用于支持websocket
        // changeOrigin: true //用于控制请求头中的host值 
      },
      '/demo': {
        target: 'http://localhost:5001',
        pathRewrite:{'^/demo':''},
        // ws: true,//用于支持websocket
        // changeOrigin: true //用于控制请求头中的host值 
      },
    }
  }
    // changeOrigin设置为true时，服务器收到的请求头中的host为：localhost:5000
  // changeOrigin设置为fasle时，服务器收到的请求头中的host为：localhost:8080
  // changeOrigin默认值为true
})

```

说明：

1.优点：可以配置多个代理，且可以灵活的控制请求是否走代理

2.缺点：配置略微繁琐，请求资源时必须加前缀



#### 3.vue_github搜索案例

https://blog.csdn.net/liaoai/article/details/123431352

上面链接里的案例没有用到main.js自身作为$bus的全局事件总线

我后面进行了部分的简化可以省去不少的内容



#### 4.插槽

认识Vue中组件利器-插槽Slot-案例介绍

https://blog.csdn.net/JackieDYH/article/details/124481953



##### 1.作用：

让父组件可以向子组件指定位置插入html结构，也是一种组件间通信的方式，适用于 父组件==>子组件

##### 2.分类：

默认插槽、具名插槽、作用域插槽

##### 3.使用方式：

###### 1.默认插槽

```
父组件：
<template>
  <div class="container">
    <Category title="美食">
      <img src="https://s3.ax1x.com/2021/01/16/srJlq0.jpg" alt="">
    </Category>

    <Category title="游戏" >
      <ul>
        <li v-for="(g,index) in games" :key="index">{{g}}</li>
      </ul>
    </Category>

    <Category title="电影">
      <video controls src='./assets/shengqi.mp4'></video>
    </Category>
  </div>
</template>

<script>
import Category from './components/Category.vue'
export default {
  name: "App",
  components: { Category },
  data(){
    return{
      foods:['火锅','烧烤','小龙虾','牛排'],
      games:['红色警戒','穿越火线','英雄联盟','刀塔'],
      films:['《教父》','《星际穿越》','《变形金刚》','《盗梦空间》']

    }
  }
};
</script>


子组件：
<template>
  <div class="category">
    <h3>{{ title }}分类</h3>
    <!-- 定义一个插槽（挖个坑，等着组件的使用者进行填充） -->
    <slot>我是默认插槽，没有传递具体结构时，我会出现</slot>
  </div>
</template>

<script>
export default {
    name:'MyCategory',
    props:['title']
}
</script>


```

###### 2.具名插槽

```
父组件：
<template>
  <div class="container">
    <Category title="美食">
      <img slot="center"  src="https://s3.ax1x.com/2021/01/16/srJlq0.jpg" alt="">
      <a class="foot"  slot="footer"  href="https://baidu.com">百度</a>
    </Category>

    <Category title="游戏" >
      <ul slot="center">
        <li v-for="(g,index) in games" :key="index">{{g}}</li>
      </ul>
      <div class="foot" slot="footer">
        <a solt="footer"  href="https://baidu.com">单机游戏</a>
        <a solt="footer"  href="https://baidu.com">网络游戏</a>
      </div>      
    </Category>

    <Category title="电影">
      <video  slot="center" controls src='./assets/shengqi.mp4'></video>
      <template v-slot:footer>
        <div class="foot">
        <a solt="footer"  href="https://baidu.com">经典</a>
        <a solt="footer"  href="https://baidu.com">热门</a>
        <a solt="footer"  href="https://baidu.com">推荐</a>
      </div>
      <h4>欢迎前来观影</h4>
      </template>
      
    </Category>
  </div>
</template>

<script>
import Category from './components/Category.vue'
export default {
  name: "App",
  components: { Category },
  data(){
    return{
      foods:['火锅','烧烤','小龙虾','牛排'],
      games:['红色警戒','穿越火线','英雄联盟','刀塔'],
      films:['《教父》','《星际穿越》','《变形金刚》','《盗梦空间》']

    }
  }
};
</script>




子组件：
<template>
  <div class="category">
    <h3>{{ title }}分类</h3>
    <!-- 定义一个插槽（挖个坑，等着组件的使用者进行填充） -->
    <slot name="center">我是默认插槽，没有传递具体结构时，我会出现1</slot>
    <slot name="footer">我是默认插槽，没有传递具体结构时，我会出现2</slot>
  </div>
</template>

<script>
export default {
    name:'MyCategory',
    props:['title']
}
</script>


```

###### 3.作用域插槽：

​			1.理解：数据在组件的自身，但根据数据生成的结构需要组件的使用者来决定。

​			（games数据在category组件中，但使用数据所遍历出来的结构由App组件决定）

​			2.编码：	

```
父组件:
<template>
  <div class="container">
    <Category title="游戏" >
      <template scope="duixiang">
        <ul slot="center">
          <li v-for="(g,index) in duixiang.games" :key="index">{{g}}</li>
        </ul>
      </template>     
    </Category>

    <Category title="游戏" >
      <!-- 解构赋值{} -->
      <template scope="{games}">
        <ol>
          <li style="color: red" v-for="(g,index) in games" :key="index">{{g}}</li>
        </ol>
      </template>     
    </Category>

    <Category title="游戏" >
      <!-- 解构赋值{} -->
      <template slot-scope="{games}">
        <h4 v-for="(g,index) in games" :key="index">{{g}}</h4>     
      </template>     
    </Category>
    


  </div>
</template>

<script>
import Category from './components/Category.vue'
export default {
  name: "App",
  components: { Category },
  
};
</script>


子组件：
<template>
  <div class="category">
    <h3>{{ title }}分类</h3>
    <slot :games="games"></slot>
  </div>
</template>

<script>
export default {
    name:'MyCategory',
    props:['title'],
    data(){
    return{
      games:['红色警戒','穿越火线','英雄联盟','刀塔'],
    }
  }
}
</script>

```



##### 