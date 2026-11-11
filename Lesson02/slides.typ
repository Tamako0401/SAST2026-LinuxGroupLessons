#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#import "../catppuccin-latte.typ": catppuccin-latte-colors
#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => text(size: 0.6em, fill: gray)[SAST 运维/Linux 组 · 2026 · 第二课],
  config-info(
    title: [命令行核心用法],
    subtitle: [Shell、文件与管道],
    author: [SAST 运维/Linux 组],
    date: [2026 年秋 · 授课打样],
    institution: [南京邮电大学 SAST],
  ),
  catppuccin-latte-colors,
)
#set text(font: ("Segoe UI", "Source Han Sans SC"), lang: "zh")
#show raw: set text(font: ("JetBrains Mono", "Source Han Sans SC"))
#title-slide()

== 今天只讲 6 件事

#table(columns: (auto, 1fr), inset: 6pt,
  [① Shell 与命令], [提示符、参数、补全、历史、--help / man],
  [② 目录与路径], [单根、绝对/相对、cd / ls / pwd / mkdir / touch],
  [③ 复制与移动], [cp / mv 不看扩展名、目标存在与否],
  [④ 删除], [rm 无回收站、三类高危场景],
  [⑤ 查看与编辑], [less / head / tail、nano、vim 会退出],
  [⑥ 特殊符号], [通配符、重定向、管道、变量],
)

== 今天不讲，先把边界划清

+ 用户与权限、软件包管理 → 下一课预习。
+ ssh、目录结构细节 → 用起来再讲。
+ vim 只学"会退出"，编辑用 nano 就够。
+ find 只讲 -name，其余参数查 man。

== 环境检查：你在哪一层？

```bash
whoami && pwd && cat /etc/os-release | head -n 2
```

+ A：环境就绪，开始动手。
+ B：还没装好 → 结对，两人一台。
+ C：WSL2 / 机房 → 备用路线。

= ① Shell 与命令

== 先看清提示符

```bash
user@ubuntu:~$
```

#table(columns: (auto, 1fr), inset: 6pt,
  [user], [当前用户名],
  [ubuntu], [主机名],
  [~], [当前目录 = 家目录],
  [$], [普通用户；root 是 #],
)

== 一条命令的结构

```text
命令  [参数]...  位置参数...
```

```bash
ls -la /home
```

+ `-la`：参数，改行为（长格式 + 含隐藏文件）。
+ `/home`：位置参数，操作对象。
+ 短参数可合并；长参数写作 `--all`。

== 让终端帮你，而不是背命令

+ *Tab*：补全命令与路径。
+ *↑ / ↓*：翻历史命令。
+ *Ctrl+C*：中断卡住的命令（终端显示 `^C`）。

== 查帮助，别背命令

```bash
ls --help
man ls
```

man 内：`/pattern` 搜索，`n` 下一个，`q` 退出。

== 这条命令是谁执行的？

```bash
echo $SHELL      # 当前 shell
sleep 100        # Ctrl+C 中断
```

终端只负责交互，*Shell* 负责解释执行——回收 Lesson01 伏笔。

= ② 目录、文件与路径

== 一条斜杠，不分盘符

+ Linux 用 `/`；Windows 用 `\`。
+ 只有一个根 `/`，没有 C: D:。
+ 大小写敏感：`File` ≠ `file`。

== 绝对 vs 相对路径

```text
/home/user/a/b      # 从 / 出发，绝对
a/b                 # 从当前目录出发，相对
```

+ `.` 当前目录，`..` 上一级，`~` 家目录。

== 先学会走：cd / ls / pwd

```bash
pwd        # 我在哪
ls         # 这有什么
cd /       # 去根
cd ~       # 回家
```

`ll` = `ls -l`；权限那一列，下一课细讲。

== 路径迷宫

```bash
mkdir -p a/b/c
cd a/b/c
cd ../..          # 回到 ~/a
```

+ `cd -` 只记上一次，不是"回退按钮"。
+ Tab 补全帮你不拼错。

== 建目录、建文件、运行

```bash
mkdir -p a/b/c     # -p 一次建到底
touch note.txt     # 建空文件
cat note.txt       # 看内容（空）
./script.sh        # 运行可执行文件
```

+ 运行要带 `./`：当前目录默认不在 PATH。

= ③ 复制、移动、重命名

== cp / mv：目标存不存在，行为不同

#table(columns: (auto, 1fr), inset: 6pt,
  [目标存在], [放进目标目录里],
  [目标不存在], [当作新的文件名 / 目录名],
  [父目录不存在], [直接报错，不会帮你建],
)

== 先预测：cp 会把它放到哪？

在实验目录里，逐个预测再执行：

+ `cp file.txt dir` → 放进 dir（dir 已存在）。
+ `cp file.txt dir2` → 名为 dir2 的*文件*（dir2 不存在）。
+ `cp -r dir dir.txt` → 名为 dir.txt 的*目录*。

cp / mv 不看扩展名。

== 重命名就是移动

```bash
mv old.txt new.txt
```

+ Linux 没有单独的"重命名"，mv 顺带干了。
+ 依旧不看扩展名。

= ④ 删除

== rm：没有回收站

+ `rm file` 删文件，`rmdir dir` 删*空*目录。
+ `-r` 递归删目录，`-i/-I` 逐个 / 一次确认，`-f` 不确认。
+ 删了不可恢复，先 `-i/-I` 再确认。

== rm：三类高危场景

```bash
rm -rf demo /demo2      # 多敲一个空格
rm -rf data             # 与 /data 只差一个 /
rm -rf $path            # 变量未加引号
```

无回收站，删了不可恢复。只在一次性目录演示，学生不跟做。

== 保命三招

+ 删目录先 `-i` / `-I`。
+ 敲绝对路径前停一秒。
+ 变量永远加双引号。

= ⑤ 查看与编辑

== 读大文件：less / head / tail

```bash
less +/error access.log   # 搜索式浏览
head -n 5 access.log      # 前 5 行
tail -f access.log        # 持续跟踪（一直跑）
```

在 less 里按 `q` 退出。

== 编辑用 nano 就够

```bash
nano test.txt
```

+ 底部就是快捷键：`Ctrl+S` 保存，`Ctrl+X` 退出。
+ 本课作业用 nano，完全够。

== 退出 Vim，会这招就赢

```text
i        输入
ESC      回普通模式
:wq      保存并退出
```

Stack Overflow「如何退出 Vim」330 万浏览量。

= ⑥ 特殊符号

== 通配符：批量匹配

+ `*` 任意多个字符：`*.txt`
+ `?` 任意一个字符：`file?.txt`
+ `[abc]` 字符集任一个：`file[123].txt`

== 重定向：把输出写进文件

```bash
cmd >  file    # 覆盖
cmd >> file    # 追加
cmd 2> err     # 只把错误重定向
```

`>` 会覆盖目标，先想清楚。

== 顺序执行、条件执行

```bash
a ; b           # 都执行
a && b          # a 成功才执行 b
a || b          # a 失败才执行 b
```

+ `cd not-exist || echo "进不去"`
+ `mkdir demo && cd demo`

== 管道：把输出接到下一个输入

```bash
cat access.log | head -n 50 | tail -n 25
```

`|` 把前一条的输出传给后一条。

== 回收 Lesson01 的伏笔

```bash
printf '%s\n' 200 404 200 500 404 > status.log
grep -x '404' status.log | wc -l
```

上一课这条是黑盒，现在每一节你都认识了。

== 变量与引号

```bash
n=404
grep -x "$n" status.log    # 双引号：$n 展开成 404
grep -x '$n' status.log    # 单引号：原样，不展开
```

单引号里 `$` 不是变量。

== 转义：让特殊符号变普通

```bash
echo "a  b"     # 双引号包住空格
echo a\ b       # \ 转义空格
```

想让特殊符号失去含义，前面加 `\`。

== 综合挑战：一条管道统计日志

1. 在 `~/sast-lab2` 生成五行 status.log。
2. 只用*一条管道*统计 404 的行数。
3. 结果 `>>` 追加到 result.txt（为什么不能用 `>`）。
4. 加分：`n=404`，写 `grep -x "$n"`，解释单引号为何不行。

== 六个模块，一句话

Shell 与命令 · 目录与路径 · 复制移动 · 删除 · 查看编辑 · 特殊符号

*做一件事并做好，文本流是万能接口。*

== 课后任务

+ 通读教程 1.2–1.7。
+ 预习 1.8 用户权限 + 1.9 软件包管理。
+ nano / vim 二选一，写 200 字心得或翻车记录。
+ 有余力：第 2 章任选一节，挑战题改成统计 500。

#focus-slide[
  命令不是用来背的。\
  会预测、会查帮助、能解释每一节，才算会用。
]
