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

1. Product Owner(一般都是产品经理)从实际用户、交互设计师、开发人员和测试人员中收集用户故事，从而创建**Product Backlog**来记录所有的用户故事。
2. 根据由Product Owner收集的Product Backlog，所有团队成员进行**Sprint计划会议**，主要是确定Sprint目标、演示时间、团队成员名单、Sprint backlog和每日Scrum会议的时间和地点。

##Product Backlog
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

####收集故事方法
收集故事就像**捕鱼**。首先，不同大小的网用来捕捉不同大小的需求；第二，需求会像鱼一样，会成长，也可能死亡。第三，在某个区域拖网捕鱼，不可能捕捉所有的鱼，我们也不可能捕捉到所有的需求。

**收集故事方法**有以下：

* 用户访谈
* 问卷调查
* 观察
* 故事编写工作坊(最常用)

####用户故事字段
我们的故事大概以下几个字段：

* **ID(统一标识符)** 是一个自增长的数字；主要是为了防止重命名故事找不到它。
* **Name(名称)** 简短的、描述性的故事名。比如，选择餐厅；它必须含义明确，让客户和开发者都能够明白它的含义，跟其他故事区分开来。
* **Importance(重要性)** Product Owner评出一个数值来表示故事的重要性。比如，99或10，分数越高表示越重要
* **Estimate**(估算) 由团队中的成员来共同估算完成故事所需要的时间，时间单位通常就是故事点。
* **Detail**(细节) 代入用户角色，更加详细地描述故事有关细节。大概格式如下：作为一个(As a)什么样的角色，想(want)做什么，就应该(so that)得到这样的结果。
* **Scenario**(故事情节) 其实它就是一个简单的测试规范，先这样做，然后这样做，就应该得到这样结果。测试用例都遵循三段式**Given-When-Then**的描述，清晰地表达测试用例是测试什么样的对象或数据结构，在基于什么上下文或情景，然后做出什么响应。

可以参考我在[wiki](https://github.com/samlaudev/ElemeProject/wiki)的**Product Backlog**编写的[饿了么的用户故事](https://github.com/samlaudev/ElemeProject/wiki/Product-Backlog)

###3. 估算用户故事
####迭代估算
1. 把所有参与估算的客户和开发者聚集在一起，并带上故事卡和一些额外的笔记本
2. 客户随机抽取一个故事，读给开发者听，开发者尽可能提出疑问，而客户要尽其所能解答
3. 如果对故事没有疑问，每个开发人员在卡上写上一个估算值，暂不要给其他人看。
4. 大家写好估算值之后，所有人翻开他们的卡片展示给其他人看。此时，如果估算值相差太多，估算值高的和低的都要给出合理的解释。
5. 讨论完故事之后，开发人员再次将估算值写到卡片上。当大家都写好之后，再次展示给大家看。如果估算值还是相差很多大，再次进行以上步骤，直到故事得到一个比较统一的值为止。这个过程一般很少会超过3次，但是只要估算在不断接近一致，那我们就继续这个过程。

####三角测量
在做了几个估算之后，我们有必要对估算进行三角测量。具体做法如下:在故事一个故事时，根据这个故事与其他故事的关系进行估算。

###4. 测试用户故事
在编写代码之前先测试用户故事主要有**两个好处**：

* 很多客户和开发人员讨论故事时得出来的细节可以通过验收测试记录下来，到了TDD或BDD阶段就可以提取出测试用例来编写测试。
* 有了验收测试之后，我们就知道什么时候某个功能算是完成，这就避免花太多或太少时间和精力。

####何时写验收测试
* 客户和开发人员在讨论故事细节时需要记录
* 在迭代开始时，即写代码之前
* 在开发过程或之后的任何时候发现新的测试

####写测试需考虑那些问题
* 关于这个故事，开发人员还需要知道什么？
* **如何实现**这个故事？
* 有没有一些**特殊情**况会使这个故事有不一样的行为？
* 这个故事在什么情况下会**出错**？

##Sprint计划
###1. 准备Sprint计划
在开始Sprint计划会议之前，必须确保Product Backlog**必须存在**。但不要求所有的故事必须都完美无缺，所有的优先级都固定不变。但以下几点是必须满足的：

* 只能有一个Product Backlog和一个Product Owner(只开发一个产品)
* 所有的用户故事的重要性都**被评分**，不同的重要性对应不同的分数
* 有时故事是由其他人添加的，所以Product Owner应该**理解每个故事的含义**

###2. 制定Sprint计划
####Sprint计划会议日程
Sprint计划会议时间：13：00 - 17：00 (每个小时休息10分钟)

* **13：00 - 13：30** Product Owner概括product backlog，对sprint目标介绍，确定演示时间和地点
* **13：30 - 15：00** 团队成员一起参与**估算时间**；根据实际情况下拆分用户故事，product owner在必要时修改其重要性，所有重要性高的用户故事都必须填写故事情节
* **15：00 - 16：00** 基于团队估算的生产率，团队从product backlog选择优先级高的故事放在sprint backlog
* **16：00 - 17：00** 进一步将故事拆分为任务，确定每日Scrum会议的固定时间和地点。

####确定Sprint目标
由于某些原因，确定Sprint目标确实有点困难。但有目标总比没目标好，起码我们知道做事是为了什么。目标通常都是完成或改进什么样的功能或赚更多的钱。

####确定Sprint长度
**短的Sprint长度好处**：短的Sprint=短的反馈周期=更频繁的交付=更频繁的客户反馈=在错误方向花的时间更少

**长的Sprint长度好处**：团队可以有更多时间充分准备，解决发生的问题，继续完成sprint目标；不会给频繁的sprint计划和演示压得透不过气

**建议**：刚开始要试验sprint的长度，不要浪费时间分析，试验几个sprint之后再进行调整。不过，确定自己喜欢的长度之后，就尽量长时间坚持使用。很多团队都采用3个星期作为sprint长度。

####估算时间
 * 本能反应
 * 计算生产率

####确定Sprint包含的故事
基于团队估算的生产率，团队从product backlog选择优先级高的故事放在sprint backlog。Product Owner通过以下方法来影响sprint包含的故事：

1. 调整故事的优先级
2. 缩小史诗故事的范围
3. 拆分史诗故事成多个小故事卡

####故事拆分任务
故事拆分任务**原因**：

* 对于很多团队来说，实现故事的开发人员不止一个，将故事拆分为多个任务，可以分配任务给不同的开发者来完成同一个故事
* 故事是用户或客户有价值功能的描述，它们并不是开发人员的To-do-list。
* 将故事拆分为多个任务后，时间估算更加容易了

**拆分准则**：

* 如果故事的某个任务特别难以估计，就将那个任务从故事的其余任务中分离出来
* 有些任务可以容易安排给多名开发人员共同完成，就拆分它们
* 如果有必要让客户了解故事某一部分的完成情况，可以把那部分拿出来作为一个任务

####Sprint计划成果
* Sprint目标
* Sprint演示日期
* 团队成员名单
* Sprint backlog
* 每日Scrum会议的时间和地点

###3. 发布Sprint计划
我们要让整个公司的人了解我们做什么，我们使用如图所示的**Sprint信息页**(截取[硝烟中的Scrum和XP](http://book.douban.com/subject/3390446/)里面的图)。

![](https://raw.githubusercontent.com/samlaudev/ElemeProject/master/ScreenShots/Sprint-Information-Page.png)

Sprint会议一**结束**，ScrumMaster就将**Sprint信息页**通过Email发给每一位团队成员。此外，ScrumMaster还会把sprint信息页打印出来，贴在团队房间的墙上。

当Sprint接近尾声时，ScrumMaster会把即将来临的演示告知每个人。

这样，就没人还能找借口说**不知道**你们的工作状态。


##Sprint Backlog
完成Sprint计划会议后，ScrumMaster应该就开始创建Sprint Backlog，要在第一次每日例会之前完成。

###Sprint Backlog形式
Sprint backlog有多种形式来保存，其中包括挂在墙上的任务板、Leangoo、Jira和Teambition等，你可以根据自己的喜好来选择。

* 挂在墙上的任务板
![硝烟中的Scrum和Xp的任务板](https://raw.githubusercontent.com/samlaudev/ElemeProject/master/ScreenShots/Task-Board.png)

* [Leangoo](http://home.leangoo.com)
![Leangoo的任务板](https://raw.githubusercontent.com/samlaudev/ElemeProject/master/ScreenShots/Leangoo-Task-Board.jpg)

* [Jira](https://www.atlassian.com/software/jira/)
![Jira的任务板](https://raw.githubusercontent.com/samlaudev/ElemeProject/master/ScreenShots/Jira-Task-Board.png)

* [Teambition](https://www.teambition.com)
![Teambition product backlog](https://raw.githubusercontent.com/samlaudev/ElemeProject/master/ScreenShots/Teambition-Task-Board.gif)
![Teambition sprint backlog](https://raw.githubusercontent.com/samlaudev/ElemeProject/master/ScreenShots/Teambition-Sprint-Backlog.gif)
具体实践建议可以参考知乎的一个关于[scrum工具大家有什么推荐](http://www.zhihu.com/question/19609029)问题**李武**的回答。

###

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

##Bug跟踪

<b id="join_us"></b>
#Join Us
