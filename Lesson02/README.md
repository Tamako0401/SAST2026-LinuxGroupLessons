# Lesson02 Slidev 框架

使用 Node.js 22.22.0 或更高版本。在仓库根目录进入 Lesson02 后启动。

~~~text
cd Lesson02
npm ci
npm run dev
~~~

打开 <http://localhost:5173/bash-notebook>，选择演示单元后点击「运行」。Windows 默认用 Git for Windows 自带的 Git Bash，Linux 和 macOS 默认用 `/bin/bash`。如果 Bash 安装在其他位置，在启动前把 `LESSON02_BASH` 设为 Bash 可执行文件的绝对路径。

运行 `npm run build` 可生成 `dist/` 下的静态课件。运行按钮需要由 `npm run dev` 启动的本机课件服务。

- 课件按教案安排环境检查、七个模块、综合挑战和课后任务。讲师备注标注 E0–E10，换页统一使用水平滑动。[slides.md](slides.md)
- 页面使用统一的 16:9 布局。按方向键翻页，或打开 Slidev 的[总览](http://localhost:5173/overview)。[章节布局](layouts/lesson-section.vue) · [样式](styles/index.css)
- [色板](styles/palette.css)保存了 Radix Sand、Indigo、Green、Red、Amber 的完整浅色和深色色阶。在[样式](styles/index.css)中按用途引用同名变量，例如用 `--palette-indigo-5` 做选中背景。Notebook 和控件沿用直角或 3px 小圆角。
- 在 [Browser Exporter](http://localhost:5173/export) 的 **Color Mode** 中切换 **Light** 或 **Dark**。首次打开课件时跟随系统配色，切换后由 Slidev 记住浏览器的选择。
- 每个演示单元填写 `id`、`title` 和 `command`。运行时，本机服务按 ID 查找命令，在单独的临时目录内启动 Bash，并返回 stdout、stderr、退出码和耗时。[组件](components/NotebookDemo.vue) · [演示单元](demos/status-log.js) · [本机运行入口](vite.config.mjs)
- 扩写章节时可对照[教案](lesson-plan.md)和[原稿](slides.typ)。
