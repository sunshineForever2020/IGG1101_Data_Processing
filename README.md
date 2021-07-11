# 2021年7月9日组会展示的处理syisr数据的程序demo 

## 源程序都在src中

* [readDataFromRawEcho.m](https://github.com/sunshineForever2020/IGG1101_Data_Processing/blob/main/src/readDataFromRawEcho.m) 读取报文二进制数据为Matlab 表结构，未完善
* [pulse_int.m](https://github.com/sunshineForever2020/IGG1101_Data_Processing/blob/main/src/pulse_int.m) 非相干积累程序，积累不同列，即积累慢时间
* [main.m](https://github.com/sunshineForever2020/IGG1101_Data_Processing/blob/main/src/main.m) 将读取的报文数据整理为快、慢时间雷达数据平面，绘制功率-高度图（功率剖面图）、功率-高度-时间图（RTI图）、某高度点双峰谱图以及全高度点双峰谱图

## 数据文件在百度网盘中

* 链接: https://pan.baidu.com/s/1pSRUWY553CIa_z5V5KM4rQ  密码: 8321
* 将其放置data文件中即可

## 几个概念

* 雷达快慢时间二维数据，列维是快时间，行维是慢时间
* 距离分辨率，一个发射脉宽的分辨率，长脉冲一般为 $$c \tau/2$$
* 距离门，采样点间的距离

## 注意事项

* 本程序目前没有对高度进行标定，y轴都是采样点数

## 展望

* 分享该程序目的一，这仅仅是我的理解， 必然有错误的地方，大家的眼睛是雪亮的，有不同见解就提，直接提交代码，你就是贡献者之一。
* 目的二，牛顿曾经说过，他只是站在巨人的肩膀上。可见前人都是注重分享知识的，我没有理由藏着掖着，知识是大家的，这不是专利， 如果每个人都先盲目的走一遍前人做过的事情，那还发展什么？ 
* 目的三， 这些东西也不是我的原创， 也不代表我多么厉害， 都是前人已经总结过的东西。 GUISDAP中有， 文献中有。 也请大家有东西注重分享， 也容易让别人给你挑错，共同进步， 利大于弊！

