---
theme: default
title: 命令行核心用法
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

<div class="course-label">SAST 运维 / Linux 组 · 第二课</div>

# 命令行核心用法

Shell、文件与管道

<div class="cover-command"><span aria-hidden="true">$</span> grep -x '404' status.log | wc -l</div>

---

# 今天只讲六件事

<div class="course-agenda">
  <div><b>01</b> Shell 与命令 <small>05–20 min</small></div>
  <div><b>02</b> 目录、文件与路径 <small>20–38 min</small></div>
  <div><b>03</b> 复制、移动与重命名 <small>38–47 min</small></div>
  <div><b>04</b> 删除 <small>47–55 min</small></div>
  <div><b>05</b> 查看与编辑 <small>55–65 min</small></div>
  <div><b>06</b> 特殊符号 <small>65–80 min</small></div>
</div>

<div class="lesson-callout">80–88 min · 综合挑战：用一条管道统计日志。</div>

<!-- 用户权限、包管理、SSH 和目录结构细节留给后续课。 -->

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

<div class="course-label">模块 01 · 05–20 min</div>

# Shell 与命令

从提示符读出当前环境，再看命令、选项和参数。

**现场演示** · Tab 补全、历史、Ctrl+C、<code>ls --help</code> 和 <code>man ls</code>

<!-- E1 · 对照 slides.typ 的「先看清提示符」到「这条命令是谁执行的？」。 -->

---

<div class="course-label">模块 02 · 20–38 min</div>

# 目录、文件与路径

用 <code>pwd</code> 确认位置，再用 <code>cd</code> 练习绝对路径与相对路径。

**动手** · 先猜 <code>cd ../..</code> 会到哪里，再用 <code>pwd</code> 验证

<!-- E2 · 对照 slides.typ 的「一条斜杠，不分盘符」到「建目录、建文件、运行」。 -->

---

<div class="course-label">模块 03 · 38–47 min</div>

# 复制、移动与重命名

同一条 <code>cp</code> 命令，目标是已有目录和目标尚不存在时，结果有什么不同？

**先预测** · <code>cp file.txt dir</code>、<code>cp file.txt dir2</code>、<code>cp -r dir dir.txt</code>

<!-- E3 · 在练习目录里比较三种结果，再引出 mv 和重命名。 -->

---

<div class="course-label">模块 04 · 47–55 min</div>

# 删除

<code>rm</code> 删除的文件不会进回收站。按回车前，先检查命令会接收到哪些路径。

**一起找茬** · 多余的空格、绝对路径和没加引号的变量

<!-- E4 · 高风险案例用静态文本展示，学生只找茬。 -->

---

<div class="course-label">模块 05 · 55–65 min</div>

# 查看与编辑

用 <code>less</code>、<code>head</code> 和 <code>tail</code> 查看日志，再试着用编辑器保存并退出。

**现场演示** · <code>less</code> 按 <code>q</code>，Vim 按 <code>Esc</code> 后输入 <code>:wq</code>

<!-- E5 · 保留 less/head/tail，按课堂进度调整 nano/Vim 演示时长。 -->

---

<div class="course-label">模块 06 · 65–80 min</div>

# 特殊符号

Shell 如何展开通配符、解释引号，又怎样把一条命令的输出交给下一条？

**一起拆管道** · 用五行日志观察筛选和计数

<!-- E6 · 展开通配符、重定向、条件执行、管道、变量、引号与转义。 -->

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

<div class="course-label">综合挑战 · 80–88 min</div>

# 一条管道统计日志

1. 在 <code>~/sast-lab2</code> 中创建 <code>status.log</code>，每行一个状态码。
2. 用一条管道统计其中恰好为 <code>404</code> 的行数。
3. 用 <code>&gt;&gt;</code> 把结果追加到 <code>result.txt</code>，解释为什么用追加。
4. 加分：把 <code>404</code> 存进变量，比较单引号和双引号的效果。

<div class="lesson-callout">输入顺序：<code>200 · 404 · 200 · 500 · 404</code></div>

<!-- E7 · 助教巡场。同桌互查，能说明每段管道的输入和输出即可。 -->

---

# 课后任务

- 回顾教程第 1.2–1.7 节，预习用户权限和软件包管理。
- 用 nano 或 Vim 写一份不超过 200 字的使用心得或翻车记录。
- 有余力，把课堂挑战改成统计 <code>500</code>。

<div class="lesson-callout">会预测、会查帮助，也能解释每一段管道。</div>

<!-- E8 · 88–90 min。 -->
