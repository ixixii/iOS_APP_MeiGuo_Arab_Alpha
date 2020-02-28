todo list 1: 美国区白包
1.1 退出developer.apple.com上中国区的开发者账号
    退出itunesconnect
    退出xcode上的开发者账号

1.2 创建证书
    1.打开钥匙串，创建csr文件（从证书颁发机构获取证书）
    2.创建开发证书dev和生产证书dis
    3.下载证书，双击导入

1.3 添加真机设备？算了，直接用模拟器算了

1.4 创建应用ID，即注册appid
    net.vwhm.arabalpha

1.5 创建描述文件？算了，直接用模拟器算了

1.6 转到itunesconnect,创建应用,新建app
    主要语言：英文
    隐私政策：privacy.html,放到 http://vwhm.net/app/arabalpha/privacy.html 目录
    将本机的privacy.html scp 至 服务器
    scp /Users/beyond/iOS_APP/arabalpha/privacy.html root@47.75.103.58:/usr/local/nginx/html/vwhm_net_wwwroot/app/arabalpha

    名称：Arab Alpha
    副标题：Arabic Learning
    类别：教育/工具
    价格：免费

1.7 APPICON

1.8 在模拟器上跑起来

1.9 准备数据，实现第一个界面 

2.0 上传时，在xcode上登陆美国开发者账号，需要用app专用密码登陆才行

2.1 8种语言本地化
英文美国

中文简体
中文繁体

英文英国
英文加拿大
英文澳大利亚

日文
韩文

版权：Alva Denise



学阿语字母 - 是一款阿拉伯语字母学习软件，对于那些对阿拉伯语感兴趣的人士来说这款工具是必备品，它能科学高效地帮您快速并且牢固地掌握阿拉伯语字母，包括他们的发音和书写

學阿語字母-是一款阿拉伯語字母學習軟體，對於那些對阿拉伯語感興趣的人士來說這款工具是必備品，它能科學高效地幫您快速並且牢固地掌握阿拉伯語字母，包括他們的發音和書寫

Arab Alpha - It is an Arabic alphabet learning software. For those who are interested in Arabic, this tool is necessary. It can help you quickly and firmly master Arabic alphabet, including their pronunciation and writing scientifically and efficiently

アラビア語の勉強 は アラビア語のアルファベット学習ソフトです。アラビア語に興味がある人にはこのツールが必要です。科学的に効率的に速く、しっかりとアラビア語のアルファベットをマスターできます。彼らの発音と書き込みが含まれます。

아라비아 자모 아랍어 알파벳어 학습 소프트웨어입니다. 아랍어에 흥미를 느끼는 인사들에게는 필수품입니다. 그것은 과학적 효율적으로 당신을 재빨리 도와주고 아랍어 알파벳어 알파벳어 알파벳 알파벳, 그들의 발음과 글을 포함하여 쓰기를 포함합니다.

2.2 上传到git
新建 .gitignore
在里面写上Pods
表示Pods目录不需要git来管理,因为它是pod install自动生成的

git init 

git status 

git add --all

git status 

git commit -m 'iOS 帅哥外语app 第一次提交'

git remote add origin https://github.com/ixixii/iOS_APP_Shuaige_Waiyu.git
git push -u origin master

git pull origin master
git push origin master

刷新一下网页,看一下效果