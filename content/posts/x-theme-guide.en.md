+++
title = "x-theme Theme Guide"
date = 2026-03-24
draft = false
description = "A 90s print aesthetic blog theme for Zola with bold typography, hard shadows, and nostalgic scrolling marquees"
[extra]
cover = "/images/posts/x-theme-guide.png"
+++

[x-theme](https://github.com/xavier2code/x-theme) 是一款受 90 年代杂志印刷风格启发的 Zola 静态博客主题。它融合了复古美学与现代 Web 技术，提供独特的视觉体验。

## 主题特色

### 视觉设计

- **复古印刷风格** - 大胆的标题、硬阴影效果
- **Google Fonts** - Playfair Display (标题) + Noto Serif SC (正文)
- **响应式设计** - 移动端友好的导航菜单
- **滚动字幕** (Marquee) - 经典 90 年代风格的信息滚动条

### 预设组件

- 粘性导航栏
- 文章卡片带悬停动画
- 分类标签 (Badge)
- 上一篇/下一篇导航
- 分页支持

## 快速开始

### 1. 安装主题

```bash
cd your-zola-site
git submodule add git@github.com:xavier2code/x-theme.git themes/x-theme
```

### 2. 配置 zola.toml

```toml
base_url = "https://your-site.com"
title = "My Blog"
theme = "x-theme"
compile_sass = true

taxonomies = [
    { name = "categories", feed = true },
    { name = "tags", feed = true }
]

[extra]
marquee_text = "★ WELCOME TO MY BLOG ★"
```

## 内容组织

### 目录结构

```
content/
├── _index.md          # 首页
├── posts/
│   ├── _index.md      # 文章列表页
│   └── hello-world.md # 文章
├── archives/
│   └── _index.md      # 归档页
├── about/
│   └── _index.md      # 关于页
└── contact/
    └── _index.md      # 联系页
```

### 文章 Front Matter

```markdown
+++
title = "文章标题"
date = 2026-03-24
draft = false
description = "文章描述，会显示在列表页"
[taxonomies]
categories = ["技术"]
tags = ["zola", "blog"]
+++

正文内容...
```

### 特色图片

在文章 front matter 中添加 `extra.image` 即可在首页显示特色图片：

```markdown
+++
title = "带图片的文章"
date = 2026-03-24
[extra]
image = "/images/cover.jpg"
+++
```

## 自定义配置

### 滚动字幕文字

```toml
[extra]
marquee_text = "★ 自定义文字 ★ 支持 ★ 特殊符号 ★"
```

### 禁用滚动字幕

```toml
[extra]
marquee_text = ""
```

## 开发命令

```bash
# 本地预览
zola serve

# 监听所有接口 (移动端测试)
zola serve --interface 0.0.0.0 --port 1111

# 生产构建
zola build

# 检查错误
zola check
```

## 模板结构

```
themes/x-theme/templates/
├── base.html          # 基础模板 (导航、页脚)
├── home.html          # 首页 (最新文章 + 侧边栏)
├── section.html       # 章节页 (归档、分类)
├── list.html          # 文章列表 (带分页)
└── page.html          # 单篇文章页
```

## 样式定制

主题使用 Sass 构建，变量定义在 `themes/x-theme/sass/_variables.scss`：

```scss
$primary-color: #2563eb;    // 主色调
$accent-color: #ff6b35;     // 强调色
$text-color: #1a1a1a;       // 正文颜色
$border: 3px solid black;   // 边框厚度
```

---

主题项目地址: [github.com/xavier2code/x-theme](https://github.com/xavier2code/x-theme)
