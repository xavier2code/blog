# x-theme 配色升级实施计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 升级 x-theme 配色体系，强化 90s 复古印刷风格

**Architecture:** 纯 CSS 改动，不修改 HTML 结构。通过修改 SCSS 变量应用规则实现配色统一。

**Tech Stack:** SCSS, Zola

---

## 文件结构

| 文件 | 改动 |
|------|------|
| `themes/x-theme/sass/_components.scss` | 修改导航栏、按钮、卡片 hover |
| `themes/x-theme/sass/_layout.scss` | 修改文章标题和英雄文章标题装饰下划线 |
| `themes/x-theme/sass/_base.scss` | 修改链接 hover 颜色 |

---

## Tasks

### Task 1: 升级导航栏配色

**Files:**
- Modify: `themes/x-theme/sass/_components.scss` (行 75-112 导航样式部分)

**目标样式：**
```scss
.nav {
    background: $border-color;  // 黑色背景
}

.nav-link {
    color: $white;  // 白色文字
    border-right: 1px solid rgba(#fff, 0.2);  // 白色分隔线
    
    &:hover {
        background: $accent-color;  // 橙色 hover
        color: $white;
        text-decoration: none;
    }
    
    &.active {
        background: $accent-color;  // 橙色激活状态
        color: $white;
    }
}
```

- [ ] **Step 1: 读取当前导航栏样式**

找到 `.nav`, `.nav-link`, `.nav-container` 相关样式

- [ ] **Step 2: 修改导航栏背景色**

在 `.nav` 或 `.nav-container` 添加 `background: $border-color;`

- [ ] **Step 3: 修改导航链接颜色**

`.nav-link` 改为白色文字，hover/active 改为橙色

- [ ] **Step 4: 验证构建**

```bash
zola build
```

预期：构建成功，导航栏背景为黑色

- [ ] **Step 5: 提交**

```bash
git add themes/x-theme/sass/_components.scss
git commit -m "feat: update nav colors to black bg with orange hover"
```

---

### Task 2: 升级按钮 hover 颜色

**Files:**
- Modify: `themes/x-theme/sass/_components.scss` (行 188-229 按钮样式部分)

**目标样式：**
```scss
.btn:hover {
    background: $accent-color;  // 橙色
    color: $white;
    box-shadow: $shadow-sm;
    text-decoration: none;
}
```

- [ ] **Step 1: 找到按钮 hover 样式**

确认当前 `.btn:hover` 样式

- [ ] **Step 2: 修改 hover 背景为橙色**

- [ ] **Step 3: 验证构建**

```bash
zola build
```

预期：构建成功

- [ ] **Step 4: 提交**

```bash
git add themes/x-theme/sass/_components.scss
git commit -m "feat: update button hover to accent color"
```

---

### Task 3: 升级链接 hover 颜色

**Files:**
- Modify: `themes/x-theme/sass/_base.scss` (行 36-43 链接样式部分)

**目标样式：**
```scss
a {
    color: $text-color;
    text-decoration: none;
    
    &:hover {
        color: $accent-color;  // 橙色
        text-decoration: none;
    }
}
```

- [ ] **Step 1: 修改链接 hover 颜色**

将 `color: $primary-color` 改为 `color: $accent-color`

- [ ] **Step 2: 验证构建**

```bash
zola build
```

- [ ] **Step 3: 提交**

```bash
git add themes/x-theme/sass/_base.scss
git commit -m "feat: update link hover to accent color"
```

---

### Task 4: 升级卡片 hover 阴影为橙色

**Files:**
- Modify: `themes/x-theme/sass/_components.scss` (行 153-185 卡片样式部分)

**目标样式：**
```scss
.card:hover {
    box-shadow: 8px 8px 0 $accent-color;  // 橙色阴影
    transform: translate(-6px, -6px);
}
```

- [ ] **Step 1: 找到卡片 hover 样式**

确认当前 `.card:hover` 的阴影设置

- [ ] **Step 2: 修改阴影颜色为橙色**

将 `$shadow-lg` 或硬编码阴影改为 `$accent-color`

- [ ] **Step 3: 验证构建**

```bash
zola build
```

- [ ] **Step 4: 提交**

```bash
git add themes/x-theme/sass/_components.scss
git commit -m "feat: update card hover shadow to accent color"
```

---

### Task 5: 添加标题下划线装饰

**Files:**
- Modify: `themes/x-theme/sass/_layout.scss` (文章头部样式部分)

**目标样式：**
```scss
.post-header h1 {
    position: relative;
    display: inline-block;
    
    &::after {
        content: '';
        position: absolute;
        bottom: -8px;
        left: 0;
        width: 60px;
        height: 4px;
        background: $accent-color;
    }
}

.hero-post .card-title {
    position: relative;
    display: inline-block;
    
    &::after {
        content: '';
        position: absolute;
        bottom: -4px;
        left: 0;
        width: 40px;
        height: 3px;
        background: $accent-color;
    }
}
```

- [ ] **Step 1: 找到文章标题和英雄文章标题样式位置**

确认 `.post-header h1` 和 `.hero-post .card-title` 位置

- [ ] **Step 2: 添加下划线伪元素**

- [ ] **Step 3: 验证构建**

```bash
zola build
```

- [ ] **Step 4: 提交**

```bash
git add themes/x-theme/sass/_layout.scss
git commit -m "feat: add accent underline decoration to post titles"
```

---

### Task 6: 最终验证

- [ ] **Step 1: 完整构建**

```bash
zola build && zola serve
```

- [ ] **Step 2: 视觉检查清单**

- [ ] 导航栏背景为黑色
- [ ] 导航链接 hover 为橙色
- [ ] 按钮 hover 为橙色
- [ ] 链接 hover 为橙色
- [ ] 卡片 hover 阴影为橙色
- [ ] 文章标题下方有橙色下划线

- [ ] **Step 3: 提交所有更改**

```bash
git add -A
git commit -m "feat: complete x-theme color system upgrade"
```

---

## 实施顺序

1. Task 1: 导航栏配色
2. Task 2: 按钮 hover
3. Task 3: 链接 hover
4. Task 4: 卡片 hover 阴影
5. Task 5: 标题下划线装饰
6. Task 6: 最终验证
