# Ubuntu 24.04 LTS 安装与验收手册

> SAST 运维 / Linux 组 · 两节课配套 Markdown 手册
>
> 课堂用 Typst 幻灯片讲解概念，本手册用于课前准备、第二课安装实操与课后排错。主线是 **Windows x86-64 + VMware Workstation Pro + Ubuntu 24.04 LTS Desktop**；Apple Silicon 使用 ARM 分支，Windows 也可使用 WSL2 备用方案。
>
> 不需要一次记住所有步骤。遇到不一致的界面或报错，可以停下来保留现场，请老师一起确认。除明确标注 PowerShell 或 macOS 的命令外，本文命令均在 **Ubuntu 内的终端**执行；不要复制代码块外的提示文字。

## 0. 先选路线，再检查资源

| 你的设备 | 本课路线 | 安装镜像 |
|---|---|---|
| Intel / AMD 的 Windows 电脑（x86-64） | VMware Workstation Pro，正文主线 | Ubuntu 24.04.x Desktop **amd64** |
| Apple Silicon Mac（M 系列） | UTM，见附录 A | Ubuntu 24.04.x **ARM64 Server**，按需加桌面 |
| Intel Mac | 支持该 macOS 的 VMware Fusion，向老师确认版本；创建虚拟机原则同正文 | Ubuntu 24.04.x Desktop **amd64** |
| Windows 主线安装受阻或资源紧张 | WSL2，见附录 B | 在线安装 `Ubuntu-24.04`，不下载 ISO |
| Windows on ARM | 先告知老师，不套用 x86-64 VMware 主线；可评估受支持的 WSL2 | 与宿主架构适配的发行版 |

`amd64` 同时适用于常见 Intel 和 AMD 64 位 CPU，不是“只给 AMD 用”。Apple Silicon 应选 `arm64`，不要用 x86 镜像模拟来完成本课。

### 0.1 主线资源检查

| 项目 | 建议 | 检查方法 |
|---|---|---|
| 宿主系统 | 受所选 VMware 版本支持、已更新的 64 位 Windows；优先仍在安全支持期内的 Windows 11 | 设置 → 系统 → 关于；查所选 VMware 版本支持列表 |
| 宿主内存 | **推荐 16 GB 或更多**；8 GB 先关闭大型应用试跑，明显卡顿就协商改用 WSL2 / 轻量命令行环境 | 任务管理器 → 性能 → 内存 |
| 客户机内存 | Ubuntu Desktop **推荐 4 GB**，资源充足可给更多；不把 2 GB 当作桌面推荐配置 | 虚拟机设置 |
| CPU | 先分配 2 个虚拟 CPU 核心，给宿主保留资源 | 虚拟机设置 |
| 宿主可用磁盘 | **至少 60 GB 空闲**，为 ISO、虚拟磁盘和快照留空间；快照多时需要更多 | 查看实际存放虚拟机的磁盘 |
| CPU 虚拟化 | Intel VT-x / AMD-V（固件中也可能叫 SVM）已启用 | 任务管理器 → 性能 → CPU → 虚拟化 |

- “宿主机”是你的 Windows / macOS，“客户机”是虚拟机里的 Ubuntu。
- 如果虚拟化显示禁用，按电脑厂商对应型号的说明进入 UEFI / BIOS 开启。**不要顺便关闭 Secure Boot（安全启动）、内核隔离或其他安全功能。** 受管理设备请联系管理员；更改固件前确认能取得 BitLocker 恢复密钥，不确定时请老师协助。
- 不需要为了本课关闭 Hyper-V 或卸载 WSL。新版 VMware 支持在启用 Hyper-V 的 Windows 主机上运行，具体限制按报错与版本排查。
- 将虚拟机存放在本地空间充足的位置，尽量避免云同步目录、网络盘和易拔出的移动盘。安装时接电源。

## 1. 课前下载与校验

### 1.1 VMware Workstation Pro

自 **2024 年 11 月起，VMware Workstation Pro 与 Fusion 对所有用户免费**，不再仅限个人用途。下载入口、账号要求和安装界面可能变化，以 [Broadcom 官方下载与许可说明](https://knowledge.broadcom.com/external/article/368667/download-and-license-vmware-desktop-hype.html) 为准。

1. 从上述官方说明进入下载流程，按页面要求注册 / 登录 Broadcom 账号，选择支持你宿主系统的版本。
2. 安装 Windows 版 Workstation Pro；通常保留默认选项即可，按提示重启宿主机。
3. 不要照旧教程寻找固定的 “Personal Use” 按钮，也不需要购买密钥或使用破解补丁。若页面要求与你预期不符，记录软件版本和提示交给老师确认。
4. 下载受阻时可先走 WSL2 备用路线，不从陌生网盘获取修改过的安装包。

### 1.2 Ubuntu 24.04.x LTS ISO

课堂统一使用 **24.04 LTS 系列**。其中 `x` 是点版本号，不是下载文件名里应输入的字母。**老师课前统一具体点版本、完整文件名与 SHA256**，同学按该版本下载；不要把某个历史点版本称作当前最新版。

- 南邮镜像目录（amd64）：<https://mirrors.njupt.edu.cn/ubuntu-releases/24.04/>
- Ubuntu 官方 24.04 下载目录：<https://releases.ubuntu.com/24.04/>
- Apple Silicon 不使用上述目录猜测 ARM Desktop 文件名，转到附录 A 的官方 ARM Server 下载目录。

主线选择文件名以 `desktop-amd64.iso` 结尾的 **24.04.x** 镜像，不选 `.torrent`、`.zsync` 或 `live-server`。文件通常有数 GB，大小与下载速度会随版本和网络变化；“文件大小差不多”不等于校验通过。

### 1.3 核对 SHA256

从对应官方版本目录获取 `SHA256SUMS`，找到**与你的 ISO 完整文件名一致**的记录。也可使用老师已从官方核对并发布的摘要。不要仅凭不明来源安装包旁边附带的摘要判断可信。

在 **Windows PowerShell** 中运行，路径替换为实际文件：

```powershell
Get-FileHash -Algorithm SHA256 "D:\Downloads\实际下载的镜像文件名.iso"
```

在 **macOS 终端**中运行：

```bash
shasum -a 256 "$HOME/Downloads/实际下载的镜像文件名.iso"
```

逐字核对 64 位十六进制摘要，字母大小写不影响比较。不一致时不要继续安装，应重新下载并确认版本与文件名。SHA256 用于检查文件一致性；可信的官方摘要来源同样重要，老师可进一步核验官方 `SHA256SUMS.gpg` 签名。

## 2. 创建 VMware 虚拟机

1. 打开 VMware → 新建虚拟机，选择 **典型 / Typical** 即可，不要求逐项自定义高级硬件。
2. 安装来源选 **稍后安装操作系统 / I will install the operating system later**，避免自动安装流程与本手册不同。
3. 客户机类型选 Linux，版本选 Ubuntu 64 位或该版本提供的对应 Ubuntu 选项。
4. 名称可用 `Ubuntu-24.04-SAST`，位置选空间充足的本地目录。
5. **创建新的虚拟磁盘**，容量建议 40 GB；单文件或拆分文件按默认即可。使用可增长磁盘，不勾选立即分配全部空间。40 GB 是虚拟容量上限，不是马上占用 40 GB；快照和 ISO 会额外占用宿主空间。
6. 在完成前或完成后的设置中，调整内存为 **4096 MB**，虚拟 CPU 总核心数为 **2**；不必将所有核心和内存分给客户机。
7. 网络适配器选 **NAT**，确认“已连接 / 启动时连接”。NAT 让客户机通过宿主访问网络；校园认证、VPN 和防火墙仍可能影响连通性。
8. CD/DVD 设备选择“使用 ISO 映像文件”，挂载已校验的 ISO，并勾选“启动时连接”。控制器、固件、磁盘类型等其余选项保留推荐默认值。

**安全检查：只允许新建的文件型虚拟磁盘，不使用物理磁盘 / raw disk，不把宿主硬盘直接映射给虚拟机。** 本课不需要嵌套虚拟化、端口转发或桥接网络；不要为了安装而额外打开这些选项。

## 3. 安装 Ubuntu Desktop

不同 24.04.x 镜像及安装器更新可能改变页面名称、顺序与默认选项。按选项含义操作即可，不必追求截图完全一致。

1. 启动虚拟机；如果出现启动菜单，选择尝试或安装 Ubuntu，再进入安装程序。
2. 语言可以选中文或 English；英文便于比对部分报错，但不是要求。键盘布局按实际键盘选择，常见键盘可用 English (US)。
3. 网络正常就保持连接；下载慢或无法连接时，可以选择跳过安装器更新、离线继续（若该页面提供选项），安装后再配置网络和更新。离线不等于安装失败。
4. 如果询问安装方式，选交互式安装。应用选择使用安装器默认的基础 / 默认选择即可，不必选择包含大量软件的扩展安装。
5. 第三方驱动、多媒体格式等是可选项。**虚拟机不需要为了本课强装宿主显卡、无线网卡驱动**，可先不勾选第三方驱动。
6. 分区页面可以选择 **Erase disk and install Ubuntu（擦除磁盘并安装 Ubuntu）**，但必须先核对目标：它应是本次新建、约 40 GB 的虚拟磁盘。最终写入确认页再次检查磁盘容量和设备信息。
   - 仅在未配置物理磁盘映射、且确认目标确为虚拟磁盘时，这个操作才只影响客户机磁盘。
   - 发现容量与预期不符、出现宿主真实磁盘或不确定目标时，**取消 / 返回，请老师确认**。不要对“擦除磁盘”一律放心点下一步。
7. 时区可选 Shanghai；创建普通用户，用户名建议用小写英文字母与数字，显示名称可以按个人偏好填写。保存好密码，不用真实敏感账号的密码。
8. 检查摘要后开始安装。耗时取决于磁盘、网络和宿主负载，不承诺固定分钟数。
9. 安装结束后重启。如果提示移除安装介质，断开虚拟 CD/DVD 的 ISO，再按提示继续。若重启又回到安装界面，先检查是否仍从 ISO 启动，不要立即重装。
10. 登录桌面，通过应用菜单搜索 Terminal，或按 `Ctrl + Alt + T` 打开终端。

终端中 `sudo` 要求输入的是刚创建的 Ubuntu 用户密码，输入时**不显示字符或星号**，输入完按回车即可；不是卡住了。

## 4. 确认系统与网络，再配置软件源

### 4.1 先读现状

```bash
cat /etc/os-release
uname -m
dpkg --print-architecture
ip -br addr
ip route
```

预期 Ubuntu 的 `VERSION_ID="24.04"`；amd64 主线通常是 `uname -m` 输出 `x86_64`、dpkg 输出 `amd64`；ARM 分支分别为 `aarch64`、`arm64`。

换源是为了改善下载体验，**不是安装成功的必要条件**。官方源可用就可以先继续；网络不通时先看 FAQ，不要把所有网络问题都归因于镜像站。

### 4.2 先确认配置格式，不能直接套旧教程

Ubuntu 24.04 全新安装通常采用 **deb822** 格式：

```bash
ls -l /etc/apt/sources.list.d/
# 文件存在时再读取：
cat /etc/apt/sources.list.d/ubuntu.sources
```

如果没有这个文件，或发现 `.list`、其他 `.sources`、重复 Ubuntu 条目，先查看实际配置并请老师确认。升级系统、云镜像、WSL 的布局可能不同，**不要凭空新建一个同名文件叠加源，也不要清空现有配置**。下面只适用于已确认使用该文件管理 Ubuntu 官方源的情况。

deb822 中，每个由空行分隔的段落是一组源，通常包含 `Types`、`URIs`、`Suites`、`Components`、`Signed-By`。本课只调整需要更换的 **URIs**，保留原有发行版套件、组件及签名密钥设置。

### 4.3 备份到 `/root`，再手动修改

以下命令在**同一个终端**依次执行；任何一步报错都先停下。备份放在 `/root`，不在 APT 源目录堆放副本；每次生成不同文件名，不覆盖上次备份。

```bash
backup=$(sudo mktemp /root/ubuntu.sources.XXXXXXXX) &&
  sudo cp -- /etc/apt/sources.list.d/ubuntu.sources "$backup" &&
  printf '备份路径：%s\n' "$backup"
```

记录输出的完整备份路径。只有确认复制成功后才编辑：

```bash
sudoedit /etc/apt/sources.list.d/ubuntu.sources
```

`sudoedit` 会打开配置的文本编辑器；若是 nano，保存用 `Ctrl + O`、回车，退出用 `Ctrl + X`。若编辑器操作不熟悉，请老师协助，不必改用整文件覆盖命令。

**amd64 路线：**

- 在主仓库段落中，将官方主仓 URI（可能是 `archive.ubuntu.com/ubuntu`，也可能有 `cn.` 等地区前缀）改为：
  ```text
  URIs: https://mirrors.njupt.edu.cn/ubuntu/
  ```
- 保留包含 `noble-security` 的独立安全更新段落及其 `security.ubuntu.com/ubuntu` 官方 URI；不要为了换主仓库而把安全源也改走。
- `Suites` 中原有的 `noble`、`noble-updates`、`noble-backports` 按原样保留；`Components`、`Signed-By`、`Types` 等也保留，不套用别人的整份配置。
- 如果主仓库与 `noble-security` 写在同一段内，**先不修改该段**，请老师协助拆分成主仓库段和独立的官方安全源段，避免把安全更新一起改走。

**ARM64 路线：**

- 官方源通常为 `ports.ubuntu.com/ubuntu-ports`，包括 ARM 的安全更新；不要照搬 amd64 的 `security.ubuntu.com` 配置。
- 南邮候选地址为 `https://mirrors.njupt.edu.cn/ubuntu-ports/`，**必须由老师课前验证该目录、noble 各套件、arm64 索引和更新可用后才使用；未经验证保留官方 ports 源**。
- 真要更换时，也只手动修改相应段落的完整 `URIs`。不要替换域名片段，避免拼出重复的 `/ubuntu-ports/ubuntu-ports`。

### 4.4 读回、对比、更新索引

仍在刚才的终端中运行：

```bash
cat /etc/apt/sources.list.d/ubuntu.sources
sudo diff -u -- "$backup" /etc/apt/sources.list.d/ubuntu.sources
```

`diff` 有差异时返回状态 1 是正常的。确认差异只有预期 URI，路径没有重复、没有丢失安全源或 `Signed-By` 后，才执行：

```bash
sudo apt update
```

这是刷新软件包**索引**，不是升级所有软件。检查输出里是否有下载失败、签名、DNS、TLS 等错误；不能只看到末尾“完成”或仅凭退出码就算通过。

若配置改坏，需要恢复：找到上面记录的**本次备份真实路径**，替换下面占位路径后执行；不要照抄占位文字，也不要猜备份编号。

```bash
sudo cp -- /root/这里替换为本次实际备份文件名 /etc/apt/sources.list.d/ubuntu.sources
cat /etc/apt/sources.list.d/ubuntu.sources
sudo apt update
```

课堂不统一运行 `apt upgrade -y`，避免长时间下载、磁盘占满和中途重启。安装后仍应安排安全更新：网络和时间充足时先查看可升级包，在有恢复点的前提下交互式执行 `sudo apt upgrade`，阅读提示并按需重启。

## 5. 只安装当前需要的工具

本课 shell 操作、日志统计主要使用系统自带命令。确认 `apt update` 正常后，可安装一个用于 HTTP 排错的工具：

```bash
sudo apt install curl
```

阅读安装列表和磁盘占用，确认后再继续，不必加 `-y`。`git`、编译工具、额外编辑器等在后续课程真正用到时再装；查看地址用 `ip`，不要求安装 `net-tools`。

**VMware Desktop 客户机**可以先检查增强工具：

```bash
dpkg-query -W open-vm-tools open-vm-tools-desktop
```

缺少时再安装：

```bash
sudo apt install open-vm-tools open-vm-tools-desktop
```

装好后注销重新登录或重启客户机，测试调整窗口大小时分辨率能否变化。共享剪贴板还受 VMware 客户机隔离设置、桌面会话与版本支持影响，**不是装包后必然生效**，也不是本课验收前提。不要通过关闭宿主安全功能来修复剪贴板。UTM、WSL 不安装 VMware 专用增强工具。

## 6. 建立恢复点，并做一次小范围恢复验证

### 6.1 快照与备份的区别

- **快照**记录虚拟机某个时间点，适合实验前快速回退，但仍依赖原虚拟磁盘及快照链。宿主磁盘损坏或虚拟机目录丢失时，快照不能代替备份。
- **备份**是独立保存的副本。重要作业另存到宿主或其他备份位置；完整虚拟机备份应在关机后复制全部相关文件，而不是只复制一个虚拟磁盘分片。
- 回滚会丢弃快照之后客户机内的文件、安装和设置变更；宿主共享目录、外部磁盘、远端服务通常不在回滚范围内。回滚前先导出需要保留的内容。
- 快照会增长。不要手动删除快照链文件；通过软件的快照管理器管理，且保留足够磁盘空间。

### 6.2 VMware 恢复演练

在 Ubuntu 中新建专门的测试目录，不动已有作业：

```bash
recovery_dir=$(mktemp -d "$HOME/sast-recovery.XXXXXX")
printf 'before\n' > "$recovery_dir/state.txt"
printf '记录测试目录：%s\n' "$recovery_dir"
```

1. 把输出的完整目录路径记在**宿主机**上。正常关闭 Ubuntu，等虚拟机显示已关机后，在 VMware 的“虚拟机 → 快照 → 拍摄快照”中建立 `fresh-install`，描述写上日期、系统版本、源配置状态。
2. 启动客户机，在终端输入 `recovery_dir='刚才记录的实际完整目录路径'`，将引号里的占位文字替换为真实路径，再执行：
   ```bash
   printf 'after\n' > "$recovery_dir/state.txt"
   cat "$recovery_dir/state.txt"
   ```
   应看到 `after`。这时不要同时修改需要保留的作业。
3. 正常关闭客户机，打开快照管理器，选择 `fresh-install` 并执行恢复 / 转到。读清“丢失当前状态”的提示后确认。
4. 再次启动，重新给 `recovery_dir` 设置同一个实际路径，执行 `cat "$recovery_dir/state.txt"`，应恢复为 `before`。记录结果即可，不要求反复回滚。

UTM 使用附录 A 的关机副本恢复演练；WSL 使用附录 B 的导出 / 导入演练，不能把 VMware 快照菜单套到其他软件上。

## 7. 五项可验证验收

前三项可在恢复点建立前检查；恢复演练后再运行一次日志练习，避免回滚丢掉验收文件。提交命令与必要输出即可，不要求桌面截图。

| 项目 | 操作 | 通过标准 |
|---|---|---|
| 1. 系统版本 | `cat /etc/os-release` | `ID=ubuntu`、`VERSION_ID="24.04"`；记录使用 VMware / UTM / WSL 哪条路线 |
| 2. 架构 | `uname -m` 与 `dpkg --print-architecture` | amd64：`x86_64` / `amd64`；ARM：`aarch64` / `arm64`，与所选路线一致 |
| 3. APT | `sudo apt update` | 启用的仓库索引可正常更新，无未解决的获取失败、签名或发行版错误；不要求一定换源 |
| 4. Shell 与日志统计 | 完成 [lab.md](lab.md) 的统一练习 | 能生成五行状态码日志，用管道统计整行 404，结果为 2 |
| 5. 恢复 | VMware 快照回退、UTM 关机副本或 WSL 导出 / 导入 | 展示测试文件 `before → after → before` 的证据；能说明回滚会丢失什么，以及快照不等于备份 |

### 统一 Shell 练习与作业

请使用 [lab.md](lab.md) 的五行状态码实验，与投屏保持一致：

```bash
lab=$(mktemp -d "$HOME/sast-lab.XXXXXX")
cd "$lab"
printf '%s\n' 200 404 200 500 404 > status.log
grep -x '404' status.log | wc -l
```

逐行执行，任一步报错先停下。预期结果为 `2`。`>` 会覆盖目标文件，所以这里只在全新目录中操作。完整的复制比较、帮助查询、退出状态练习和提交模板见 `lab.md`；上表是安装完成检查，课堂评分统一按 `lab.md`，联网受阻允许提交具体失败证据与下一步计划。恢复演练可以课后完成，不要求所有设备在课堂同时复制或导出大型虚拟机。

## FAQ：按现象排查，不先改安全设置

### VMware 启动失败，提到 Hyper-V / VBS / Device Guard 怎么办？

新版 VMware 可以与 Hyper-V 主机共存，但硬件、Windows 构建、VMware 版本和功能组合会影响运行与性能。依次检查：

1. 记录完整报错、Windows 版本、VMware 版本，以及发生在安装软件还是启动客户机时。
2. 确认 CPU 虚拟化已启用，VMware 版本支持当前宿主系统；按官方说明更新并重启。
3. 检查是否误开了客户机的“虚拟化 Intel VT-x/EPT 或 AMD-V/RVI”等**嵌套虚拟化**选项；本课不需要该选项，不等于关闭宿主固件虚拟化。
4. 根据具体错误查官方兼容性说明，请老师协助；受管理设备联系管理员。若仍不能解决，先使用 WSL2 或课堂备用设备。

**不把关闭 Hyper-V、WSL、内存完整性、Secure Boot 当作通用解决方法。** 只有明确定位到某个功能冲突、理解安全影响与恢复方法后，才考虑有针对性的调整。

### 网络不通，应该检查什么？

从外到内分层排查，不要只测试一次 `ping` 就判定断网。ICMP 可能被拦截；能 ping 通也不代表 HTTPS、DNS、代理或 APT 都正常。

1. **宿主 / 校园网：** 宿主浏览器能否访问正常的 HTTPS 网站？校园认证是否完成？VPN、代理、网络切换是否影响连接？不要直接关闭防火墙或全部安全软件。
2. **虚拟网络：** VMware 网卡是否连接并使用 NAT，UTM 是否使用共享网络？WSL 则检查其 Windows 侧网络，不寻找 VMware NAT 设置。
3. **地址和路由：** 在 Ubuntu 执行 `ip -br addr`、`ip route`。应有非回环网卡地址及可用的默认路由；不要把只有 `127.0.0.1` 当作联网。
4. **DNS：** 执行 `getent ahosts mirrors.njupt.edu.cn`，再对当前实际源的主机名测试。没有结果提示可能有解析问题，但不能只凭一个域名失败断定全网 DNS 故障。
5. **HTTP / TLS：** 已安装 curl 时，执行 `curl -I --connect-timeout 10 https://mirrors.njupt.edu.cn/ubuntu/`，也可对实际源 URI 测试。收到 HTTP 响应表明请求到达了服务或中间代理，但 403 / 404 不是仓库可用的证明；405 也可能只是服务器不接受 HEAD 请求。TLS 失败时查看 `date -Is`，检查时间、证书和代理，不使用 `curl -k` 作为修复。
6. **APT：** 最后看 `sudo apt update` 的具体 URL 与错误。若系统尚无 curl，可先用浏览器或已有 wget 获取信息，避免要求先联网装工具才能排查网络。

### `apt update` 报错怎么处理？

| 错误或现象 | 优先检查 |
|---|---|
| `Temporary failure resolving` | DNS、校园认证、实际源域名，先按上面的分层步骤排查 |
| 404 / `does not have a Release file` | URI 路径、是否重复 `/ubuntu-ports`、是否误用其他版本代号、镜像是否提供该架构与套件 |
| `Hash Sum mismatch` | 镜像同步状态、缓存代理、网络是否稳定；稍后重试或恢复官方源，不关闭哈希 / 签名检查 |
| 签名 / `NO_PUBKEY` / `not signed` | 是否误改 `Signed-By`、加了陌生第三方仓库，或密钥环文件不可用；恢复可信配置并请老师确认，不随意导入网上的密钥 |
| TLS / 证书 / Release 时间无效 | 系统时间、代理或校园认证拦截；不要禁用证书或有效期检查 |
| 无法获取锁 / 另一个进程使用 APT | 自动更新可能正在运行，等待完成；不直接删除锁文件或强杀更新进程 |
| 下载慢 | 官方源与已验证镜像的连通性、网络环境；慢不等于配置错误，换源也不保证更快 |

不要添加 `trusted=yes`、关闭签名验证或用忽略校验参数来“消除报错”。向老师发送错误前后的必要文字即可，注意遮盖代理凭据等敏感信息。

### 黑屏、很卡、剪贴板不共享怎么办？

先确认宿主没有内存或磁盘空间告急，关闭大型应用，并检查 ISO 架构及 VMware 增强工具。图形问题可在关机后按具体报错尝试调整虚拟机 3D 加速；不要一开始就随意切换固件、磁盘控制器或分区。剪贴板、拖拽和全屏体验不是五项验收要求，能使用终端即可继续。

### 安装选择错了，是否必须重装？

不一定。用户名、时区、网络等很多设置可修正；先说明改了什么、是否已有文件，再判断如何处理。需要重装时，先备份作业并确认要删除的是哪台虚拟机，不直接删除整个课程目录。遇到困难不影响你继续学习，保留报错能帮助大家更快定位问题。

## 附录 A：Apple Silicon Mac 使用 UTM

### A.1 下载并创建 ARM 虚拟机

- UTM 官网：<https://mac.getutm.app/>。**官网版免费，App Store 版付费**；不需要为了本课购买 App Store 版。
- UTM Ubuntu 官方指南：<https://docs.getutm.app/guides/ubuntu/>。指南以 22.04 为例，可参考 ARM Server ISO + **Virtualize** 的路线，不照抄其中旧版本文件名。
- Ubuntu 24.04 ARM Server 官方目录：<https://cdimage.ubuntu.com/releases/24.04/release/>。选择老师确认的 `ubuntu-24.04.x-live-server-arm64.iso`，按实际目录文件名下载，并用对应 `SHA256SUMS` 核对。

不编造南邮 `ubuntu-releases/24.04/` 下的 ARM Desktop ISO 链接，也不下载树莓派预装镜像来替代通用 ARM Server ISO。

1. UTM 新建 → **Virtualize（虚拟化）** → Linux，按向导挂载 ARM64 Server ISO；不选 Emulate（模拟 x86）。如果向导提供 Apple Virtualization 等额外后端选择，使用与老师课前验证方案一致的设置，不混用教程步骤。
2. CPU 先给 2 核；纯命令行 Server 可以从 2 GB 内存试跑，**要装桌面则给至少 4 GB，并确认宿主有余量**。虚拟磁盘建议 40 GB，宿主仍预留至少 60 GB 空间。
3. 网络使用 Shared Network / 共享网络；安装目标仅为新建的虚拟磁盘，确认容量后再写入。
4. Server 安装器是文本界面，与正文 Desktop 页面不同：按需选语言、键盘、默认 DHCP 网络；没有代理就留空；镜像先保留可用官方默认值；创建普通用户。磁盘使用新建虚拟盘的默认引导分区方案，确认写入摘要。
5. 本课不要求 Ubuntu Pro、OpenSSH 服务或额外服务器软件，相关可选页面可以跳过。安装后断开 ISO 并重启，登录命令行。
6. 执行正文的版本、架构、网络与源配置检查。ARM 源未验证前保留官方 ports，不直接用 amd64 的仓库地址。

### A.2 桌面是可选项

命令行环境足以完成本手册验收。确有需要且资源、网络允许时，在 `apt update` 成功后安装：

```bash
sudo apt install ubuntu-desktop
sudo reboot
```

这会下载较多软件并占用更多空间，不作为全班课堂必做步骤。屏幕显示、剪贴板等增强功能按所用 UTM 后端的官方说明处理；不要给 UTM 安装 `open-vm-tools`。

### A.3 用关机副本验证恢复

不假定所有 UTM 版本和后端都提供同样的快照菜单。本课可以使用独立关机副本：

1. 在客户机按第 6.2 节建立 `state.txt`，内容为 `before`，把完整路径记到宿主。
2. 正常关闭 Ubuntu（不是暂停 / 保存运行状态），确认 UTM 显示已停止。通过 UTM 在 Finder 中定位虚拟机，复制完整 `.utm` 包到独立备份位置。若配置引用包外磁盘，也需一并备份；不要只复制 ISO。
3. 启动原虚拟机，将测试文件改为 `after` 并读回，再正常关机。
4. 从备份**另复制一份用于恢复测试**，保留原机与备份不动，通过 UTM 打开该测试副本。若提示标识冲突，使用软件提供的创建副本 / 新标识选项或请老师协助，不覆盖原机。
5. 不同时运行原机与恢复副本。在恢复副本中读取同一路径，确认是 `before`，记录验证结果。这属于从备份恢复，不应称为“快照回滚”。

## 附录 B：Windows 使用 WSL2 备用方案

WSL2 可完成本课大部分 shell、软件包与日志操作，但它的启动、网络和 Windows 集成与完整虚拟机不同。**WSL 支持 systemd**，不能笼统说它“没有 systemd”；是否默认启用取决于 WSL 和发行版版本。WSLg 也不等于完整的 Ubuntu 桌面登录环境。

### B.1 安装与检查

在支持当前 WSL 的 Windows 环境中，以管理员身份打开 **PowerShell**：

```powershell
wsl --update
wsl --list --online
wsl --install -d Ubuntu-24.04
```

如果系统尚没有可用的 WSL 命令、在线列表没有该发行版，或组件安装失败，按 [微软 WSL 安装文档](https://learn.microsoft.com/en-us/windows/wsl/install) 和具体错误处理，不猜测发行版名称。已有同名发行版时先检查内容，不卸载重建。按提示重启 Windows，再打开 Ubuntu 完成普通用户与密码设置。

回到 PowerShell 检查：

```powershell
wsl --version
wsl --list --verbose
```

确认对应发行版的 VERSION 为 `2`。若显示 `1`，先备份已有数据，再按微软文档评估转换；若 `wsl --version` 不受支持，先确认是否为旧版 WSL。WSL2 同样需要固件虚拟化支持，不能绕过设备管理策略。

进入 Ubuntu 后执行正文五项验收中的前四项；先检查实际 APT 文件再决定是否换源。练习文件放在 Linux 家目录 `~`，不要直接拿 `/mnt/c` 中的真实 Windows 文件做删除或恢复实验。

### B.2 systemd 按需检查，不必盲目修改

在 Ubuntu 中运行：

```bash
ps -p 1 -o comm=
```

如果输出 `systemd`，说明它已作为 PID 1 运行。不是 `systemd` 时，shell 练习仍可继续；只有后续课程需要管理服务时才按 [微软 systemd 文档](https://learn.microsoft.com/en-us/windows/wsl/systemd) 操作。该功能要求支持它的 WSL 版本（文档要求 WSL 0.67.6 或更高）。

需要启用时先检查 `/etc/wsl.conf` 是否存在；已有文件先备份，再用 `sudoedit /etc/wsl.conf` **合并**以下设置，不覆盖其他段落、不重复添加 `[boot]`：

```ini
[boot]
systemd=true
```

保存所有 WSL 会话中的工作，在 **PowerShell** 执行 `wsl --shutdown`，重新打开 Ubuntu 后再检查 PID 1。`wsl --shutdown` 会停止所有正在运行的 WSL 发行版及其进程，不只影响当前窗口。

### B.3 用导出 / 导入验证恢复

WSL 没有 VMware 的快照管理器。使用微软提供的导出 / 导入功能完成第五项验收，需要额外磁盘空间；导出不包含 `/mnt/c` 等挂载的 Windows 文件。

1. 在 Ubuntu 按第 6.2 节建立内容为 `before` 的测试文件，记录它的 `/home/用户名/.../state.txt` 完整路径。
2. 保存工作、退出该发行版。以下均在 **PowerShell** 执行，先用 `wsl --list --verbose` 确认实际发行版名称。示例假设确为 `Ubuntu-24.04`；目录放在空间充足的本地盘，可按实际修改。
   ```powershell
   $stamp = Get-Date -Format 'yyyyMMdd-HHmmss-fff'
   $backupDir = "$env:USERPROFILE\WSL-Backups\$stamp"
   New-Item -ItemType Directory -Path $backupDir
   wsl --terminate Ubuntu-24.04
   wsl --export Ubuntu-24.04 "$backupDir\Ubuntu-24.04.tar"
   ```
   确认导出成功且文件存在；报错就停下。`--terminate` 会结束该发行版的所有进程，不能在有未保存作业时运行。
3. 再打开原发行版，把测试文件改成 `after` 并读回。保存工作后退出并终止它；不要注销 / 删除发行版。
4. 在**同一个 PowerShell 窗口**导入为独立恢复测试实例，保留原机和导出包：
   ```powershell
   wsl --terminate Ubuntu-24.04
   $restoreName = "Ubuntu-24.04-Recovery-$stamp"
   wsl --import $restoreName "$backupDir\restored" "$backupDir\Ubuntu-24.04.tar" --version 2
   wsl --list --verbose
   wsl -d $restoreName
   ```
5. 进入恢复实例后，读取先前记录的**绝对路径**，应看到 `before`。导入实例可能默认以 root 登录，所以不要用 `~` 猜普通用户文件位置；日常使用应选择原普通用户。验证后 `exit`，在 PowerShell 中执行 `wsl --terminate $restoreName`，保留副本待老师检查。

本演练不使用 `wsl --unregister`，因为该命令会永久删除对应发行版数据。完整步骤参考 [微软 WSL 基本命令](https://learn.microsoft.com/en-us/windows/wsl/basic-commands)。

## 提问模板与课前验证边界

复制下面模板，将版本、命令与报错换成你的实际情况。不需要发送密码、密钥、BitLocker 恢复密钥、代理凭据或个人账号信息；文字报错优先复制，只有图形界面问题再补充截图。

```text
【路线】VMware / UTM / WSL2
【宿主】系统与版本、CPU 架构、内存、剩余磁盘
【软件】虚拟化软件或 WSL 的具体版本
【镜像】ISO 完整文件名与 SHA256 核对结果；WSL 填发行版名称
【客户机】os-release、uname -m / dpkg 架构
【目标与步骤】手册第几节，我想做什么，实际执行了什么
【现象】完整错误文字及必要上下文
【已尝试】改过哪些设置，是否有备份或恢复点
【希望协助】目前不确定的地方
```

**老师课前检查清单：** 统一 ISO 点版本与摘要；测试实际教室网络下的 VMware 下载、NAT 与校园认证；实机走通至少一套 VMware 安装和恢复流程；对有需求的设备验证 UTM ARM 与 WSL2 分支；确认南邮 amd64 镜像连通性。南邮 ARM ports 未验证可用前，统一保留官方 ports。

本手册描述操作流程，不代表每台设备、每个软件版本和校园网场景均已实测，也不保证镜像目录持续可用。官网界面、安装器选项、UTM 后端和剪贴板支持可能变化；遇到差异，以对应版本官方说明、老师课前测试和现场完整报错为依据。
