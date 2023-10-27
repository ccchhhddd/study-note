# JavaScript

## 1.基本语法
[语法大全网站地址](https://blog.csdn.net/qq_51657072/article/details/128831333)

const ——设置常量

```javascript
const todos=[
{
    id:1,
    text:"go on",
    isCompleted : true,
},
{
    id:2,
    text:"fly away",
    isCompleted : true,
},
{
    id:3,
    text:"try it out",
    isCompleted : true,
},
];
const todoJSON = JSON.stringify(todos)
for (let todo of todos){
console.log(todo.text);
}
alert("验证正确");//弹窗显示
document.write(todos[0].text);//网页显示

<!--html里注释是这样写的-->
/*js和css里的多行注释这样写*/
//单行注释
```



## 2.JS正则表达

1.限定符 ？ *  + {...}

2.或 |运算符

3.字符类 元字符

4.贪婪与懒惰匹配

