#import "@preview/touying:0.6.1": *
#import themes.metropolis: *

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => text(size: 0.6em, fill: gray)[SAST 运维/Linux 组 · 2026 · 第一课],
  header-right: image("/assets/sast-logo-白.png", height: 1.2em),
  config-info(
    title: [提问的智慧 · 初识 GNU/Linux],
    subtitle: [SAST 运维/Linux 组 · 第一课],
    author: [运维/Linux 组],
    date: [2026 年 · 秋 ],
    institution: [软件研发部],
  ),
  config-colors(primary: rgb("#0d7377")),
)
#set text(font: ("Segoe UI", "Source Han Sans SC"), lang: "zh")
#show raw: set text(font: ("JetBrains Mono", "Source Han Sans SC"))
#title-slide()

== 是啊，讲什么

#columns(2)[
  
  *上半场*

  - 提问的智慧
  - 如何*不*像弱智一样提问
  - 计算机教育中缺失的一课

  #colbreak()

  *下半场*

  - 为什么是 Linux
  - Unix 哲学
  - 发行版 / Shell / 终端

]



= 提问的智慧

== 如何像弱智一样提问

- 先问“在吗”，等对方回复后才说正事。
- 报错信息靠拍屏，而且只拍最后一行。
- 搜索引擎都没打开过，先问人甚至是劣等模型。
- 在群里问“有人懂 xxx 吗”，而不是直接描述问题。

#quote(block: true)[
  #text(size: 12pt)[
  I DONT GIVE A FUCK ABOUT THE FUCKING CODE! i just want to download this stupid fucking application and use it

  WHY IS THERE CODE??? MAKE A FUCKING .EXE FILE AND GIVE IT TO ME. these dumbfucks think that everyone is a developer and understands code. well i am not and i don't understand it. I only know to download and install applications. SO WHY THE FUCK IS THERE CODE? make an EXE file and give it to me. STUPID FUCKING SMELLY NERDS
  ]
]

#v(1em)


== 一个真实的场景

新生群里总是发生：

#quote(block: true,)[
  “在吗？”

  “学长，我这里代码报错了怎么办？【一张拍屏照片，屏幕反光，代码截了一半】”
]
#quote(block: true)[
  "......（说了一些小猫话）"
]

#place(
  top + left, 
  dx: 18.5cm, 
  dy: 5.8cm, 
  image("/assets/image-3.png", width: 20%)
)

#v(2em)

如果你是收到消息的人，你的内心活动是：

#align(center)[
  #text(size: 1.5em,)[
  *关掉聊天窗口，假装没看见*
  ]
]


== 为什么没有人愿意回答烂问题

#columns(2)[

#v(3em)
```text
【环境】Windows 11 + VMware 17，虚拟机 Ubuntu 24.04
【目标】我想用 apt 安装 nginx
【现象】
  执行 apt install nginx 后报错：
  E: Unable to locate package nginx
【已尝试】
  1. 搜索了该报错，说是源列表过期
  2. 执行了 sudo apt update，报错依然存在
【问题】接下来该排查什么？
```
#colbreak()

#image("/assets/image.png")

]

== 提问之前

1. *STFW* — Search The Friendly Web
  - 用英文关键词 + 报错原文搜索（Google > Bing > 百度）
  - 报错信息复制完整原文去搜，不要自己转述
  - AI 概览只能作为参考
2. *RTFM* — Read The Friendly Manual
  - `man ls`、`tldr tar`、`命令 --help`
  - 官方文档 > StackOverflow > 博客 > 短视频 > AI聊天模型
3. *最小化复现*
  - 把问题缩减到最小案例，往往缩着缩着自己就解决了

== 让信息能被搜索、复制、复现

- 命令和报错尽量用 *文本 + 代码块*，附相关上下文。
- 图形界面、启动画面、无法复制的错误：清晰截图也合适。
- 写实际版本、操作位置。
- 分享之前删去密码、Token、Cookie、个人信息。


== X–Y Problem

你想解决问题 X，你以为方案 Y 能搞定，

于是你问“怎么实现 Y” —— 但 Y 根本就是错的方向。

#v(1em)

笔试题案例：
#table(columns: (auto, 1fr), inset: 8pt,
  [目标 X], [想取得文件扩展名],
  [猜测的办法 Y], [截取文件名最后三个字符],
  [只问 Y], [“怎么截取最后三个字符？”],
  [更好的问法], [“想识别文件类型；扩展名靠谱吗？”],
)
*描述你的最终目标，而不是你想象中的中间步骤。*


== 别让AI替你负责

「AI Agent 试图扫描 DN42 时把主人搞破产了」

#v(1em)

- 让它解释错误、列出假设、建议 *只读检查*。
- 核对版本、查官方文档；生成的命令可能不存在或过时。
- 执行前说清：改哪里？会删什么？如何验证和恢复？
- 不上传密钥、个人数据、组内服务器配置。

#v(1em)

== 提问之后

#align(center)[
推荐阅读：《提问的智慧》（How To Ask Questions The Smart Way）

  #text(size: 0.8em)[
  github.com/ryanhanwu/How-To-Ask-Questions-The-Smart-Way
  ]
]



= 计算机教育中缺失的一课

== 大学课表不会教你的东西
你的培养方案里有：高数、C 语言、数据结构、操作系统原理……

但*没有一门课*教你：

- 怎么熟练使用命令行和 Shell
- 怎么用编辑器高效改代码
- 怎么用 Git 管理代码而不是靠“最终版v2(1).zip”
- 程序挂了怎么调试、怎么翻墙找资料、怎么保护隐私


== The Missing Semester Of Your CS Education

MIT 的一门课，专门补这个缺口，已有完整中文版：

#align(center)[
*#link("https://missing-semester-cn.github.io/")[missing-semester-cn.github.io]*
#columns(3)[
  #image("/assets/clipboard_2026-10-16_14-46.png", width: 120%)
  #image("/assets/clipboard_2026-10-16_14-2.png", width: 120%)
  #image("/assets/clipboard_2026-10-16_15-01.png", width: 120%)
  ]
]

== The Missing Semester Of Your CS Education

#columns(2)[
  #v(4em)
  #table(columns: (auto, 1fr), inset: 7pt,
  [01],[课程概览 + Shell 入门],
  [02],[命令行环境],
  [03],[开发环境与工具],
  [04],[Debugging and Profiling],
  [05],[Packaging and Shipping Code],
  [06],[智能体编程],
  [07],[不止于代码],
  [08],[代码质量],
  )

  #colbreak()

  #image("/assets/image-5.png")
]



= 初识 GNU/Linux

== 为什么是 Linux
#columns(2)[
  *你身边的Linux*
  - 你的Android手机
  - 你访问的每一个网站背后的服务器
  - 学校的选课系统、镜像站
  - 你家门锁、路由器、#strike[尊界V800]
  #colbreak()
  *一组数据*
  - 全球 Top 500 超算：100% 跑 Linux
  - 大模型与训练集群：100% 跑 Linux
  - 公有云服务器：90%+ 是 Linux
  - 全球基于Linux内核的设备：百亿台
  ]
#v(3em)

桌面之外（从掌心设备到云端算力，再到算力巅峰的超算与 AI 集群），人类几乎所有的现代计算底座都跑在 Linux 上。

== 运维不只是“会敲命令”

- 网站或服务跑在哪里？怎么启动、升级、恢复？
- 用户说“打不开”，如何区分网络、进程、配置问题？
- 怎样让操作能被下一位同学接手？

Linux 常用于服务器、云、嵌入式和开发环境；Android 使用 Linux 内核。

Windows、macOS 也有终端、日志和自动化。*工具选择看任务，不比优越感。*

== 从哪里开始使用 Linux？

#table(columns: (auto, 1fr), inset: 7pt,
  [虚拟机], [练安装、快照与系统管理；本课主线],
  [WSL2], [Windows 上练 Linux 工具；启动与网络有差异],
  [远程服务器], [通过 SSH 使用；必须有授权和独立练习账号],
  [裸机 / 双系统], [直接管理硬件；不作为新生第一课安装路径],
)

容器以后再讲：它不是这节课“安装操作系统”的替代练习。

== 把这几个名词放到一张图里

```text
你的电脑（宿主机 Windows）
└─ VMware（虚拟化软件）
   └─ 一台虚拟电脑（客户机）
      └─ Ubuntu（GNU/Linux 发行版）
         └─ 终端窗口
            └─ Bash（Shell，解释并执行命令）
```

Shell 也可以运行在远程会话里，不一定有图形终端窗口。

== 为什么统一用 Ubuntu 24.04 LTS？

- Linux 指内核；发行版把内核、工具、软件包等组织起来。
- Ubuntu 的资料较多，统一版本便于互相复现问题。
- *LTS* 指长期支持；具体软件包支持范围仍需查官方说明。
- 桌面不是发行版的必需部分，服务器可以没有桌面。

我们选的是 *课堂基线*，不是宣布它适合所有工作。

Apple Silicon 使用 ARM64；Intel/AMD 常见 PC 使用 amd64。

== 镜像站：从笔试的网络题走到真实服务

#link("https://mirrors.njupt.edu.cn/")[mirrors.njupt.edu.cn]

- *ISO 镜像*：安装系统用的文件。
- *软件仓库镜像*：包管理器获取索引和软件包的站点。
- 镜像通常是上游内容的副本，不是另一个发行版。
- 校园网可能更快；速度、目录、同步状态都要实际验证。

第二课从这里获取安装介质、理解 apt 源；今天先认识入口。

== 演示：三个小工具，回答一个具体问题

已准备好的 `status.log` 每行是一个状态码：

```text
200
404
200
500
404
```

```bash
grep -x '404' status.log | wc -l
```

先猜输出，再解释：*选出整行 404 → 统计行数 = 2*。

== “一切皆文件”是一种接口思路

- 普通文件可以读取、写入；管道连接程序的输入输出。
- `/proc` 中有许多由内核动态提供的信息。
- 不等于“网络设备就是普通文件”，也不等于所有信息都落盘。

Unix 工具设计鼓励 *小功能、清晰接口、组合使用*。

刚才组合的是工具；这与接下来讲的 *原子更新*不是同一个概念。

== 一次操作，不等于“随手一串命令”

```bash
mkdir -p notes && printf '%s\n' 'first note' > notes/a.txt
```

- `&&`：前一步成功，才执行下一步；*失败不会自动回滚*。
- `>`：写入前截断原文件；重跑会覆盖，不是追加。
- `mkdir -p`：目录已存在时仍可成功，是幂等行为的一个例子。

*组合、条件执行、幂等、原子性是四个不同概念。*

== 原子更新：先准备，再发布（只建立直觉）

```text
生成同目录临时文件 → 校验内容 → rename 替换目标
```

同一文件系统内，满足条件的 rename 可以原子地替换目录项：
观察者看到旧版本或新版本，而不是半份文件。

但这 *不是* 多步数据库事务，也不自动保证断电后持久保存。

今天只记：*不要直接把未完成的结果当成最终结果。*

== 工程习惯：给自己和别人留条路

+ 先看：当前目录、目标文件、身份、原始错误。
+ 小步改：一次一个条件，不用 `sudo` 掩盖不理解的问题。
+ 再验：退出状态 + 实际结果；没有输出不等于成功。
+ 留记录：命令、版本、观察；历史记录不等于完整实验笔记。
+ 留退路：配置备份、虚拟机快照；快照不等于独立备份。

下一次课，我们亲手把这个闭环走完。

== 离场任务与下节准备

*离场卡：* 写一个更好的提问；画出终端 / Shell / 系统的关系。

*课前准备（详细步骤看讲义）：*
- 报告系统、CPU 架构、内存、磁盘和虚拟化状态。
- Windows x86_64 主线：安装 VMware，下载统一的 24.04.x ISO。
- Mac / 低配置 / 下载困难：提前报备，安排 UTM、WSL2 或结对。

*不要求课前装好 Ubuntu；安装过程留到第二课一起走。*

#focus-slide[
  不用先成为高手，才有资格提问。\
  从一次能解释、能验证的操作开始。
]
