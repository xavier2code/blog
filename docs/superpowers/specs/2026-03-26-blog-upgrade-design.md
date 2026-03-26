# Blog 升级设计规格

**日期**: 2026-03-26
**项目**: x-theme 博客升级
**目标**: 增强内容展示、数据可视化、交互能力，保持 90s 印刷美学风格

---

## 概述

基于 x-theme 最新版本，对博客进行全方位升级：
- 照片墙/作品集展示
- 统计组件可视化
- 交互组件（Accordion/Tabs/Modal/Tooltip）
- 保持现有 90s 印刷美学（橙色强调 #ff6b35）

---

## 1. 照片墙/作品集展示

### 组件选择
使用 x-theme 的 `.portfolio-grid` 组件

### 位置
在 `content/about.md` 页面底部添加 Portfolio Grid

### 内容
混合展示：
- 文章封面（来自 `[extra.cover]`）
- GitHub 项目卡片

### 数据结构
```markdown
## 作品集

<div class="portfolio-grid">
  <div class="portfolio-item">
    <img class="portfolio-cover" src="/images/posts/article_20260326.png" alt="AI 日报">
    <div class="portfolio-content">
      <h3 class="portfolio-title">AI 热点日报</h3>
      <p class="portfolio-description">每日 AI 行业动态追踪</p>
      <div class="portfolio-tags">
        <span>AI</span>
        <span>日报</span>
      </div>
    </div>
  </div>
  <!-- 更多 portfolio-item -->
</div>
```

### 样式
- 卡片阴影: `$shadow-md`
- Hover 效果: 阴影加深 + 偏移 (-6px, -6px)
- 标签使用 accent 背景

---

## 2. 统计组件 (Stats)

### 组件选择
使用 x-theme 的 `.stats` 组件

### 位置
在首页 `content/_index.md` 或 About 页面顶部添加

### 数据
| 指标 | 值 | 类型 |
|------|-----|------|
| 文章总数 | 6 | 静态计算 |
| 分类数 | 2 | 静态计算 |
| 标签数 | 8 | 静态计算 |
| GitHub Stars | 手动维护 | 静态 |
| 设计风格 | 90s Print | 静态 |

### 实现
```html
<div class="stats">
  <div class="stat-item">
    <div class="stat-number">6</div>
    <div class="stat-label">文章</div>
  </div>
  <div class="stat-item">
    <div class="stat-number">2</div>
    <div class="stat-label">分类</div>
  </div>
  <div class="stat-item">
    <div class="stat-number">8</div>
    <div class="stat-label">标签</div>
  </div>
  <!-- 更多 stat-item -->
</div>
```

### 样式
- 数字使用 accent 色 (#ff6b35)
- 标签使用大写 + 字间距
- Hover 时阴影加深 + 偏移

---

## 3. 交互组件

### 3.1 Accordion (折叠面板)

**用途**: AI 日报 FAQ、文章目录折叠

**实现位置**: 文章详情页模板

**结构**:
```html
<div class="accordion">
  <div class="accordion-item">
    <button class="accordion-trigger" aria-expanded="false">
      文章目录
    </button>
    <div class="accordion-content" aria-hidden="true">
      <div class="accordion-body">
        <!-- 目录内容 -->
      </div>
    </div>
  </div>
</div>
```

**JS 依赖**: `/themes/x-theme/static/js/accordion.js`

### 3.2 Tabs (标签页)

**用途**: 代码高亮语言切换、多语言内容对比

**结构**:
```html
<div class="tabs">
  <div class="tab-list" role="tablist">
    <button class="tab-btn" role="tab" aria-selected="true">JavaScript</button>
    <button class="tab-btn" role="tab" aria-selected="false">Python</button>
  </div>
  <div class="tab-panel" role="tabpanel" aria-hidden="false">
    <!-- 内容 -->
  </div>
</div>
```

**JS 依赖**: `/themes/x-theme/static/js/tabs.js`

### 3.3 Modal (对话框)

**用途**: 图片点击放大、项目详情弹窗

**触发方式**: 按钮或图片点击

**结构**:
```html
<button class="btn modal-open" data-modal-target="project-modal">查看详情</button>

<div class="modal" id="project-modal">
  <div class="modal-overlay" data-modal-close></div>
  <div class="modal-content">
    <button class="modal-close" data-modal-close>&times;</button>
    <h3 class="modal-title">项目详情</h3>
    <div class="modal-body"><!-- 内容 --></div>
  </div>
</div>
```

**JS 依赖**: `/themes/x-theme/static/js/modal.js`

### 3.4 Tooltip (提示)

**用途**: 术语解释、技术栈缩写说明

**结构**:
```html
<span class="tooltip">
  Zola
  <span class="tooltip-text tooltip--top">静态站点生成器</span>
</span>
```

**样式**: 深色背景 + 白色文字 + 2px 边框

---

## 4. 色彩方案

**保持 x-theme 默认 90s 印刷美学**

| 用途 | 颜色 | 变量 |
|------|------|------|
| 强调色 | #ff6b35 | $accent-color |
| 主色 | #2563eb | $primary-color |
| 背景 | #f5f0e6 | $bg-color |
| 文字 | #000000 | $text-color |
| 边框 | #000000 | $border-color |

---

## 5. 实施顺序

1. **首页 Stats 统计条** - 展示博客基础数据
2. **About 页面 Portfolio Grid** - 混合展示文章 + 项目
3. **文章页交互组件** - Accordion + Tabs + Modal + Tooltip
4. **验证构建** - `zola build` 无错误

---

## 6. 文件变更

| 操作 | 文件路径 |
|------|----------|
| 修改 | `content/_index.md` - 添加 Stats |
| 修改 | `content/about.md` - 添加 Portfolio |
| 修改 | `themes/x-theme/templates/page.html` - 添加交互组件支持 |
| 修改 | `config.toml` - 确保 `compile_sass = true` |

---

## 7. 验证清单

- [ ] `zola build` 成功
- [ ] `zola check` 无错误
- [ ] 页面在 localhost:1111 预览正常
- [ ] 响应式布局（移动端）正常
- [ ] 所有交互组件可正常工作
