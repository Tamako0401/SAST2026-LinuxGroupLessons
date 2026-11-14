---
theme: default
title: 运维组第二次授课
layout: lesson-section
class: lesson-cover
colorSchema: auto
aspectRatio: 16/9
transition: slide-left
fonts:
  provider: none
  sans: '"Microsoft YaHei UI", "PingFang SC", "Noto Sans CJK SC", sans-serif'
  mono: '"JetBrains Mono", "Cascadia Code", Consolas, monospace'
defaults:
  layout: lesson-section
---

<div class="course-label">今天吃什么</div>

# 只学够用的 Linux

命令、权限、软件包与远程

讲师 Y11Han


<script setup>
import { coverGreetSteps } from './demos/cover-greet.js'
</script>

<NotebookDemo :steps="coverGreetSteps" />

<img class="cover-illustration" src="/cover-illustration.png" alt="嘉然今天吃什么" />


---
class: lesson-page-two
---

<div class="course-label">Turn back the clock to...</div>

# 上节课讲了什么

- **提问的智慧** · 提问时带上环境、命令和原始报错。
- **终端 ≠ Shell** · 终端接收输入并显示输出，Shell 负责解释命令。
- **Unix 哲学** · 把小工具的文本输入和输出接起来。


<div class="lesson-callout">上节课结尾那条 <code>grep -x '404' status.log | wc -l</code> 还是黑盒 —— 今天拆开它，顺便真正上手 Shell。</div>


<script setup>
import { blackBoxSteps } from './demos/black-box.js'
</script>

<NotebookDemo :steps="blackBoxSteps" />

<!-- 上节课我们学了三件事：......  
这三件事，其实说明了一个道理：我们不是在背一份软件操作手册，而是在学习怎么进入一个庞大的协作系统。「HTTPS是HTTP的复数」......  
上节课结尾那条......
 -->
---

<div class="course-label">序</div>

# 今天讲八件事

<div class="course-agenda">
  <div class="agenda-prereq"><b>00</b> 环境就绪 <small>前置</small></div>
  <div><b>01</b> Shell 与求助 <small>提示符、补全、查手册</small></div>
  <div><b>02</b> 目录、文件与权限 <small>路径、目录、执行位</small></div>
  <div><b>03</b> 复制、移动、删除 <small>建目录、改名、确认删除目标</small></div>
  <div><b>04</b> 查看与编辑 <small>看日志、保存退出</small></div>
  <div><b>05</b> 管道与特殊符号 <small>通配符、重定向、管道</small></div>
  <div><b>06</b> 软件包管理 <small>软件源、安装、发行版</small></div>
  <div><b>07</b> 服务与远程 <small>服务启停、SSH 登录</small></div>
</div>

<div class="lesson-quote">「伟大的工程不一定诞生于少数天才的封闭设计，也可能诞生于无数普通参与者<b>持续、公开、有序</b>的协作。」</div>


<!-- Linux 和它的发行版就是一个伟大的工程 —— 它不是哪家公司关起门来设计出来的。<br> 1991 年，芬兰大学生Linus在新闻组里发帖称：自己因爱好制作了一个不专业的"小内核"。三十多年过去，这个"做不大"的内核跑在全世界绝大多数服务器和超级计算机上。这中间没有一个天才画好全部图纸，而是成千上万个普通程序员——写内核的、打包的、写文档的、在论坛回答问题的 —— 持续、公开、有序地协作出来的。<br> 这节课展开的，从内核到软件源里的每一个包，都是这场<b>协作</b>的成果。
-->
---


<div class="course-label">00 · 环境就绪</div>

# 获得一个 GNU / Linux 环境 或 Unix like 环境
<div style="height: 0.2rem"></div>

如果想重从零开始安装到物理机 / 虚拟机：关注 `mirrors.njupt.edu.cn` 谢谢喵（或者去掉`pt`使用）

如果你不想~~删掉 Windows~~，那么可以看看 [WSL](https://learn.microsoft.com/en-us/windows/wsl/install)

如果你想加入 ~~Ache~~ Arch Linux 邪教，那么...你一定要珍惜生命呀大哥哥！(Its a joke.)

<br>

**Windows vs. Linux**  
内在复杂度 vs. 外在复杂度  
习惯 Linux 操作后，你会感觉到 Windows 是多么难用  
在使用的过程中，你会不可避免的遇到各种问题，但是在解决这些问题的过程中，你会更加深入的理解操作系统及计算机的原理...

---

<div class="course-label">01 · Shell 与求助</div>

# 映入眼帘

<div class="lesson-callout">不同的 Distro 会使用不同的 Default Shell。</div>

Ubuntu、Debian 等发行版默认用 **Bash**；Kali 、macOS（Darwin😭）终端默认是 **zsh**。

Shell 是可以更换的。常用命令写法都一样，只有**提示符结尾**不同：Bash 是 `$`，zsh 是 `%`。


~~~bash
# 回答：你是谁，你在哪，OS 信息
whoami
pwd
head -n 2 /etc/os-release
~~~


WTF is `user@ubuntu:~$`？

<!-- todo -->

---

<div class="course-label">01 · Shell 与求助</div>

# 提示符

~~~text
student@ubuntu:~/sast-lab2$
~~~

| 看到的部分 | 它告诉你什么 |
|---|---|
| `student` | 当前用户名 |
| `ubuntu` | 主机名。讲 SSH 时再看这一段 |
| `~/sast-lab2` | 当前目录。`~` 表示自己的家目录 |
| `$` | Bash 常见的普通用户提示符。root 常用 `#` |

提示用户 从 `$` / `#`后面开始输入命令。顺带一提，CMD的官方译名是「命令提示符」。

<!-- echo "\$BASH_VERSION"  
echo "$SHELL" -->

---

<div class="course-label"> 01 · Shell 与求助</div>

# 怎么读一条命令

~~~bash
head -n 5 status.log
~~~

| 部分 | 作用 |
|---|---|
| `head` | 调用哪个命令 |
| `-n 5` | 选项(参数) 及它的值。这里是取 5 行 |
| `status.log` | 操作对象。这里是要读的文件 |

`ls -a` 和 `ls --all` 作用相同。`-` + 缩写； `--` + 全拼

<!-- E1 · 让学生指出 ls -l /tmp 的命令、选项和操作对象。解释命令名和路径区分大小写。此页只读示例，日志稍后再建。 -->

---

<div class="course-label"> 01 · Shell 与求助</div>

# 补全 && 查帮助

| 想做什么 | 键入 |
|---|---|
| 补全路径 | 输入 `ls /us` 后按 **Tab** |
| 找回上一条命令 | 按 **↑**，和玩 mc 一样 |
| 停止前台命令 | 按 **Ctrl+C** |
| 看选项 / 参数怎么用 | `ls --help` 快查，`man ls` 慢查（**man**ual not MAN） |

在 `man` 里输入 `/sort` 搜索，按 `n` 找下一处，按 `q` 退出。

<!-- E1 · 可先跑 sleep 3，让大家观察提示符什么时候回来。再跑 sleep 100，让学生先猜 Ctrl+C 会发生什么。man 不可用时直接用 ls --help。 -->

---

<div class="course-label"> 02 · 目录、文件与权限</div>

# 路径从哪里开始？

| 写法 | 起点 |
|---|---|
| `/tmp` | 从根目录 `/` 开始，当前位置变了也能找到 |
| `logs/status.log` | 从当前目录开始，换个位置可能就找不到 |
| `~/sast-lab2` | 从自己的家目录开始 |
| `.` 与 `..` | 当前目录和上一级目录 |

~~~bash
pwd
cd / && ls
cd ~ && pwd
cd ../
~~~

<!-- E2 · 先把 / 比作整棵目录树的根，再说明 Ubuntu 不按 C:、D: 切换盘符。pwd 验证每次 cd 后的位置。 -->

---
routeAlias: filesystem-hierarchy
---

<div class="course-label"> 02 · 目录、文件与权限</div>

# FHS（文件系统层次结构标准）

<figure class="fhs-overview">
  <img src="/fhs/overview.webp" alt="原文的 Linux 目录总览。从根目录 / 展开，列出 /bin 的命令、/etc 的配置，以及 /usr 和 /var 的子目录。" />
  <figcaption>从 <code>/</code> 出发，按用途找文件。多个文件系统可以挂到树上的不同位置，如 <code>/mnt/data</code>。</figcaption>
</figure>

<!--
从顶上的 / 开始，举例：/bin/ls、/etc/hosts、/usr/share/man、/var/log。目录用途是 FHS 的分工。  
Linux 路径不以 C:、D: 来区分磁盘。系统分区提供 /，另一块盘的分区挂在 /mnt/data，文件就通过 /mnt/data/report.txt 访问。用 lsblk -f 或 findmnt 来只读查看。  
开 Termius 拿几台机器看一下 fdisk
-->

---

<div class="course-label"> 02 · 目录、文件与权限</div>

# 从 <code>/</code> 看 <code>/boot</code>、<code>/bin</code> 和 <code>/sbin</code>

<div class="fhs-gallery fhs-system">
  <figure>
    <figcaption><code>/</code> · Arch Linux</figcaption>
    <img src="/fhs/root.webp" alt="Arch Linux 根目录的文件列表，其中 bin 和 sbin 指向 usr/bin，lib 指向 usr/lib。" />
  </figure>
  <div class="fhs-stack">
    <figure>
      <figcaption><code>/boot</code> · 启动文件</figcaption>
      <img src="/fhs/boot.webp" alt="Omarchy 的 boot 目录，包含 EFI、loader 和 Limine 配置文件。" />
    </figure>
    <figure>
      <figcaption><code>/bin</code>、<code>/sbin</code> · 符号链接</figcaption>
      <img src="/fhs/symlinks.webp" alt="作者的 Arch Linux 中，/bin 和 /sbin 都指向 /usr/bin。" />
    </figure>
    <p>传统上 <code>/bin</code> 放常用命令，<code>/sbin</code> 放系统管理命令。图里的系统把两者都链接到 <code>/usr/bin</code>。</p>
  </div>
</div>

<!--
左图找到 /etc、/home 和 /root，再找带箭头的 /bin、/lib、/sbin。通过 /bin 看到的是 /usr/bin 里的内容，这是符号链接，与把另一块盘挂到(mount)目录是两回事。
-->

---

<div class="course-label"> 02 · 目录、文件与权限</div>

# 已安装的资源放在 <code>/usr</code>，变化的数据放在 <code>/var</code>

<div class="fhs-gallery">
  <figure>
    <figcaption><code>/usr</code> · 命令、库、共享资源</figcaption>
    <img src="/fhs/usr.webp" alt="Arch Linux 的 /usr，展示 bin、include、lib、local、share 等子目录。" />
    <p><code>bin/</code> 常用命令 · <code>lib/</code> 库 · <code>share/</code> 共享资源</p>
  </figure>
  <figure>
    <figcaption><code>/var</code> · 运行中会变化的数据</figcaption>
    <img src="/fhs/var.webp" alt="Arch Linux 的 /var，展示 cache、lib、log、spool、tmp 等子目录。" />
    <p><code>log/</code> 日志 · <code>cache/</code> 缓存 · <code>spool/</code> 队列</p>
  </figure>
</div>


<!--
/usr 举例可以指 /usr/share/man，和前面使用 man 呼应。/var 举例指 /var/log。  
/var/tmp 的内容通常比 /tmp 保留更久，但两者都不适合作为长期存储。
-->

---

<div class="course-label"> 02 · 目录、文件与权限</div>

# No way 2 escape（路径迷宫）

~~~bash
mkdir -p ~/sast-lab2/a/b/c
cd ~/sast-lab2/a/b/c
pwd
~~~

~~~text
~/sast-lab2/
└── a/
    └── b/
        └── c/  ← 你在这里
~~~

怎么回到 `~/sast-lib2/a` ?

`cd ..` OR `cd ~` OR `cd -`

<!-- 讲完了文件系统了，现在回到home -->

---

<div class="course-label"> 02 · 目录、文件与权限</div>

# 建目录、建文件

~~~bash
cd ~/sast-lab2
mkdir -p logs
touch logs/status.log
ls -l logs
~~~

- `mkdir -p` 可以一次建好缺少的父目录（`-p` 递归）。
- `touch` 会创建不存在的文件。文件已存在时，它更新文件时间。
- `ls -la` 列出目录里的文件（含隐藏文件），包含类型、权限、所有者和大小。
- 要按名字找文件，可以用 `find . -name 'xxx'`。


---

<div class="course-label"> 02 · 目录、文件与权限</div>

# 权限 && `ls -l` 的第一列

<div class="permission-grid" aria-label="权限字段示例">
  <div><code>-</code><span>文件类型</span></div>
  <div><code>rwx</code><span>所有者</span></div>
  <div><code>r-x</code><span>所属组</span></div>
  <div><code>r-x</code><span>其他用户</span></div>
</div>

- 第一位常见 `-` 普通文件、`d` 目录、`l` 符号链接。
- 后三组各占三位。`r` 读、`w` 写、`x` 执行，`-` 表示这一位未授予。
- **普通文件**的 `x` 表示允许执行，**目录**的 `x` 表示允许进入或按名字访问里面的条目。

<div class="lesson-callout"><code>r = 4</code>，<code>w = 2</code>，<code>x = 1</code>。<code>rwx</code> 是 <code>7</code>，<code>r-x</code> 是 <code>5</code>，所以图中是 <code>755</code>。</div>

<!-- 按图所示的权限，只有所有者拥有写权限 -->

---

<div class="course-label"> 02 · 目录、文件与权限</div>

# 权限数字

<div class="permission-key" aria-label="单组权限的数字对照">
  <div><strong>0</strong><code>---</code></div>
  <div><strong>1</strong><code>--x</code></div>
  <div><strong>2</strong><code>-w-</code></div>
  <div><strong>3</strong><code>-wx</code></div>
  <div><strong>4</strong><code>r--</code></div>
  <div><strong>5</strong><code>r-x</code></div>
  <div><strong>6</strong><code>rw-</code></div>
  <div><strong>7</strong><code>rwx</code></div>
</div>

| 模式 | 所有者 / 所属组 / 其他 | 谁用 |
|---|---|---|
| `600` | `rw- --- ---` | 私人文件，只有所有者能读写 |
| `644` | `rw- r-- r--` | 普通文档，所有者能改，其他人能读 |
| `700` | `rwx --- ---` | 私人目录，只有所有者拥有权限 |
| `755` | `rwx r-x r-x` | 可执行文件，其他人能读和执行，不能改 |

<div class="lesson-quote">例：<code>chmod 644 logs/status.log</code> 设置三组权限；<code>chmod u+x 文件</code> 只给所有者加执行位。</div>

---

<div class="course-label"> 02 · 目录、文件与权限</div>

# 从文件权限到系统策略

| 机制 | 它检查什么 | 举例 |
|---|---|---|
| **DAC** · 自主访问控制 | 按用户身份和文件权限判断。所有者通常能调整权限 | 用 `chmod` 设置所有者、所属组和其他人的 `rwx` |
| **POSIX ACL** · 访问控制列表 | 在 DAC 内细分权限，可以给指定用户或组单独授权 | 单独允许同桌读取文件，用 `getfacl` 查看 |
| **MAC** · 强制访问控制 | 由系统策略限制进程能访问什么 | AppArmor 可禁止某个程序读取特定路径 |

<div class="lesson-callout"><code>sudo rm -rf /*</code> 即使 <code>rwx</code> 这一关允许，AppArmor 或 SELinux 的策略仍可能拒绝访问。</div>

<!-- 平时看到的 rwx（读、写、执行）是DAC，它是基础规则。文件归谁，谁就能决定别人能不能看；如果想精细调整权限，可以用 POSIX ACL 给特定的人单独“开小灶”授权。  
但光有这些还不够，系统底层还加了一道硬性防线（MAC，比如 Ubuntu 里的 AppArmor），哪怕你是文件主人，违规越界的操作一样会被系统拦下来。  
至于 sudo，你可以把它理解成“临时借用管理员（默认是 root）的身份去执行某条指令”。后面我们用 apt 装软件时，因为要改动系统级文件，就经常得请它出马。
-->

---

<div class="course-label">03 · 复制、移动、删除</div>

# 文件操作、目录操作、重命名

~~~bash
mkdir dest                         # 建一层目录
mkdir -p src/logs/archive          # 补齐缺少的父目录
touch src/notes.txt src/.draft
~~~

| 对象 | 复制 | 移动 | 删除 |
|---|---|---|---|
| 文件 | `cp src/notes.txt backup.txt` | `mv backup.txt dest/` | `rm -i dest/backup.txt` |
| 整个目录 | `cp -R src copy` | `mv copy dest/` | `rm -ri dest/copy` |

**重命名** · `mv src/notes.txt src/readme.txt`。同一目录里换个名字，目录也能这样改名。

<div class="lesson-callout"><code>cp -R</code> 和 <code>rm -r</code> 处理子目录。<code>mv</code> 移动目录时会带上整棵子树，无需递归选项。</div>

<!-- 覆盖同名目标前可用 cp -i 或 mv -i 询问 -->

---

<div class="course-label">03 · 复制、移动、删除</div>

# 复制目录内容，带上隐藏文件

~~~bash
mkdir with-dotfiles without-dotfiles
cp -R src/. with-dotfiles/
cp -R src/* without-dotfiles/
~~~

| 源路径 | 命令收到什么 | 用 `ls -A` 查看目标 |
|---|---|---|
| `src/.` | `src` 目录本身，`cp -R` 递归读取全部内容 | `.draft`　`logs`　`readme.txt` |
| `src/*` | Bash 先展开当前层匹配的名字，默认跳过点开头的条目 | `logs`　`readme.txt` |

<div class="lesson-callout">要把 <code>src</code> 里的内容完整复制进已有目录，用 <code>cp -R src/. dest/</code>。</div>


---

<div class="course-label">04 · 查看与编辑</div>

# 看日志文件

| 目的 | 命令 |
|---|---|
| 看开头 5 行 | `head -n 5 access.log` |
| 看末尾 5 行 | `tail -n 5 access.log` |
| 搜索并翻看 | `less access.log`，输入 `/{你想查找的内容}`，按 `q` 退出 |
| 持续看新写入的行 | `tail -f access.log`，按 **Ctrl+C** 停止 |

<div class="lesson-quote">例：<code>echo "114514" >> xxxxx</code>。</div>

<!-- 开终端，home目录，less m.m，/error  
在m.m追加一些东西 -->

---

<div class="course-label">04 · 查看与编辑</div>

# 写一行文字，保存，再退出

| 编辑器 | 从打开到退出 |
|---|---|
| `nano test.txt` | 输入文字 → **Ctrl+O** → **Enter** 确认文件名 → **Ctrl+X** 退出 |
| `vim test.txt` | 普通模式按 `i` → 插入模式输入 → **Esc** → 键入 `:wq` → **Enter** |

~~~bash
cat test.txt
~~~

回到提示符后用 `cat` 验证。Vim 里想放弃未保存的修改，可以用 `:q!`。

---

<div class="course-label">05 · 管道与特殊符号</div>

# 星号由 Shell 展开

刚才提到了通配符
~~~bash
cd ~/sast-lab2
touch demo-a.log demo-b.log 'demo notes.txt'
printf '<%s>\n' *.log

name='demo notes.txt'
printf '<%s>\n' "$name"
~~~

- `*.log` 会展开成当前目录里匹配的文件名。这里会看到 `demo-a.log` 和 `demo-b.log`，已有的匹配文件也会列出来。
- `"$name"` 仍会展开变量，带空格的文件名作为一个参数传给命令。
- `'$name'` 会原样保留字符 `$name`。


---
routeAlias: standard-streams
---

<div class="course-label">05 · 管道与特殊符号</div>

# 三条标准通道

<div class="standard-streams">
  <div><code>0</code><strong>stdin</strong><span>标准输入 · 键盘 → 程序</span></div>
  <div><code>1</code><strong>stdout</strong><span>标准输出 · 程序 → 屏幕</span></div>
  <div><code>2</code><strong>stderr</strong><span>标准错误 · 程序 → 屏幕</span></div>
</div>

<script setup>
import { standardStreamSteps } from './demos/standard-streams.js'
</script>

<NotebookDemo :steps="standardStreamSteps" show-stream-labels />

<div class="lesson-callout"><code>0&lt;</code> 可以简写成 <code>&lt;</code>，<code>1&gt;</code> 可以简写成 <code>&gt;</code>，重定向标准错误要写 <code>2&gt;</code>。</div>

<!-- echo 'hello'：默认把 'hello' 发送给标准输出（1）。  
echo 'warning' >&2：这里的 >&2（完整写法是 1>&2）意思是“把当前命令的标准输出（1），复制到标准错误（2）所指向的地方”。因此 'warning' 被当成了错误信息发送出去。  
{ ... } 1> out.txt：花括号把两条命令打包成一个整体。外面的 1> out.txt 意思是“只把这个整体产生的标准输出（1）重定向到 out.txt 文件中”，而标准错误（2）不受影响，依然指向屏幕。  
讲完可顺带提 2>&1。 -->

---

<div class="course-label">05 · 管道与特殊符号</div>

# 输出到文件 OR 下一条命令

| 写法 | 标准输出去哪里 |
|---|---|
| `printf '%s\n' 200 > demo.log` | 写入文件。已有文件会被覆盖 |
| `printf '%s\n' 404 >> demo.log` | 追加到文件末尾。已有内容会保留 |
| `cat demo.log \| head -n 1` | 交给右侧命令当标准输入 |

~~~bash
printf '%s\n' 200 404 200 500 404 > status.log
cat status.log | head -n 3
~~~

普通 `|` 连接左侧的 **stdout** 和右侧的 **stdin**。

<!-- 提问，出现哪三行 -->

---
routeAlias: bash-notebook
---

<div class="course-label">05 · 管道与特殊符号</div>

# 时间线收束：一条管道，数出 404

选择一个单元，先预测输出，再运行 Bash。

<script setup>
import { statusLogSteps } from './demos/status-log.js'
</script>

<NotebookDemo :steps="statusLogSteps" />

看第二步到第三步的变化。`grep -x` 留下整行匹配，`wc -l` 数这些行。

<!-- E6 · 每个演示单元独立准备样本。运行统计单元前让学生先报答案。再问：把 404 改成 500，结果是多少？学生可在自己的实验目录改写命令。 -->

---

<div class="course-label">05 · 管道与特殊符号n</div>

# 下一条命令能不能执行

~~~bash
mkdir -p ~/sast-lab2/demo && cd ~/sast-lab2/demo
cd ~/sast-lab2/demo/lesson02-missing || printf '%s\n' '进不去'
~~~

- `&&` 看左侧是否成功。成功后才执行右侧。
- `||` 看左侧是否失败。失败后才执行右侧。
- `|` 把数据从左侧传给右侧，用在刚才的日志筛选和计数里。

你们学 C 语言肯定比我熟。

<!-- 你们学 C 语言肯定比我熟 -->

---

<div class="course-label">06 · 软件包管理</div>

# 软件包管理

**软件仓库 → APT → 本机**。软件源告诉 APT 去哪里取软件包和依赖。

~~~bash
sudo apt update
apt search cowsay
sudo apt install cowsay
cowsay 'Hello, Linux'
sudo apt remove cowsay
~~~

| 动词 | 在做什么 |
|---|---|
| `update` ／ `search` | 刷新本地索引 ／ 从索引里搜索包 |
| `install` ／ `remove` | 安装软件包 ／ 移除软件包 |


---

<div class="course-label">06 · 软件包管理</div>

# 先认发行版，再找包管理器

<div class="distro-grid">
  <div><img src="/distros/ubuntu.svg" alt="" /><strong>Debian / Ubuntu</strong><code>apt · .deb</code></div>
  <div><img src="/distros/archlinux.svg" alt="" /><strong>Arch Linux</strong><code>pacman · .pkg.tar.zst</code></div>
  <div><img src="/distros/fedora.svg" alt="" /><strong>Fedora / RHEL</strong><code>dnf · .rpm</code></div>
</div>

- **二进制包**通常由包管理器处理依赖和更新。**源码编译**适合需要定制构建选项时。
- **固定版本发布**如 Ubuntu LTS，有独立的大版本升级。**滚动更新**如 Arch，软件包持续更新。

<!-- 开场的 /etc/os-release -->

---

<div class="course-label">07 · 服务与远程</div>

# systemd：谁在管理服务？

在使用 systemd 的系统里，系统启动后由 `systemd` 作为 **PID 1** 运行，负责启动和管理服务。

~~~bash
cat /proc/1/comm
systemctl status cron
~~~

- 第一条看看 PID 1 是谁。
- 第二条查看服务。留意 `Loaded:`、`Active:`，按 `q` 退出分页。
- 同样是 Ubuntu，容器和部分 WSL 环境里 PID 1 也可能是别的程序。先以第一条的结果为准。


---

<div class="course-label">07 · 服务与远程</div>

# 现在在跑 vs. 开机启动

| 要改什么 | `systemctl` 命令 |
|---|---|
| 看当前状态 | `status cron` |
| 立即启动、停止、重启 | `start cron` ／ `stop cron` ／ `restart cron` |
| 设置或取消开机自启 | `enable cron` ／ `disable cron` |

~~~bash
systemctl is-active cron
systemctl is-enabled cron
~~~

这两条分别回答「现在运行吗」和「开机自启吗」。执行启动、停止或设置自启通常需要管理员权限。

<!-- enable 不会立即启动，disable 也不会立即停止。 -->

---

<div class="course-label">07 · 服务与远程</div>

# 三个「1」

| 写法 | 指的是什么 |
|---|---|
| `PID 1` | 进程编号 1。在讲师机上是 systemd |
| `UID 1` | 用户编号 1。Ubuntu 上通常是 `daemon`，root 的 UID 是 `0` |
| `/proc/1` | 内核提供的目录，里面是 **进程** 1 的信息 |

~~~bash
ps -p 1 -o pid,user,comm
getent passwd 1
cat /proc/1/comm
~~~


---
routeAlias: ssh
---

<div class="course-label">07 · 服务与远程</div>

# SSH：连接远程主机

远程主机开启 SSH 服务后，用**远程用户名**和**主机地址**从本机终端发起加密连接。

<div class="lesson-columns ssh-guide">
  <section>
    <h2>SSH · 运行命令</h2>
    <code class="ssh-command">ssh student@lab-ubuntu</code>
    <p><code>student</code> 是远程用户名，<code>lab-ubuntu</code> 是主机名，也可以填 IP 地址。</p>
    <p>连上后，命令在远程主机上执行。输入 <code>exit</code> 回到本机。</p>
  </section>
  <section>
    <h2>SFTP · 传输文件</h2>
    <code class="ssh-command">sftp student@lab-ubuntu</code>
    <p>通过 SSH 传文件，沿用同一套登录凭据。</p>
    <p><code>put 文件名</code> 上传，<code>get 文件名</code> 下载。</p>
  </section>
</div>

<div class="lesson-callout"><strong>登录凭据</strong>　按服务器的设置，用远程账户的密码，或用 SSH 密钥（公钥交给管理员，私钥自己保管）。</div>

<!-- E9 · 用自有练习机演示。目标主机要已开启 SSH 服务，并允许 SFTP。首次连接时先核对管理员给出的主机指纹。可用 hostname 对照本机与远端；SFTP 用 get 下载准备好的小文件。 -->

---
routeAlias: learning-resources
---

# 一些学习资料

<div class="lesson-columns learning-resources">
  <section>
    <h2>本课用到的资料</h2>
    <ul>
      <li><a href="https://www.zouht.com/4399.html" target="_blank" rel="noopener">《只学够用的 Linux》</a><span>授课参考，可从第 1.2–1.10 节复习。</span></li>
      <li><a href="https://sajidmahmood.com/linux-directories/" target="_blank" rel="noopener">Linux Directories Simplified</a><span>Sajid Mahmood 的目录结构配图与原文。</span></li>
      <li><a href="https://learn.microsoft.com/en-us/windows/wsl/install" target="_blank" rel="noopener">安装 WSL · Microsoft Learn</a><span>在 Windows 上准备 Linux 练习环境。</span></li>
    </ul>
  </section>
  <section>
    <h2>推荐阅读</h2>
    <ul>
      <li><a href="https://101.lug.ustc.edu.cn/" target="_blank" rel="noopener">Linux 101 · 中国科大 LUG</a><span>跟着中文教程练习文件、命令行与远程操作。</span></li>
      <li><a href="https://linuxcommand.org/tlcl.php" target="_blank" rel="noopener">The Linux Command Line</a><span>William Shotts 的命令行教材，有免费电子版。</span></li>
      <li><a href="https://web.stanford.edu/class/me228/pdf/cathedral-bazaar.pdf" target="_blank" rel="noopener">《大教堂与集市》</a><span>Eric S. Raymond 谈开源协作（英文原文 PDF）。</span></li>
    </ul>
  </section>
</div>
