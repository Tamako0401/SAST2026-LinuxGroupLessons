---
theme: default
title: 运维组第二次授课
layout: lesson-section
class: lesson-cover
colorSchema: light
aspectRatio: 16/9
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

讲师：Y11Han

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

- **提问的智慧** · 先 RTFM / ATFA，no hello，报错复制原文，学会截图。
- **终端 ≠ Shell** · 终端只负责显示，Shell 才真正解释命令。
- **Unix 哲学** · 做一件事并做好，文本流是万能接口。

<div class="lesson-callout">上节课结尾那条 <code>grep -x '404' status.log | wc -l</code> 还是黑盒 —— 今天拆开它，顺便真正上手 Shell。</div>

<script setup>
import { blackBoxSteps } from './demos/black-box.js'
</script>

<NotebookDemo :steps="blackBoxSteps" />

<!-- 三条各对应本课：RTFM → 模块① 的 --help/man 主线；终端≠Shell → 模块①真正上手；grep|wc 黑盒 → 综合挑战回收。 -->

---

# 今天讲七件事

<div class="course-agenda">
  <div><b>01</b> Shell 与求助 <small>提示符、Tab 补全、Ctrl+C、man 、...</small></div>
  <div><b>02</b> 目录、文件与权限 <small>cd/ls/pwd/mkdir/touch</small></div>
  <div><b>03</b> 复制、移动、删除 <small>rm -rf /*</small></div>
  <div><b>04</b> 查看与编辑 <small>less/head/tail、vim</small></div>
  <div><b>05</b> 管道与特殊符号 <small>通配符、重定向、管道</small></div>
  <div><b>06</b> 软件包管理 <small>apt vs pacman、编译 vs 二进制、固定 vs 滚动</small></div>
  <div><b>07</b> 服务与远程 <small>systemd/systemctl、PID/UID/proc 、ssh</small></div>
  <div><b>08</b> 滚木滚木滚 <small>滚木滚木滚</small></div>
</div>

<div class="lesson-callout">滚木滚木滚</div>

<!-- 目录结构细节、tar、grep/sed 深入、链接、后台任务，以及权限/包管理/SSH/systemd 的深入部分，留给后续课。 -->

---

# 环境检查：你在哪一层？

在 Ubuntu 的 Bash 中运行：

~~~bash
whoami && pwd && cat /etc/os-release | head -n 2
~~~

- **A** · Ubuntu 已就绪，可以开始。
- **B** · 还没有可用环境，和同桌结对。
- **C** · 使用 WSL2 或机房环境，确认进入的是 Bash。

<!-- E0 · 0–5 min。先确认谁需要结对，再继续。 -->

---

<div class="course-label">模块 01 · 05–12 min</div>

# Shell 与求助

从提示符读出当前环境，再看命令、选项和参数。

**主线** · 遇到不懂先问它自己：<code>--help</code> 和 <code>man</code>

**现场演示** · Tab 补全、历史、Ctrl+C、<code>ls --help</code> 和 <code>man ls</code>

<!-- E1 · 参数语法表压成一张图带过；「求助」立为全课主线，之后每个新命令都回头指一下。 -->

---

<div class="course-label">模块 02 · 12–28 min</div>

# 目录、文件与权限

用 <code>pwd</code> 确认位置，用 <code>cd</code> 练绝对路径与相对路径，最后用 <code>ls -l</code> 看懂权限。

**动手** · 先猜 <code>cd ../..</code> 会到哪里，再用 <code>pwd</code> 验证

<!-- E2 · 路径迷宫后接权限现场，权限不再埋伏笔到下一课。 -->

---

<div class="course-label">模块 02 · 12–28 min</div>

# 看懂 <code>ls -l</code> 的第一列

~~~text
-rwxr-xr-x
~~~

- 类型 1 位：<code>-</code> 文件 · <code>d</code> 目录 · <code>l</code> 链接
- 三级各 3 位：user / group / other 的 <code>r</code> <code>w</code> <code>x</code>

<!-- 颜色分块拆解：类型位一种颜色，三级各同组同色，比文字表直观。 -->

---

<div class="course-label">模块 02 · 12–28 min</div>

# 为什么不让运行？

<code>./run.sh</code> → <code>Permission denied</code>

<code>chmod +x run.sh</code> → 成功

普通用户 → <code>sudo</code> → root 权限 · 借来的权力要密码

<!-- before/after 两张屏，先让学生猜「为什么不让运行」。 -->

---

<div class="course-label">模块 03 · 28–38 min</div>

# 复制、移动、删除

同一条 <code>cp</code>，目标是已有目录和不存在时结果不同；<code>rm</code> 删掉的不进回收站。

**先预测** · <code>cp file.txt dir</code>、<code>cp file.txt dir2</code>、<code>cp -r dir dir.txt</code>

<!-- E3/E4 · cp/mv 预测后接 rm 高危现场（只演示，学生不跟做）。 -->

---

<div class="course-label">模块 04 · 38–46 min</div>

# 查看与编辑

用 <code>less</code>、<code>head</code> 和 <code>tail</code> 看日志，再用编辑器保存退出。

**现场演示** · <code>less</code> 按 <code>q</code>；Vim 三模式 + <code>:wq</code>，会退出就行

<!-- E5 · vim 只演示 i / Esc / :wq；nano 底部有快捷键提示，作业用 nano 就够。 -->

---

<div class="course-label">模块 05 · 46–56 min</div>

# 管道与特殊符号

Shell 如何展开通配符、解释引号，又怎样把一条命令的输出交给下一条？

**一起拆管道** · 用五行日志观察筛选和计数；通配符只练 <code>*</code>

<!-- E6 · 变量/引号只留「变量永远加双引号」安全点；?、[] 一句话带过。 -->

---
routeAlias: bash-notebook
---

# 一条管道，数出 404

选择一个单元，先预测输出，再运行 Bash。

<script setup>
import { statusLogSteps } from './demos/status-log.js'
</script>

<NotebookDemo :steps="statusLogSteps" />

<!-- E6 · 运行统计单元前让学生先报答案。再问：把 404 改成 500，结果是多少？ -->

---

<div class="course-label">综合挑战 · 56–66 min</div>

# 一条管道统计日志

1. 在 <code>~/sast-lab2</code> 中创建 <code>status.log</code>，每行一个状态码。
2. 用一条管道统计其中恰好为 <code>404</code> 的行数。
3. 用 <code>&gt;&gt;</code> 把结果追加到 <code>result.txt</code>，解释为什么用追加。
4. 加分：把 <code>404</code> 存进变量，比较单引号和双引号的效果。

<div class="lesson-callout">输入顺序：<code>200 · 404 · 200 · 500 · 404</code></div>

<!-- E7 · 助教巡场。同桌互查，能说明每段管道的输入和输出即可。 -->

---

<div class="course-label">模块 06 · 66–74 min</div>

# 软件包管理：装一个东西

源（仓库）→ <code>apt</code> → 你的系统

<code>apt update</code>（刷新菜单）→ <code>apt search</code> → <code>sudo apt install</code> → <code>apt remove</code>

第一次 <code>sudo apt install</code>：真·sudo，呼应模块 02

<!-- E8 · 跳过 update 会报 Unable to locate package，这是第一坑。 -->

---

<div class="course-label">模块 06 · 66–74 min</div>

# 别照着别的发行版抄命令

- 包管理器按发行版家族分：Debian/Ubuntu 用 <code>apt</code>（.deb），Arch 用 <code>pacman</code>（.pkg.tar.zst），Fedora/RHEL 用 <code>dnf</code>（.rpm）
- 装软件两条路：二进制包（包管理器，快、推荐）vs 源码编译（<code>./configure && make && make install</code>，慢、要依赖）
- 更新模式：固定/大版本发布（Ubuntu LTS 两年一版）vs 滚动更新（Arch 持续追最新）

<!-- 一句话带过，不做。 -->

---

<div class="course-label">模块 07 · 74–84 min</div>

# systemd：启动后第一个进程

<code>systemd</code> = init 系统（PID 1）· <code>systemctl</code> = 管理命令

<code>status / start / stop / restart</code> · <code>enable / disable</code>

**start/stop 管这一次 · enable/disable 管开机自启**

<!-- E9 · 这张两列表单独占一屏，是新手永远分不清的点。 -->

---

<div class="course-label">模块 07 · 74–84 min</div>

# 三个「1」，别混

- <code>PID 1</code> = 第一个进程（systemd），不是用户
- <code>UID 1</code> = 一个系统账号（daemon），**不是 root**；root 是 UID 0
- <code>/proc/1</code> = 进程 1 的虚拟目录（/proc 按 PID 暴露信息）

<code>cat /proc/1/comm</code> → systemd

<!-- 新手高频混淆，单独一屏辨析。 -->

---

<div class="course-label">模块 07 · 74–84 min</div>

# ssh：最流行的远程控制手段

<code>ssh user@host</code> → 首次确认 fingerprint → <code>exit</code> 回来

重点看提示符 hostname 变了没

<code>scp</code> 一句带过

<!-- ssh 只讲到这里；密钥认证、端口转发、tmux 不讲。 -->

---

# 课后任务

- 回顾教程 1.2–1.7，补读 1.8 权限、1.9 软件包、1.10 SSH。
- 用 nano 或 Vim 写一份不超过 200 字的使用心得或翻车记录。
- 在自己机器上 <code>sudo apt install cowsay</code>，再 <code>ssh localhost</code> 连一次自己。
- 有余力，把课堂挑战改成统计 <code>500</code>。

<div class="lesson-callout">会预测、会查帮助，也能解释每一段管道。</div>

<!-- E10 · 84–90 min。 -->
