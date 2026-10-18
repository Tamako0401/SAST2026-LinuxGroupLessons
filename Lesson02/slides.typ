#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#import "../catppuccin-latte.typ": catppuccin-latte-colors
#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => text(size: 0.6em, fill: gray)[SAST 运维/Linux 组 · 2026 · 第二课],
  config-info(
    title: [把 Linux 装进一个可恢复的环境],
    subtitle: [虚拟机、镜像站与第一次 Shell 实验],
    author: [SAST 运维/Linux 组],
    date: [2026 年秋 · 授课打样],
    institution: [南京邮电大学 SAST],
  ),
  catppuccin-latte-colors,
)
#set text(font: ("Segoe UI", "Source Han Sans SC"), lang: "zh")
#show raw: set text(font: ("JetBrains Mono", "Source Han Sans SC"))
#title-slide()

== 今天完成三个闭环

+ *获得环境*：能登录 Ubuntu，确认版本与架构。
+ *完成任务*：创建文件、统计日志、解释结果。
+ *能够恢复*：保存基线，知道变更失败怎么退回。

Windows x86_64：VMware + Ubuntu Desktop 24.04 LTS。

其他设备按课前分流方案走；不因设备条件而降低学习评价。

== 开场检查：你现在在哪个位置？

- A：虚拟化软件 + ISO 已备齐，可以创建虚拟机。
- B：还在下载或安装软件，需要助教支持。
- C：Mac / ARM / WSL2 / 无电脑，按备用路线参与。

提交一个昨天的卡点：*目标、操作、原始错误、已尝试*。

检查点限定等待时间；少数卡点转助教或结对，不拖住全班。

= 创建与安装

== 为什么不从双系统开始？

#table(columns: (1fr, 1fr), inset: 8pt,
  [直接装到物理电脑], [安装到虚拟机],
  [涉及真实磁盘与引导], [使用文件形式的虚拟磁盘],
  [错误操作可能影响现有系统], [练习环境较容易重建],
  [切换可能要重启], [宿主机和客户机同时运行],
)

虚拟机降低风险，但共享目录、网络和粘贴命令仍可能影响外部。

课堂不添加物理磁盘，不做端口映射，不挂载重要宿主机目录。

== 四个对象，不要混淆

#table(columns: (auto, 1fr), inset: 8pt,
  [Host], [你的电脑和现有操作系统],
  [VMware], [提供虚拟硬件的程序],
  [Guest], [将安装的 Ubuntu 客户机系统],
  [ISO], [安装介质，不是安装后的虚拟硬盘],
)

*先在 VMware 里启动虚拟机，不从电脑 BIOS 启动 ISO。*

== Checkpoint ①：确认资源与架构

#table(columns: (auto, 1fr), inset: 7pt,
  [CPU], [1 个虚拟处理器 × 2 核即可],
  [内存], [Desktop 建议 4 GB；宿主机要留足余量],
  [虚拟磁盘], [40 GB 动态增长；另给 ISO、快照留空间],
  [网络], [NAT；保持网卡连接],
  [ISO], [24.04.x Desktop amd64；先核对 SHA256],
)

8 GB 宿主机提前试跑；低配置不硬撑桌面版，走备用路线。

== 创建 VM：只关注今天需要的选项

+ 新建 VM，选择稍后安装操作系统，避免自动安装跳过教学步骤。
+ Linux → Ubuntu 64-bit；资源按上一页配置。
+ 使用新的 *虚拟磁盘文件*，不选物理磁盘。
+ 在 CD/DVD 中挂载已校验的 ISO，启动客户机。

界面文字可能随 VMware 版本变化；详细步骤见 Markdown 手册。

已经支持 Hyper-V 的版本不必默认关闭 Windows 安全功能。

== Checkpoint ②：安装前的最后确认

+ 看到安装器后，选择交互式安装与默认应用集合即可。
+ 语言按习惯选；若要复现英文报错，可临时设置语言环境。
+ 安装目标必须是刚创建的 *约 40 GB 虚拟磁盘*。
+ 确认后才选择擦除磁盘安装；不确定就举手。
+ 用户名用小写英文，密码自行保存，不提交给讲师。

网络差时先离线安装；不在课堂强制下载系统更新或第三方驱动。

== 等待安装：不是所有人都要等到同一秒

*预计安装与重启窗口：25 分钟，允许机器差异。*

- 已进入安装等待：看下一段镜像站演示。
- 已装好：打开终端，确认身份和版本，先不自由改配置。
- 仍无法启动：转助教支持；到硬截止时间切换结对环境。

重启时按提示移除虚拟安装介质，避免又进入安装器。

= 镜像站与包管理

== ISO 与 apt 源，不是一回事

#link("https://mirrors.njupt.edu.cn/")[mirrors.njupt.edu.cn]

#table(columns: (auto, 1fr), inset: 8pt,
  [ISO], [安装介质；下载后用 SHA256 检查完整性],
  [apt 源], [软件包索引与软件包；apt 验证签名与哈希],
  [镜像站], [同步上游内容；同步状态和访问速度会变化],
)

哈希一致说明文件与清单一致；清单本身也要来自可信渠道。

不给“下载一定秒完”的承诺，不靠关闭校验解决报错。

== 登录后的第一次观察

```bash
whoami
pwd
cat /etc/os-release
dpkg --print-architecture
```

确认：在 *客户机* 里，Ubuntu 24.04，主线为 amd64。

ARM 路线应为 arm64；不是输出不同就算做错。

== 换源：先看配置，再改 URI

24.04 全新安装通常使用 deb822 格式：

```text
/etc/apt/sources.list.d/ubuntu.sources
```

+ 先读取，确认实际文件、架构与现有源。
+ 备份到 apt 配置目录之外；用 `sudoedit` 改 `URIs:`。
+ amd64 主仓可用 `https://mirrors.njupt.edu.cn/ubuntu/`。
+ 保留官方安全更新源；不动 `Suites / Components / Signed-By`。

*ARM 用 ubuntu-ports 路线；不要照搬 amd64，也不盲目 sed。*

== Checkpoint ③：验证，而不只是“点过了”

```bash
sudo apt update
```

- 查看是否成功获取索引，是否有错误或退回旧索引的警告。
- `update` 刷新包列表；`upgrade` 才升级已安装软件。
- 本节课不全班执行 `upgrade -y`，避免占满安装窗口。
- 更新失败：记录错误，必要时还原备份；不关闭签名验证。

安全更新仍需及时完成，可在课后联网维护窗口执行并读提示。

== 只装今天要用的东西

```bash
sudo apt install curl
```

VMware Desktop 如缺少集成功能，再安装：

```bash
sudo apt install open-vm-tools open-vm-tools-desktop
```

先读包管理器提示，再确认。共享剪贴板取决于客户机和宿主机设置。

网络不可用就先完成离线 Shell 实验，换源验证课后补交。

= 一个能做完、能解释的小实验

== 先找到自己的位置

```bash
pwd
ls
cd ~
```

- `/` 是根目录；`~` 是当前用户的家目录。
- 绝对路径从 `/` 开始；相对路径从当前目录开始。
- Tab 补全，↑ 查历史，Ctrl+C 中断，`q` 退出 less/man。

今天只在自己的练习目录操作，不碰系统目录和他人文件。

== 为每次实验创建一个新目录

```bash
lab=$(mktemp -d "$HOME/sast-lab.XXXXXX")
cd "$lab"
printf '%s\n' 200 404 200 500 404 > status.log
cat status.log
```

*预期：* 看到五行状态码；`pwd` 显示新建的练习目录。

`>` 会覆盖目标；这里使用全新目录，避免覆盖已有作业。

== 先预测，再执行

```bash
grep -x '404' status.log | wc -l
```

*预期：2。* 每行一个状态码，`-x` 要求整行匹配。

```bash
cp status.log status.copy
cmp status.log status.copy
```

`cmp` 相同则通常无输出；紧接着执行 `echo $?`，预期是 0。

== 查帮助，不是记住十几个命令

```bash
grep --help
man grep
```

在 man 中：`/pattern` 搜索，`n` 下一个，`q` 退出。

如果最小环境没有 man，先用 `--help` 或手册中的链接。

扩展题：把 404 换成 500，结果是多少？为什么？

== 一步失败之后，会发生什么？

```bash
false && printf '%s\n' 'this will not run'
```

右侧不执行，但左侧做过的事情不会被撤销。

*工程习惯：* 小步执行、看输出、查状态、再读结果文件。

`&&` 不是事务；管道的退出状态也不代表每个阶段都成功。

= 留下可恢复的基线

== Checkpoint ④：保存基线

+ 结束安装和包管理操作，关闭客户机。
+ VMware → 快照 → 拍摄快照，命名 `baseline-ready`。
+ 备注系统版本、架构、源配置与已安装工具。
+ 教师演示：创建测试文件 → 回滚 → 文件消失。

*回滚会丢弃快照之后的改动。重要笔记先另存。*

快照依赖原虚拟磁盘，不能抵御宿主机硬盘损坏，不是独立备份。

== 卡住时，按证据排查

#table(columns: (1fr, 1fr), inset: 7pt,
  [VM 无法启动], [记录版本、架构、虚拟化状态和完整错误],
  [访问不到镜像站], [检查网卡、路由、DNS、HTTPS，逐层区分],
  [apt 校验失败], [看时间、源配置和同步状态；不跳过校验],
  [没有共享剪贴板], [先手动输入，不让便利功能阻塞课程],
)

`ping` 不通不等于整个网络不通；ICMP 可能被限制。

== 交作业，不靠炫酷截图验收

*提交一个 Markdown 文件：*
+ 版本、架构与运行路线（VMware / UTM / WSL2 / 结对）。
+ 五行日志和统计结果 2，并解释 `|` 的作用。
+ apt 验证结果；失败则保留错误和下一步检查计划。
+ 快照或等价恢复办法，说明恢复会丢失什么。
+ 一条你遇到的问题与解决/未解决记录。

不要求公开 GitHub 仓库，不提交密码、Token 或私人信息。

#focus-slide[
  装好不是终点。\
  能解释、能验证、能恢复，才是起点。
]
