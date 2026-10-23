#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#import "../catppuccin-latte.typ": catppuccin-latte-colors

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => text(size: 0.6em, fill: gray)[SAST 运维/Linux 组 · 2026 · 第一课],
  header-right: image("/assets/sast-logo-白.png", height: 1.2em),
  config-info(
    title: [提问的智慧 · 初识 GNU/Linux],
    subtitle: [SAST 运维/Linux 组 第一课 · 方草地公开课],
    author: [Y11Han],
    date: [2026 年 · 秋 ],
    institution: [软件研发部],
  ),
  catppuccin-latte-colors,
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
- 搜索引擎都没打开过，先问路人甚至是劣等模型。
- 在群里问“有人懂 xxx 吗”，而不是直接描述问题。

#quote(block: true)[
  #text(size: 12pt)[
  I DONT GIVE A FUCK ABOUT THE FUCKING CODE! i just want to download this stupid fucking application and use it

  WHY IS THERE CODE??? MAKE A FUCKING .EXE FILE AND GIVE IT TO ME. these dumbfucks think that everyone is a developer and understands code. well i am not and i don't understand it. I only know to download and install applications. SO WHY THE FUCK IS THERE CODE? make an EXE file and give it to me. STUPID FUCKING SMELLY NERDS
  ]
]
#h(1em)
#text(size: 0.7em)[https://github.com/sherlock-project/sherlock/issues/2011]
#h(2em)
#text(size: 0.7em)[https://nohello.net/zh-cn/]


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
  - 报错信息复制完整原文去搜，不要自己转述，更不要拍屏！
  - AI 概览只能作为参考
2. *RTFM* — Read The Friendly Manual
  - `man ls`、`tldr tar`、`命令 --help`
  - 官方文档 > StackOverflow > 博客 > 短视频 > AI聊天模型
3. *最小化复现*
  - 把问题缩减到最小案例，往往缩着缩着自己就解决了

== 搜索引擎的正确姿势

#columns(2)[

  *为什么是这个顺序？*

  百度受商业因素所限，大概率返回与问题并非最相关的内容。能访问世界互联网就用 Google，否则 Bing 国际版。

  *进阶语法*

  - `site:` 只在指定站点内搜索
  - `"双引号"` 精确匹配报错原文
  - `-` 排除干扰词、`*` 通配不确定的部分
  - 限定时间范围，#strike[老师好我是何同学]

  #colbreak()

  *一个案例*

  想了解 PyTorch 的叉乘怎么写？

  - 百度「pytorch 叉乘」→ 点开一篇 CSDN 教程，发现还要交钱
  - Google `pytorch cross product` → 直接读 pytorch.org 官方文档

  后者永远更全面、更透彻。

  上手新工具同理：搜 `carla doc`，从官方文档的 #highlight[Getting Started] 读起。

]

#text(size: 0.8em)[参考资料： https://www.instructables.com/How-to-Properly-Use-a-Search-Engine/]

== 按问题选地方

#v(1em)

#table(columns: (auto, 1fr), inset: 9pt,
  [*遇到的情况*], [*去哪查*],
  [报错看不懂、编译不过], [Stack Overflow —— CSDN/知乎/NGA 不少内容搬运自这里],
  [论文出处、引用格式], [Google Scholar],
  [想#highlight[找现成的轮子]], [GitHub 搜索 / Code Search，用之前先看 LICENSE],
  [上手新工具、新库], [官方文档的 Getting Started],
  [学公开课], [课程主页 → YouTube 讲解 → B 站 / 知乎补充],
)

== 让信息能被搜索、复制、复现

- 命令和报错尽量用 *文本 + 代码块*，附相关上下文。
- 图形界面、启动画面、无法复制的错误：清晰截图也合适。
- 写实际版本、操作位置。
- 分享之前删去密码、Token、Cookie、个人信息。
- 尝试用 Issue 反馈问题


== X–Y Problem

你想解决问题 X，你以为方案 Y 能搞定，

于是你问“怎么实现 Y” —— 但 Y 根本就是错的方向。

XY问题会掩盖真正的核心问题，甚至可能引入次生问题，从而导致沟通不畅、资源浪费，并且无法高效解决问题。对于支持人员而言，解决办法是主动提出探索性问题，询问对方为什么需要这些信息，以便找出根本问题X，并引导用户摆脱错误的研究方向。

#v(1em)
#text(size: 0.5em)[https://zh.wikipedia.org/zh-cn/XY%E9%97%AE%E9%A2%98]
== 别让AI替你负责

「AI Agent 试图扫描 DN42 时把主人搞破产了」

#v(1em)

- 让它解释错误、列出假设、建议 *只读检查*。
- 核对版本、查官方文档；生成的命令可能不存在或过时。
- 执行前说清：改哪里？会删什么？如何验证和恢复？
- 不上传密钥、个人数据、组内服务器配置。

#v(1em)

== 提问之后

交流当然值得鼓励 —— 但提问之前先付出努力；即使问了，主动权也始终在你手里：对方没有义务替你解决，继续自己找答案也许依然需要。

#v(1.5em)
#align(center)[
推荐阅读：《提问的智慧》（How To Ask Questions The Smart Way）

  #text(size: 0.8em)[
  github.com/ryanhanwu/How-To-Ask-Questions-The-Smart-Way
  ]

#v(0.5em)

延伸阅读：SAST Skill Docs ·《如何解决问题》

  #text(size: 0.8em)[
  docs.net9.org/basic/meet-problems/
  ]
]



= 计算机教育中缺失的一课

== 大学课表不会教你的东西
你的培养方案里有：高数、线性代数与解析几何、C 语言、数据结构……

但*没有一门课*教你：

- 怎么熟练使用命令行和 Shell
- 怎么用编辑器高效改代码
- 怎么用 Git 管理代码而不是靠“最终版v2(1).zip”、“代码.docx”
- 怎么调试程序、怎么跨越长城找资料、怎么保护隐私
- *怎么截图以不侵犯别人的眼睛*

#place(
  top + left, 
  dx: 21cm, 
  dy: 7.5cm, 
  image("/assets/image-2.png", width: 25%)
)

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

== 发行版：打包好的自由

Linux 只是内核。你真正能装上手的，是*发行版* —— 把内核、GNU 工具、包管理器和安装器打包好的成品：

#v(0.5em)

#align(center)[
  #box(image("/assets/debian.svg", height: 2.4em)) #h(1.4em)
  #box(image("/assets/ubuntu.svg", height: 2.4em)) #h(1.4em)
  #box(image("/assets/fedora.svg", height: 2.4em)) #h(1.4em)
  #box(image("/assets/archlinux.svg", height: 2.4em)) #h(1.4em)
  #box(image("/assets/android.svg", height: 2.4em))
]

#v(0.5em)

#table(columns: (auto, 1fr), inset: 9pt,
  [*Debian 系*], [Debian → Ubuntu → Mint ……（`apt`）],
  [*Red Hat 系*], [Fedora / RHEL / CentOS ……（`dnf`）],
  [*Arch 系*], [Arch → Manjaro ……（`pacman`），滚动更新],
  [*另类*], [Android：Linux 内核 + 一套完全不同的用户态],
)

#v(0.5em)

南邮镜像站：`mirrors.njupt.edu.cn`

== 终端 ≠ Shell

#grid(columns: (1fr, 2fr), gutter: 1em,
  [
   #v(1em)

   ```text
   宿主机：你的电脑
   └─ VMware（虚拟化软件）
     └─ Guest：一台虚拟电脑
       └─ Ubuntu（发行版）
         └─ 终端（窗口）
           └─ Bash（Shell）
   ```
  ],
  [
   #v(1em)

   - *终端*：那个黑窗口，管显示和键盘输入
   - *Shell*：真正理解命令的程序（Bash / Zsh / Fish）
   - SSH 连服务器时用 —— 对面往往连桌面都没有
  ],
)


== 为什么值得大学生认识它

#align(center)[

  #image("/assets/image-1.png", width: 72%)

  #text(size: 0.6em)[
    知乎问答 - 为什么计算机专业的学生要学习使用 Linux 系统？
    https://www.zhihu.com/question/19934684
  ]
]

== 从#strike("开天辟地")说起

60 年代末，AT&T 的贝尔实验室的工程师们发明了名为 Unix 的操作系统，并将其广泛分享给各高校和研究机构，那是个自由的时代。

但到了 80 年代，AT&T 在反垄断拆分后进入计算机市场，Unix 的源代码从此不再自由分享。各高校和研究机构只得在 Unix 的基础上开发自己的操作系统，形成了 *Unix-like* 的生态。AT&T 开始起诉 Unix 衍生版开发者侵犯版权，后来甚至起诉了加州大学伯克利分校（BSD），引发了 *Unix wars*。科技界的格局变了。


== 理查德·斯托曼 (Richard Matthew Stallman)

他是一位著名的自由软件倡导者和程序员，也是 GNU 项目的创始人。他辞去了麻省理工的工作，并于1985年创立了自由软件基金会（FSF），致力于推广*四大基本自由*：

// CRT Style
#align(center)[
  #block(width: 94%, radius: 6pt, inset: (x: 2em, y: 1.2em))[
    #set text(font: ("VT323"), size: 20pt)

    // 辉光
    #let glow(body, color: rgb("#40b864"), radius: 0.06em, copies: 10) = box({
      for i in range(copies) {
        let a = i / copies * 360deg
        place(dx: radius * calc.cos(a), dy: radius * calc.sin(a),
          text(fill: color.transparentize(88%), body))
      }
      text(fill: color, body)
    })

    #glow([#text(size: 2.5em)[BASIC FREEDOMS ]])

    #v(0.3em)
    
    #let line(color, en) = {
      glow(color: color)[#en]
    }

    #align(center)[
      #block[
        #align(left)[
        #line(rgb("#15286f"), [#text(size: 1.5em)[0. Free to run it]])
        #linebreak()
        #line(rgb("#5b6340"), [#text(size: 1.5em)[1. Free to study it]])
        #linebreak()
        #line(rgb("#8b5776"), [#text(size: 1.5em)[2. Free to change it]])
        #linebreak()
        #line(rgb("#509e61"), [#text(size: 1.5em)[3. Free to share it]])
        ]
      ]
    ]
  ]
]

为了确保这些自由，他创建了一种法律许可协议，开发者可以将其附加在代码上。


== GNU 通用公共许可证 (GPL)
#block[

  #set text(
    font: ("JetBrains Mono"),
    size: 9.8pt,
    fill: rgb("#24292f"),
    spacing: 110%,
  )
  #set par(leading: 0.75em, justify: true)


  // ==== 许可证展示（居中头 + 原始文本） ====
  #align(center)[
    #text(size: 1.35em, weight: "bold")[
      GNU #text(fill: rgb("#b45309"))[GENERAL PUBLIC LICENSE]
    ] \
    #v(2pt)
    #text(size: 1.0em, fill: rgb("#57606a"))[
      Version 1, February 1989
    ]

    #v(10pt)

    // 版权与声明段落
    #block(width: 82%)[
      #set text(size: 8.6pt, fill: rgb("#57606a"))
      #set par(justify: false)
      Copyright (C) 1989 Free Software Foundation, Inc. \
      51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA \
      #v(2pt)
      Everyone is permitted to copy and distribute verbatim copies \
      of this license document, but changing it is not allowed.
    ]

    #v(12pt)

    // Preamble 章节标题
    #text(size: 1.15em, weight: "bold", fill: rgb("#0f1419"))[Preamble]
  ]

  #v(8pt)

  // ==== 核心条款 ====
  #block(width: 100%, inset: (left: 1.5em))[
    #set par(first-line-indent: 2em, justify: true)

    The license agreements of most software companies try to keep users at the mercy of those companies. By contrast, our General Public License is intended to guarantee your freedom to share and change free software--to make sure the software is free for all its users.

    #v(6pt)

    When we speak of free software, we are referring to freedom, not price. Specifically, the General Public License is designed to make sure that you have the freedom to give away or sell copies of free software, that you receive source code or can get it if you want it, that you can change the software or use pieces of it in new free programs; and that you know you can do these things.

    #v(6pt)

    #text(fill: rgb("#57606a"))[
      To protect your rights, we need to make restrictions that forbid anyone to deny you these rights or to ask you to surrender the rights. These restrictions translate to certain responsibilities for you if you distribute copies of the software, or if you modify it...
    ]
  ]

  // ==== 底部 Unix 终端状态栏 ====

  #line(length: 100%, stroke: 0.5pt + rgb("#e1e4e8"))
  #v(3pt)
  #grid(
    columns: (1fr, auto),
    text(size: 7.5pt, fill: rgb("#8c959f"))[
      -- MORE (Line 1-28/182) -- [Press SPACE to continue, 'q' to quit]
    ],
    text(size: 7.5pt, fill: rgb("#8c959f"))[
      UTF-8 // 100%
    ]
  )
]


== GNU is Not Unix

为了反击AT&T，他开始研发一个基于Unix的项目，但完全从零开始构建。


#align(center)[

  #block(
    fill: rgb("#16181b"),
    inset: (x: 22pt, top: 20pt, bottom: 24pt),
    radius: 6pt,
    stroke: 1pt + rgb("#282e34"),
  )[
    #set text(
      font: ("Cascadia Code", "DejaVu Sans Mono", "Consolas", "Courier New"),
      size: 10.5pt,
      fill: rgb("#e7fcff"),
    )
    #set smartquote(enabled: false)
    #set par(leading: 0.75em, justify: false)

    #align(left)[
  
      GNU 0.3 (hurdle) (tty1)

      #v(8pt)

      #grid(
        columns: (auto, auto),
        gutter: 14pt,
        align: (top, top),
        block(
          fill: rgb("#bcc4c8"),
          stroke: 0.8pt + rgb("#555d64"),
          radius: 1.5pt,
          inset: 2pt,
          width: 34pt,
          height: 34pt,
          align(center + horizon)[
            #image("/assets/gnu.svg", width: 27pt)
          ]
        ),
        [
          #v(1pt)
          This is the superunprivileged.org Hurd LiveCD. \
          Welcome.
        ]
      )

      #v(10pt)

      Use 'login USER' to login, or 'help' for more information about logging in. \
      Try logging in as the 'guest', or the 'tutorial' user. The passwords are \
      the same as the usernames. \
      After logging in, use 'info guide' to learn more about how to use the Hurd.

      #v(8pt)

      login> \_
    ]
  ]
]



== GNU is Not Unix

要复刻Unix系统，GNU项目必须重构三层功能：

// CRT Style
#align(left)[
  #block(width: 94%, radius: 6pt, inset: (x: 2em, y: 1.2em))[
    #set text(font: ("VT323", "Microsoft YaHei"), size: 22pt)

    // 辉光
    #let glow(body, color: rgb("#40b864"), radius: 0.06em, copies: 10) = box({
      for i in range(copies) {
        let a = i / copies * 360deg
        place(dx: radius * calc.cos(a), dy: radius * calc.sin(a),
          text(fill: color.transparentize(88%), body))
      }
      text(fill: color, body)
    })

    #v(-1em)
    
    #let line(color, en) = {
      glow(color: color)[#en]
    }

    #block[
      #align(left)[

        #glow(color: rgb("#7fb89a"), text(size: 1.5em)[0. Utilities]) #h(1.5em) #glow(color: rgb("#7fb89a"),text(size: 1.0em)[实用程序])
        #linebreak()
        #glow(color: rgb("#cc9f55"), text(size: 1.5em)[1. The Shell]) #h(1.5em) #glow(color: rgb("#cc9f55"),text(size: 1.0em)[外壳/解释器])
        #linebreak()
        #glow(color: rgb("#bc6142"), text(size: 1.5em)[2. The Kernel]) #h(1.5em) #glow(color: rgb("#bc6142"),text(size: 1.0em)[内核])

      ]
    ]
  ]
]
#text(size: 0.8em)[
  哦对了说到递归命名法：

  GNU is Not Unix.
  
  YAML is Ain't Markup Language.
  
  Wine Is Not an Emulator.

]


== 在接下来的七年里

GNU项目从头开始完成了大部分工作：
  #columns(2, gutter: 1em)[
    #box(
      radius: 6pt,
      clip: true,
      image("/assets/image-7.png", width: 100%)
    )
    #text[GCC 编译器]

    #box(
      radius: 6pt,
      clip: true,
      image("/assets/image-12.png", width: 98%)
    )
    #text[Bash Shell]
]
#v(1em)
......以及众多coreutils（核心工具集）。但他们一直缺少一个关键组件 —— 内核。

== 与此同时，赫尔辛基 (1991)

芬兰赫尔辛基大学的学生 Linus Torvalds（林纳斯·托瓦茲）想在自己的 386 上跑一个自由的 Unix：MINIX 只许教学使用、不许修改，GNU 的内核又迟迟不来。

于是他决定自己写一个 —— 从终端仿真器写起，写着写着，写成了内核。8 月 25 日，他在 Usenet 新闻组发了条帖子：

#align(center)[
#block(
  width: 88%,
  fill: rgb("#16181b"),
  inset: (x: 22pt, top: 16pt, bottom: 18pt),
  radius: 6pt,
  stroke: 1pt + rgb("#282e34"),
)[
  #set text(
    font: ("Cascadia Code", "DejaVu Sans Mono", "Consolas", "Courier New"),
    size: 10.5pt,
    fill: rgb("#e7fcff"),
  )
  #set smartquote(enabled: false)
  #set par(leading: 0.75em, justify: false)

  #text(fill: rgb("#7d8590"), size: 9pt)[
    From: torvalds\@klaava.Helsinki.FI (Linus Benedict Torvalds) \
    Newsgroups: comp.os.minix · 25 Aug 1991
  ]

  #v(6pt)

  Hello everybody out there using minix —

  I'm doing a (free) operating system (*just a hobby, won't be big
  and professional like gnu*) for 386(486) AT clones. ...
]
]

== 你可能不知道 Linus 是谁，但你一定见过这张图

#grid(
  columns: (0.72fr, 1fr),
  gutter: 1.5em,
  [
    #image("/assets/image-8.png", width: 100%)
    #v(-0.4em)
    #set par(justify: false)
    #text(size: 0.73em)[2012 年，阿尔托大学。被问到 NVIDIA 显卡的 Linux 驱动支持，Linus 答：#text(fill: rgb("#179299"), weight: "bold")[「NVIDIA 是我们接触过的最糟糕的公司。」]随后竖起了中指。]
  ],
  [
    #text(size: 0.7em, fill: rgb("#6c6f85"), tracking: 0.08em)[1969 生于赫尔辛基 · Linux 与 Git 的作者]
    #v(0.05em)
    #text(size: 1.45em, weight: "bold")[Linus Torvalds]
    #v(0.15em)
    #text(size: 0.8em)[21 岁写下 Linux 内核；2005 年用两周写出 Git。今天，Linux 跑在 Android、云计算和超算上。]
    #v(0.15em)
    #text(size: 0.76em)[脾气火爆，但对代码较真到近乎苛刻。]
  ],
)

#v(1.25em)


#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 1.6em,
  [
    #line(length: 100%, stroke: 1.2pt + rgb("#179299"))
    #v(0.15em)
    #text(size: 0.75em, weight: "bold")[Talk is cheap. Show me the code.]
    #v(0.05em)
    #text(size: 0.72em)[空谈无益，放码过来。]
  ],
  [
    #line(length: 100%, stroke: 1.2pt + rgb("#179299"))
    #v(0.15em)
    #text(size: 0.8em, weight: "bold")[Just for fun.]
    #v(0.05em)
    #text(size: 0.72em)[只是为了好玩。]
  ],
  [
    #line(length: 100%, stroke: 1.2pt + rgb("#179299"))
    #v(0.15em)
    #text(size: 0.75em, weight: "bold")[We don't break userspace.]
    #v(0.05em)
    #text(size: 0.72em)[内核可以变，但用户的程序不能坏。]
  ],
)

== 最后一块拼图

GNU 的零件箱万事俱备，只差内核 —— Hurd 却迟迟难产；而 Linus 的内核离开编译器和工具链，自己也跑不起来。

1992 年，Linux 改用 GPL 发布。二者拼合 —— 一个完全自由的操作系统诞生了。

#v(0.5em)

#align(center)[
#grid(
  columns: (auto, auto, auto, auto, auto),
  gutter: 1.6em,
  align: center + horizon,
  image("/assets/gnu.svg", width: 4em),
  text(size: 2.2em)[+],
  image("/assets/tux.png", height: 4.6em),
  text(size: 2.2em)[=],
  text(size: 1.3em)[*GNU/Linux*],
)
]

#v(0.5em)

后面的事你们都知道了：发行版遍地开花，然后是 Android、云计算、超算 —— 正是开头的那组数据。

== Unix 哲学

#quote(block: true)[
  Write programs that do one thing and do it well. \
  Write programs to work together. \
  Write programs to handle text streams, for that is a universal interface.

  #align(right)[—— Doug McIlroy，Unix 管道的发明人]
]

#v(0.5em)

*做一件事并把它做好；让程序互相协作；文本流是万能接口。*

没有“统计 404”这个命令 —— 但两个各只做一件事的小工具，一拼就是：

```bash
grep -x '404' status.log | wc -l
```



#focus-slide[
  不用先成为高手，才有资格提问；\
  也不用等谁的许可，才轮到你动手。
]
