# JavaScript

语法大全网站地址： https://blog.csdn.net/qq_51657072/article/details/128831333

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



### 正则表达

1.限定符 ？ *  + {...}

2.或 |运算符

3.字符类 元字符

4.贪婪与懒惰匹配



正则表达表单网站：

https://r2coding.com/#/README?id=%e5%b8%b8%e7%94%a8%e6%ad%a3%e5%88%99%e8%a1%a8%e8%be%be%e5%bc%8f%e7%a4%ba%e4%be%8b