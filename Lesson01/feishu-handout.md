# 免责声明

本课程由 SAST 运维/Linux 组开设。我们不会强制要求任何人参与授课内容，不想听就可以不来。我们只对授课内容负责，对其他课程、各类考试或衍生的各类内容和理解均不负责。如果您要参加其他课程或各类考试，如内容有出入，请务必以该课程或考试指定的参考书或指导教师的解答为准。

本课程强调动手实践。讲义中出现的每一条命令，都需要亲手在终端里敲过一遍，才会真正成为你的东西；讲义只是索引，不能代替你的每一次回车。

# 授课安排

本次授课是 SAST 运维/Linux 组 2026 秋季系列课程的第一课（方草地公开课），内容包括「提问的智慧」与「初识 GNU/Linux」两个部分。课堂时间有限，只负责把方向和方法讲清楚，更深入的内容需要课后自行展开学习。

课后如有疑问，欢迎在群里或私聊讲师（群主和管理员）咨询——但请先读完本讲义的第一节再提问。这既是课程的内容，也是我们对提问方式的全部要求。

# 题外话

下面是几条与课程主旨一致的忠告：

- 学英语，用英语，尤其是计算机相关的表达。第一手资料和报错信息几乎全是英文。不要滥用全文翻译，这对学英语没有帮助，可以使用划词翻译。本讲义中的术语都会在首次出现时给出英文原文。
- 搜索时优先使用英文关键词和报错原文。能访问世界互联网就用 Google，否则用 Bing 国际版；尽可能减少使用 CSDN 等野生中文二手资料，上面的许多内容过时、片面甚至错误。查找资料时不能轻信没有可靠来源的内容。
- 不用先成为高手，才有资格提问；也不用等谁的许可，才轮到你动手。但提问之前请先付出努力——这正是本次课程的主题。

# 提问的智慧

## 什么样的提问没有人愿意回答

先看四个反例。以下任何一条，都会让你在未来四年里没有人愿意帮你：

- 先问「在吗」，等对方回复后才说正事；
- 报错信息靠拍屏，而且只拍最后一行；
- 搜索引擎都没打开过，先问路人，甚至是不加甄别的劣等模型；
- 在群里问「有人懂 xxx 吗」，而不是直接描述问题。

这类提问的共同点是：把本该由自己完成的沟通成本，全部转嫁给了回答者。两个极端的反面教材：[nohello.net](https://nohello.net/zh-cn/) 解释了为什么「在吗」是糟糕的开场；GitHub 上 [sherlock 项目的 issue #2011](https://github.com/sherlock-project/sherlock/issues/2011) 里，一位拒绝阅读说明、只索要「现成 EXE 文件」的用户对维护者破口大骂——这种态度不会换来任何帮助。

## 一个好问题长什么样

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

这个模板包含了一个技术问题应有的全部要素：完整的运行环境、明确的目标、报错的完整原文（复制为文本，而不是拍屏）、已经做过的排查，以及一个具体的问题。回答者不需要反复追问「你用的是什么系统」「报错到底是什么」，就可以直接切入定位问题。

## 提问之前：STFW、RTFM 与最小化复现

1. **STFW**（Search The Friendly Web，先搜索）。用英文关键词加报错原文搜索（Google > Bing > 百度）；报错信息要复制完整原文去搜，不要自己转述，更不要拍屏。搜索引擎给出的 AI 概览只能作为参考。
2. **RTFM**（Read The Friendly Manual，先读手册）。`man ls`、`tldr tar`、`命令 --help` 都是入口。资料可信度的大致排序：官方文档 > Stack Overflow > 个人博客 > 短视频 > AI 聊天模型。
3. **最小化复现**。把问题缩减到最小的可复现案例。往往缩着缩着，问题在哪一步引入的就已经清楚了，甚至直接自己解决了。

关于搜索引擎的选择：百度受商业因素所限，大概率返回与问题并非最相关的内容。进阶语法包括 `site:` 限定站点内搜索、`"双引号"` 精确匹配报错原文、`-` 排除干扰词、`*` 通配不确定的部分，以及限定时间范围。

一个案例：想了解 PyTorch 的向量叉乘怎么写。搜「pytorch 叉乘」，点开一篇 CSDN 教程，发现还要交钱；改搜 `pytorch cross product`，直接读到 pytorch.org 的官方文档——后者永远更全面、更透彻。上手新工具同理：直接搜官方文档，从 Getting Started 读起。

## 按问题选地方

| 遇到的情况 | 去哪查 |
| --- | --- |
| 报错看不懂、编译不过 | Stack Overflow（CSDN、知乎上不少内容搬运自这里） |
| 论文出处、引用格式 | Google Scholar |
| 想找现成的轮子 | GitHub 搜索 / Code Search，使用前先看许可证（LICENSE） |
| 上手新工具、新库 | 官方文档的 Getting Started |
| 学公开课 | 课程主页 → YouTube 讲解 → B 站 / 知乎补充 |

## 让信息能被搜索、复制、复现

- 命令和报错尽量用文本加代码块呈现，附上相关上下文；图形界面、启动画面等无法复制的内容，用清晰的截图也是合适的。
- 写明实际的软件版本和操作位置。
- 分享之前删去密码、Token、Cookie 和个人信息。
- 尝试用 Issue 反馈问题：Issue 天然是可检索、可沉淀的，后来的人能直接找到你的讨论。

## X–Y Problem

你想解决问题 X，你以为方案 Y 能解决它，于是你问「怎么实现 Y」——但 Y 根本就是错的方向。这就是 X–Y 问题（X–Y Problem）：它会掩盖真正的核心问题，甚至引入次生问题，导致沟通不畅和资源浪费。对提问者的对策是把自己的真实目的（X）一并说出来；对回答者的对策是主动追问「你需要这个做什么」，把对方从错误的方向上引导回来。参见[中文维基百科「XY问题」词条](https://zh.wikipedia.org/zh-cn/XY%E9%97%AE%E9%A2%98)。

## 与 AI 协作的边界

AI 生成的命令可能不存在、可能过时，编造参数和引用是常态。课程中提到过一个案例：有人放任 AI Agent 自主执行操作去扫描 DN42，最终产生了无法承受的账单。可以问 AI，但别让它替你负责：

- 让它解释错误、列出假设、建议**只读检查**，先核对再执行；
- 核对版本、查官方文档，确认生成的命令真实存在且没有过时；
- 执行前问清三件事：改哪里？会删什么？如何验证和恢复？
- 不上传密钥、个人数据和组内服务器配置。

一个可参考的提问方式：「先解释这条命令的作用与风险，再给出只读的检查步骤。」

## 提问之后

- 有人帮你解决了 → 回复结果：「解决了，是 xxx 的原因」。让答案沉淀下来，后来的人能搜到。
- 没人理你 → 补充信息后再发一次，而不是刷屏。
- 被回复 RTFM → 别玻璃心，这是指路而不是嘲讽——意思是文档里写得清清楚楚，读完再来。

交流当然值得鼓励，但提问之前先付出努力；即使问了，主动权也始终在你手里：对方没有义务替你解决，继续自己找答案也许依然需要。

最后是一点分寸：《提问的智慧》帮助我们减少沟通成本，《如何像弱智一样提问》用反例警示。读它们时不必接受其中所有语气，更不能拿后者的标题去称呼同学。你可以问基础问题，可以说「我还不知道该提供什么信息」；回答者也应给出具体方向，不能用一句 RTFM 代替教学。

## 延伸阅读

- 《提问的智慧（How To Ask Questions The Smart Way）》中文版：https://github.com/ryanhanwu/How-To-Ask-Questions-The-Smart-Way
- SAST Skill Docs《如何解决问题》：https://docs.net9.org/basic/meet-problems/

# 计算机教育中缺失的一课

你的培养方案里有：高等数学、线性代数与解析几何、C 语言、数据结构……但没有任何一门课教你：

- 怎么熟练使用命令行和 Shell；
- 怎么用编辑器高效地修改代码；
- 怎么用 Git 管理代码，而不是靠「最终版v2(1).zip」和「代码.docx」；
- 怎么调试程序、怎么跨越网络边界检索资料、怎么保护隐私。

MIT 有一门课专门补这个缺口：《计算机教育中缺失的一课》（The Missing Semester of Your CS Education），已有完整的中文版：[missing-semester-cn.github.io](https://missing-semester-cn.github.io/)。课程共八讲：

1. 课程概览与 Shell 入门
2. 命令行环境
3. 开发环境与工具
4. 调试与分析（Debugging and Profiling）
5. 打包与发布（Packaging and Shipping Code）
6. 智能体编程
7. 不止于代码
8. 代码质量

建议在跟进本系列课程的同时，把这门课完整地自学一遍。

# 初识 GNU/Linux

## 为什么是 Linux

你身边早就是 Linux 的世界：你的 Android 手机、你访问的每一个网站背后的服务器、学校的选课系统和镜像站、你家的门锁和路由器。一组数据：

- 全球 Top 500 超级计算机：100% 运行 Linux；
- 大模型与训练集群：100% 运行 Linux；
- 公有云服务器：90% 以上是 Linux；
- 全球基于 Linux 内核的设备：约百亿台。

桌面之外，从掌心设备到云端算力，再到算力巅峰的超算与 AI 集群，人类几乎所有的现代计算底座都跑在 Linux 上。你以后写的代码，大概率最终运行在 Linux 上——所以不要把它当成「极客的玩具」。

## 内核、发行版与包管理器

Linux 只是内核（Kernel），即系统中负责硬件调度与资源管理的核心部分。你真正能安装上手的，是发行版（Distribution）：把内核、GNU 工具、包管理器（Package Manager）和安装器打包好的成品系统。

| 发行版家族 | 代表成员 | 包管理器 |
| --- | --- | --- |
| Debian 系 | Debian、Ubuntu、Mint 等 | `apt` |
| Red Hat 系 | Fedora、RHEL、CentOS 等 | `dnf` |
| Arch 系 | Arch、Manjaro（滚动更新） | `pacman` |
| 另类 | Android：Linux 内核 + 一套完全不同的用户态 | —— |

各家族的区别主要在包管理器和更新策略，命令不同、思路一样；Android 与它们共用同一个内核，但用户态（User Space，即内核之外的系统部分）完全不同，所以 App 不能直接搬过来。下载发行版镜像可以使用校内镜像站：`mirrors.njupt.edu.cn`。

## 终端与 Shell

终端（Terminal）是那个黑窗口，只负责显示和键盘输入；Shell 才是真正理解并解释命令的程序（Bash、Zsh、Fish 等）。我们输入的命令大部分不是由 Shell 自己运行的，而是由 Shell 去执行对应名字的程序，并转达其输入输出；也有一部分命令由于设计或性能原因是 Shell 内置的。

以虚拟机场景为例，从硬件到命令的层次是：

```text
宿主机：你的电脑
└─ VMware（虚拟化软件）
  └─ Guest：一台虚拟电脑
    └─ Ubuntu（发行版）
      └─ 终端（窗口）
        └─ Bash（Shell）
```

可以自己验证：在终端里执行 `echo $SHELL` 查看当前 Shell，执行 `bash --version` 查看 Bash 版本——顺便想一想，这两条命令是窗口执行的，还是 Shell 执行的？SSH 连接服务器时用的就是纯终端环境，对面往往连桌面都没有，这也是命令行是基本功的原因。

## 自由软件简史：从 Unix 到 GNU/Linux

六十年代末，AT&T 贝尔实验室的工程师们发明了名为 Unix 的操作系统，并将其广泛分享给各高校和研究机构——那是个自由分享源代码的年代。但到了八十年代，AT&T 在反垄断拆分后进入计算机市场，Unix 的源代码从此不再自由分享，甚至开始起诉衍生版本的开发者，被告里包括加州大学伯克利分校（BSD），这段冲突被称为 Unix 战争（Unix wars）。各机构只得在 Unix 的基础上开发自己的操作系统，形成了类 Unix（Unix-like）的生态。

理查德·斯托曼（Richard Matthew Stallman）是一位自由软件倡导者和程序员。为了回应源代码被封闭的局面，他辞去了 MIT 的工作，于 1985 年创立自由软件基金会（Free Software Foundation，FSF），致力于推广软件的四大基本自由（编号从 0 开始——程序员从 0 数数）：

- **自由 0**：出于任何目的运行软件的自由（Free to run it）；
- **自由 1**：研究软件工作原理并按需修改的自由（Free to study it）；
- **自由 2**：重新分发副本以帮助他人的自由（Free to share it）；
- **自由 3**：分发你修改后版本的自由（Free to change it）。

其中自由 1 和自由 2 的前提，都是使用者能够拿到源代码（Source Code）。这里的 free 指的是自由（free as in speech）而不是免费（free as in beer），务必区分。

为了把这些自由用法律固定下来，斯托曼设计了许可证（License）制度。GNU 通用公共许可证（GNU General Public License，GPL，1989 年发布第一版）的核心承诺有三条：自由而非价格（freedom, not price）；使用者必须能拿到源码或可以获取源码（receive source code or can get it）；可以赠送副本，也可以出售（give away or sell copies）。其核心机制是著佐权（Copyleft）：你可以修改 GPL 软件、可以商用，但当你分发时，必须继续以 GPL 授权，并继续向接收者提供源码。

GNU 项目（GNU's Not Unix，一个递归缩写；同类命名还有 YAML Ain't Markup Language、Wine Is Not an Emulator）的目标是从零开始复刻一个完全自由的类 Unix 系统。为此需要重构三层功能：实用程序（Utilities）、Shell 和内核（Kernel）。在接下来的七年里，GNU 项目完成了 GCC 编译器、Bash Shell 和众多核心工具（coreutils）——你们今天写 C 语言用的 gcc、默认开启的 bash，都来自这里——但始终缺少一个关键组件：它自己的内核 GNU Hurd 迟迟难产。

与此同时，1991 年，芬兰赫尔辛基大学 21 岁的学生 Linus Torvalds 想在自己组装的 386 电脑上运行一个自由的类 Unix 系统：MINIX 只许教学使用、不许修改，GNU 的内核又迟迟不来，于是他决定自己写。从终端仿真器写起，写着写着写成了内核。1991 年 8 月 25 日，他在 Usenet 的 comp.os.minix 新闻组发帖：

> I'm doing a (free) operating system (*just a hobby, won't be big and professional like gnu*) for 386(486) AT clones.

后来我们都知道了。2005 年，他又用两周时间写出了版本管理工具 Git——你们能交 Git 作业，某种程度上得谢谢他这两周。他有两句广为流传的话：Talk is cheap. Show me the code.（空谈无益，放码过来。）与 Just for fun.（只是为了好玩。）

至此只差最后一块拼图：GNU 的零件箱万事俱备，只缺内核，而 Hurd 迟迟难产；Linus 的内核离开编译器和工具链，自己也跑不起来。1992 年，Linux 内核改用 GPL 发布，二者拼合——一个完全自由的操作系统诞生了，严格地说应称为 GNU/Linux。后面的事情你们都知道了：发行版遍地开花，然后是 Android、云计算、超算——正是开头的那组数据。

## Unix 哲学

Unix 哲学（Unix Philosophy）的经典表述来自贝尔实验室的 Doug McIlroy（Unix 管道的发明人）：

> Write programs that do one thing and do it well.
> Write programs to work together.
> Write programs to handle text streams, for that is a universal interface.
> —— Doug McIlroy

做一件事并把它做好；让程序互相协作；文本流是通用接口。它意味着：没有「统计 404」这个命令，但两个各只做一件事的小工具，用管道（Pipe）一拼就有了：

```bash
grep -x '404' status.log | wc -l
```

`grep` 负责从文本中筛选内容为 `404` 的行，`wc -l` 负责计数，竖线 `|` 把前一个程序输出的文本流（Text Stream）接到后一个程序的输入上。小型、正交、可组合的工具，胜过一个无所不能的庞然大物——这也是贯穿整个 GNU/Linux 生态的设计品味。

## 课后补充：去哪里找「轮子」

「轮子」指所有已经被他人编写好、验证过、封装成模块并公开供人调用的代码与工具。你想造一辆自行车去上学，应该做的是购买车架、链条和变速器并组装，而不是从挖铁矿、炼钢开始。它们大致分三层：

- **基础函数 / 算法级**：求平方根不需要手写牛顿迭代法（直接调 `math.sqrt`），排序不需要每次手写快速排序；
- **通用库 / 工具级**：读写 Excel 文件、解析 JSON、发送 HTTP 请求、生成二维码；
- **框架 / 平台级**：搭建网站不需要从底层 Socket 通信写起（用 Spring Boot、Django、Express 或 Vue / React）。

为什么不要重复造轮子？个人时间极其有限；你自己造的轮子大概率是方的（漏洞百出、上线即崩溃），看不见的边界陷阱远比想象的多；自己维护的代码还可能引入安全性问题。每门主流编程语言都有官方或准官方的包仓库（Package Registry）：

| 语言 | 仓库 | 安装方式 |
| --- | --- | --- |
| Python | [PyPI](https://pypi.org/) | `pip install` |
| JavaScript / TypeScript | [npm](https://www.npmjs.com/) | `npm install` |
| Java | [Maven Central](https://central.sonatype.com/) | Maven / Gradle 引入 |
| C / C++ | [vcpkg](https://vcpkg.io/)、[Conan](https://conan.io/) | 各自的客户端 |
| Go | [Go Packages](https://pkg.go.dev/) | `go get` |
| Rust | [crates.io](https://crates.io/) | `cargo add` |

除此之外：[GitHub](https://github.com/) 是开源项目的聚集地，善用搜索语法（如 `stars:>1000 language:python topic:excel`）和 [Trending 趋势榜](https://github.com/trending)；Awesome 列表是社区精选合集，直接搜索 Awesome-Python、Awesome-Vue 等；Libraries.io 和 npm trends 用于查看依赖关系、维护活跃度和下载趋势。

AI 也可以辅助选型，前提是提出高质量的咨询，例如：

> 「在 Python 3.12 中，目前最成熟、维护最活跃的用于处理高并发 HTTP 请求的库是哪个？请对比前两名的优缺点和适用场景。」

# 这些资料是在哪找到的？

使用互联网和搜索引擎可以找到大部分资料。但需要注意的是，很多资料（尤其是一些野生中文互联网资料）存在片面、过时甚至错误的情况，查找资料时不能轻信没有可靠来源的内容。

许多书籍中也有大量资料而且相对权威。很多人可能只把图书馆当作自习室，但图书馆里除了教科书，还有很多可以借阅的其他书籍，计算机相关的藏书还是比较全面的。

对于某个特定软件和项目的资料，可以查阅它附带的手册（Manual）和文档（Documentation）。在 Linux 中，我们常用 `man`（以及 `info`，但后者不常用）命令来阅读手册，执行 `man <名字>` 就可以得到对应内容。

# 参考

- 《提问的智慧（How To Ask Questions The Smart Way）》中文版：https://github.com/ryanhanwu/How-To-Ask-Questions-The-Smart-Way
- nohello.net（中文版）：https://nohello.net/zh-cn/
- SAST Skill Docs《如何解决问题》：https://docs.net9.org/basic/meet-problems/
- MIT《计算机教育中缺失的一课》中文版：https://missing-semester-cn.github.io/
- GNU 项目关于自由软件的定义：https://www.gnu.org/philosophy/free-sw.html
- GNU 通用公共许可证第一版（GPLv1, 1989）原文：https://www.gnu.org/licenses/gpl-1.0.html
- 中文维基百科「XY问题」词条：https://zh.wikipedia.org/zh-cn/XY%E9%97%AE%E9%A2%98
- 南邮镜像站：https://mirrors.njupt.edu.cn
