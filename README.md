# ElemeProject
![](https://raw.githubusercontent.com/samlaudev/ElemeProject/master/ScreenShots/Eleme-Images.jpg)

由[Sam Lau](http://www.jianshu.com/users/256fb15baf75/latest_articles)用Objective-C编写的一个模拟的[**饿了么**](http://bzclk.baidu.com/adrc.php?t=00KL00c00fAoF900FWu70nsem00kZAIN00000aMzyzf00000usuy7Q.THvvq_ZQsef0UWdBmy-bIy9EUyNxTAT0T1Y3mHfduH7BmW0snjD3uWfs0ZRqPjmLPHcvfWPKwbNjnYn4nbnYnjRLwRczwWm1fW0vPj60mHdbXWKVmLCsP7-RRH7pNDuGyyGKIYdDwHwpp-7LihYkph7gRH-PNDY1HyGunR4DHgG5fdGLmvY4pv7gRH-PN7-VyNfsX79lfydbw104ih4yI7KHyMuWUy_4HNPpXhwgiMuWUy_4ih4aXy7RnZ-2URuom1P2p-KRfiR1w0K-5y9YIZ0lQzq-UAR8UyR0mLFW5HfLn1Tz&wd=饿了么&issp=1&f=8&ie=utf-8&tn=baiduhome_pg)客户端

##Table of Contents
###1. [Prerequisite (先决条件)](#prerequisite)
###2. [Development Process (开发过程)](#development_proces)
###3. [Best Practices (最佳实践)](#best_practices)
###4. [Join Us (共同参与项目)](#join_us)

<b id="prerequisite"></b>
#Prerequisite
##敏捷开发
* 掌握如何收集、编写和测试用户故事，估算已有的用户故事并发布计划 --- 参考书籍：[用户故事与敏捷方法](http://book.douban.com/subject/4743056/)
* 熟悉Scrum开发过程和如何管理和跟进项目进度 --- 参考书籍[硝烟中的Scrum和XP](http://book.douban.com/subject/3390446/)
* 了解XP极限编程的基本实践 --- 参考书籍[解析极限编程](http://book.douban.com/subject/6828074/)


##MVVM(Model-View-View Model)
![MVVM high level.png](http://upload-images.jianshu.io/upload_images/166109-81012f4948373da5.png)
在MVVM架构中，通常都将view和view controller看做一个整体。相对于之前MVC架构中view controller执行很多在view和model之间数据映射和交互的工作，现在将它交给view model去做。
至于选择哪种机制来更新view model或view是没有强制的，但通常我们都选择[ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa)。ReactiveCocoa会监听model的改变然后将这些改变映射到view model的属性中，并且可以执行一些业务逻辑。

举个例子来说，有一个model包含一个dateAdded的属性，我想监听它的变化然后更新view model的dateAdded属性。但model的dateAdded属性的数据类型是NSDate，而view model的数据类型是NSString，所以在view model的init方法中进行数据绑定，但需要数据类型转换。示例代码如下：

```
RAC(self,dateAdded) = [RACObserve(self.model,dateAdded) map:^(NSDate*date){ 
    return [[ViewModel dateFormatter] stringFromDate:date];
}];
```

ViewModel调用dateFormatter进行数据转换，且方法dateFormatter可以复用到其他地方。然后view controller监听view model的dateAdded属性且绑定到label的text属性。

```
RAC(self.label,text) = RACObserve(self.viewModel,dateAdded);
```

现在我们抽象出日期转换到字符串的逻辑到view model，使得代码可以**测试**和**复用**，并且帮view controller**瘦身**。

##项目目录结构

##Objective-C 编码规范
关于Objective-C的编码规范，请参考我翻译的[raywenderlich.com Objective-C编码规范](https://github.com/samlaudev/Objective-C-Coding-Style)

##iOS 最佳实践

##iOS 开源库
* [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa)
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)
* [Mantle](https://github.com/Mantle/Mantle)
* [Masonry](https://github.com/SnapKit/Masonry)
* [Classy](https://github.com/cloudkite/Classy)
* [ClassyLiveLayout](https://github.com/olegam/ClassyLiveLayout)
* [Kiwi](https://github.com/kiwi-bdd/Kiwi)

<b id="development_proces"></b>
#Development Process
<div align="center">
<img src="https://raw.githubusercontent.com/samlaudev/ElemeProject/master/ScreenShots/Scrum-Development-Process.jpg"/>
</div>

根据上面图示，我们简单概括Scrum的开发过程：

1. **Product Owner**(一般都是产品经理)从实际用户、交互设计师、开发人员和测试人员中收集用户故事，从而创建**Product Backlog**来记录所有的用户故事。
2. 

##Prodcut Backlog
###1. 用户角色建模
####用户角色
很多时候需求分析人员都是从**单一的角度**来编写用户故事，但这样往往会容易忽略一些故事，因为有些故事并不能反映所有用户的**背景、经历和目标**。
####角色建模步骤
1. 通过头脑风暴，列出初始的用户角色集合
2. 整合角色
3. 提炼角色
4. 角色建模

####虚构人物
虚构人物能够真正代表产品的目标用户，从虚构角度来描述故事会变得更加生动，更贴近用户使用过程。

####极端人物
极端人物很可能会让你编写出原本可能**遗漏**的故事。

###2. 编写用户故事
####优秀故事特点(INVEST，英文缩写)
* 独立的(**I**ndependent)

    我们尽量避免故事之间**相互依赖**，因为在对故事排列优先级或对故事计划时会导致一些问题。例如客户团队已经选择一个优先级高的故事，但它对一个优先级低的故事有依赖，就这会出现问题。

* 可讨论的(**N**egotiable)

    故事是可以讨论的，而不是签署好的合同或者软件必须实现的的需求。故事只是对功能的简短描述，细节将在客户团队和开发团队的讨论产生。

* 对用户有价值的(**V**aluable to Users)

	每个故事应当体现对客户或用户的价值，而不是关注技术和实现细节；同时，应该避免在故事中出现用户界面和技术方面的定义。而保证每个故事对客户或用户有价值的最好方法就是**让客户来编写故事**。

* 可估计的(**E**stimatable)

	对于开发人员来说，估算完成一个用户故事的所需的时间是很重要，它关系到如何制定发布计划和迭代计划。通常都是使用**故事点**作为估算单位，一个故事点就是一个理想工作日，这一天没有会议，没有邮件，没有电话等干扰。
	
	但一般有3个原因导致故事不可估计：
	* 开发人员缺乏领域知识，通过与**客户讨论**可解决
	* 开发人员缺乏技术知识，通过XP的**Spike(探针试验)**可解决
	* 故事太大，通过**分解成小故事**可解决

* 小的(**S**mall)

	故事的**粒度**很重要，故事太大或太小，都无法制定发布计划和迭代计划。
	
	如果**故事太大**，我们称它为史诗故事(Epic Story)。对于史诗故事，分为两种：复合故事和复杂故事
	* 复合故事：它由很多个小的故事组成的史诗故事；常用的分解方法就是按照“访问、”“创建”、“删除”和“修改”等动作来分解故事。
	* 复杂故事：它本身就是很大且不容易分解的故事，一般都是由于不确定性而导致复杂。可以将它分解两个故事：一个做**调研的故事**和一个**开发的故事**。

	有时候**故事太小**，可以将它们合并成一个故事。

* 可测试的(**T**estable)

	故事必须是可测试的，因为成功通过测试才表明该故事已经完成。通常测试的内容都是与**功能相关**，而不测试非功能性的内容。
	
	如果有可能，就要尽量测试自动化；当产品是增量开发或代码需要重构时，只要发生变化，就能马上发现问题并马上改进。

####收集故事步骤

###3. 估算用户故事

###4. 测试用户故事


##Sprint计划
##Sprint Backlog
##1-4 Week Sprint
##Sprint演示

<b id="best_practices"></b>
#Best Practices

##增量设计与重构

##TDD与BDD

##Git版本控制和工作流

##持续集成测试

##代码规范

##Code Review

<b id="join_us"></b>
#Join Us
