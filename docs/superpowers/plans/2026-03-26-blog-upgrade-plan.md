# Blog 升级实现计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**目标:** 对博客进行全方位升级 - 照片墙/作品集、统计组件、交云组件，保持 90s 印刷美学

**架构:** 基于 x-theme 最新版本的组件系统，通过修改内容文件和模板实现功能增强

**技术栈:** Zola 0.22, Tera 模板, SCSS, JavaScript (ES6 模块)

---

## 文件结构

| 操作 | 文件路径 | 职责 |
|------|----------|------|
| 修改 | `content/_index.md` | 首页添加 Stats 统计组件 |
| 修改 | `content/about.md` | 添加 Portfolio Grid 作品集 |
| 修改 | `themes/x-theme/templates/page.html` | 添加交互组件 JS 引用 |
| 修改 | `themes/x-theme/templates/base.html` | 添加全局 JS 初始化 |

---

## 实施任务

### 任务 1: 首页添加 Stats 统计组件

**文件:**
- 修改: `content/_index.md`

- [ ] **Step 1: 读取当前 _index.md 内容**

读取 `/Users/xavier/Projects/github/blog/content/_index.md`

- [ ] **Step 2: 在首页底部添加 Stats 组件**

在文件末尾添加:
```html
## 博客统计

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
  <div class="stat-item">
    <div class="stat-number">90s</div>
    <div class="stat-label">设计风格</div>
  </div>
</div>
```

- [ ] **Step 3: 验证构建**

运行: `zola build`
预期: 成功生成，Stats 组件样式正确

- [ ] **Step 4: 提交**

```bash
git add content/_index.md
git commit -m "feat: add stats component to homepage"
```

---

### 任务 2: About 页面添加 Portfolio Grid

**文件:**
- 修改: `content/about.md`

- [ ] **Step 1: 读取当前 about.md 内容**

读取 `/Users/xavier/Projects/github/blog/content/about.md`

- [ ] **Step 2: 在页面底部添加 Portfolio Grid**

在文件末尾 `</div>` 前添加:
```html
## 作品集

<div class="portfolio-grid">
  <div class="portfolio-item">
    <img class="portfolio-cover" src="/images/posts/article_20260326.png" alt="AI 日报">
    <div class="portfolio-content">
      <h3 class="portfolio-title">AI 热点日报</h3>
      <p class="portfolio-description">每日 AI 行业动态追踪整理</p>
      <div class="portfolio-tags">
        <span class="tag">AI</span>
        <span class="tag">日报</span>
      </div>
    </div>
  </div>
  <div class="portfolio-item">
    <img class="portfolio-cover" src="/images/posts/article_20260325.png" alt="AI 日报">
    <div class="portfolio-content">
      <h3 class="portfolio-title">AI 热点日报｜2026年3月25日</h3>
      <p class="portfolio-description">每日 AI 行业动态追踪整理</p>
      <div class="portfolio-tags">
        <span class="tag">AI</span>
        <span class="tag">日报</span>
      </div>
    </div>
  </div>
  <div class="portfolio-item">
    <img class="portfolio-cover" src="/images/posts/ohmyzsh-vs-starship.png" alt="终端主题对比">
    <div class="portfolio-content">
      <h3 class="portfolio-title">Oh My Zsh vs Starship</h3>
      <p class="portfolio-description">终端主题工具深度对比</p>
      <div class="portfolio-tags">
        <span class="tag">工具</span>
        <span class="tag">终端</span>
      </div>
    </div>
  </div>
  <div class="portfolio-item">
    <img class="portfolio-cover" src="/images/posts/x-theme-guide.png" alt="x-theme 指南">
    <div class="portfolio-content">
      <h3 class="portfolio-title">x-theme 使用指南</h3>
      <p class="portfolio-description">Zola 博客主题安装与配置指南</p>
      <div class="portfolio-tags">
        <span class="tag">Zola</span>
        <span class="tag">教程</span>
      </div>
    </div>
  </div>
</div>
```

- [ ] **Step 3: 验证构建**

运行: `zola build`
预期: Portfolio Grid 组件正确渲染

- [ ] **Step 4: 提交**

```bash
git add content/about.md
git commit -m "feat: add portfolio grid to about page"
```

---

### 任务 3: 添加交互组件 JS 支持

**文件:**
- 修改: `themes/x-theme/templates/base.html`
- 修改: `themes/x-theme/templates/page.html`

- [ ] **Step 1: 读取 base.html 查找 JS 加载位置**

读取 `/Users/xavier/Projects/github/blog/themes/x-theme/templates/base.html`

- [ ] **Step 2: 在 base.html 底部 body 前添加 JS 引用**

找到 `</body>` 前添加:
```html
<script src="{{ get_url(path='/js/accordion.js') }}"></script>
<script src="{{ get_url(path='/js/tabs.js') }}"></script>
<script src="{{ get_url(path='/js/modal.js') }}"></script>
<script src="{{ get_url(path='/js/tooltip.js') }}"></script>
```

- [ ] **Step 3: 读取 page.html 查看当前结构**

读取 `/Users/xavier/Projects/github/blog/themes/x-theme/templates/page.html`

- [ ] **Step 4: 在文章内容区域添加交互组件示例**

在 `{{ post.content }}` 后添加 Accordion 示例:
```html
{% if post.extra.accordion %}
<div class="accordion">
  {% for item in post.extra.accordion %}
  <div class="accordion-item">
    <button class="accordion-trigger" aria-expanded="false">
      {{ item.title }}
    </button>
    <div class="accordion-content" aria-hidden="true">
      <div class="accordion-body">
        {{ item.content }}
      </div>
    </div>
  </div>
  {% endfor %}
</div>
{% endif %}
```

- [ ] **Step 5: 验证构建**

运行: `zola build`
预期: 无错误，JS 文件被正确引用

- [ ] **Step 6: 提交**

```bash
git add themes/x-theme/templates/base.html themes/x-theme/templates/page.html
git commit -m "feat: add interactive component JS support to templates"
```

---

### 任务 4: 最终验证

- [ ] **Step 1: 运行完整构建检查**

```bash
zola build && zola check
```

- [ ] **Step 2: 本地预览**

```bash
zola serve --interface 0.0.0.0 --port 1111
```

- [ ] **Step 3: 检查清单**

- [ ] Stats 组件在首页正确显示
- [ ] Portfolio Grid 在 About 页面正确显示
- [ ] Accordion 组件可正常折叠/展开
- [ ] 响应式布局正常
- [ ] 无控制台错误

- [ ] **Step 4: 提交所有更改**

```bash
git status
git commit -m "feat: complete blog upgrade - stats, portfolio, interactive components"
```

---

## 验证命令

| 命令 | 用途 |
|------|------|
| `zola build` | 构建网站 |
| `zola check` | 检查配置 |
| `zola serve` | 本地预览 |

---

## 预期输出

- 首页底部显示 4 格统计条（文章数、分类数、标签数、设计风格）
- About 页面底部显示 4 列作品集网格
- 文章页支持 Accordion 折叠组件
- 所有组件保持 90s 印刷美学风格
