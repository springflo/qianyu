# Qianyu
This app is associated with the free [online
course](http://www.saas-class.org) and (non-free)
[ebook](http://www.saasbook.info) Engineering Software as a Service.
# ![](https://github.com/springflo/qianyu/master/app/assets/images/qianyuwang.png)千语网
>千语网是一个基于用户关系信息分享和获取简短实时信息的社交网络平台。
你可以通过邮箱注册，关注其他用户后可以获取其他用户的最新动态。
你可以以文字、图片的形式分享自己的最新动态和真情实感。<br>
了解更多[千语网](https://qianyu.herokuapp.com/about)

## 功能介绍

### 注册
[千语网注册](https://qianyu.herokuapp.com/signup)
* 用户使用邮箱注册，通过生产环境的SendGrid发送激活邮件给用户
    * 邮件发送超级慢，大约两分钟才能收到邮件（可能是因为没有充钱吧）
    * 邮件很有可能会在你的垃圾箱里面

### 登录
[千语网登录](https://qianyu.herokuapp.com/login)
* 账户激活后可以安全登录
* 记住我选项，使用cookies实现持久会话

### 首页
[千语网首页](https://qianyu.herokuapp.com)
* 导航栏：首页、精选、搜索、找朋友、我的、消息、退出
    * 精选：微语点赞排行榜
    * 找朋友：用户列表，管理员可以删除用户，点进用户个人主页可以进行关注
    * 我的 下拉菜单：个人主页、账号设置
        * 个人主页显示当前账户基本信息
        * 账号设置修改当前账户基本信息
        * 用户头像采用第三方全球通用头像网站：[Gravatar](https://cn.gravatar.com/)
* 首页左栏
    * 显示用户基本信息，微语发表框，可以发表图片
    * 
* 首页右栏
    * 显示用户和关注用户的最新微语动态
    * 首页微语点赞功能：用Ajax实现
* 底部
    * 关于：网站介绍
    * 帮助：网站帮助
    * 联系我们：联系方式
* user用户关系模块
    * 关注/取消关注功能：页面用Ajax实现
    * 查看关注/粉丝列表，缩略图
    * 
* post微语模块 
    * 点击主页微语评论按钮进入微语详情页，显示微语的评论的回复
    * 评论分页，每条评论回复进行折叠，用Ajax实现展开回复

## 测试驱动开发
* 使用 faker、factory_girl 生成测试数据
* 使用 rspec 编写测试代码
    * 测试覆盖率比较小
    * 编写测试基本上和编写代码一样难，要学习新的语法，累得慌
    * 对rspec掌握不熟练，容易出bug
    * 已经违背了FIRST原则中的Fast和Timely

## 非功能
### 安全性
* 用户密码加密存储，启用https

### 健壮性
* 对用户输入进行校验，检验输入长度和存在性等

### 代码味道
* 尽量遵守类间SOLID原则
* 尽量遵守方法SOFA原则
* 尽量做到DRY
    * 在重构的边缘试探
* 但是在具体的实践中很难做到完美
    * 一个页面中一对多关系太多，比如微博详情页面，以个微博对应多条评论，
每条评论又对应多条回复，为了功能只好将回复的查找在View中实现。

## TODO List
>由于时间关系（和能力关系？），系统功能并不完善，详见 todo.md <br>

###### 高级软件工程
###### 云环境下的敏捷开发
###### chunfang





