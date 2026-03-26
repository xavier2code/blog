# x-theme 配色升级设计文档

## 概述

对 x-theme 进行配色体系优化，深化 90s 复古印刷杂志美学，同时保持现代可读性。

## 设计目标

1. **统一色彩语言** - 强化 90s 复古感，减少割裂感
2. **保持现有色值** - 不改变核心色值，优化应用比例
3. **强化视觉层次** - 通过色彩突出重要元素

## 当前问题分析

| 问题 | 当前状态 | 影响 |
|------|---------|------|
| 蓝色过于普遍 | #2563eb 用于链接、hover、导航激活 | 缺乏复古感，与整体风格割裂 |
| 橙色应用场景少 | 仅在标签、时间线、代码块使用 | 视觉冲击力不足 |
| 色彩层次模糊 | 黑/白/蓝为主 | 强调色不突出 |

## 色彩系统

### 核心色值（保持不变）

```scss
$bg-color: #f5f0e6;      // 暖米色 - 复古纸张感
$primary-color: #2563eb;  // 蓝色 - 仅用于分类徽章
$accent-color: #ff6b35;   // 霓虹橙 - 核心强调色
$text-color: #000000;      // 黑色 - 正文、标题
$white: #ffffff;           // 白色
$border-color: #000000;    // 边框
```

### 色彩应用规则

#### 高优先级 - 强调色 (#ff6b35)
- 导航激活状态
- 按钮 hover
- 链接 hover
- 卡片 hover 阴影
- 标题下划线装饰
- 时间线年份标记
- 标签背景

#### 中优先级 - 主色 (#000000)
- 正文文字
- 标题
- 卡片边框
- 分割线

#### 低优先级 - 背景色 (#f5f0e6)
- 页面背景
- 卡片背景
- 输入框背景

#### 点缀 - 蓝色 (#2563eb)
- 分类徽章（badge）背景
- 保留少量使用

## 具体改动

### 1. 导航栏

**当前：**
```scss
.nav-link.active { background: $primary-color; }
.nav-link:hover { background: $primary-color; }
```

**改动后：**
```scss
.nav {
    background: $border-color;  // 黑色背景
}
.nav-link {
    color: $white;
    border-right: 1px solid rgba(#fff, 0.2);
    
    &:hover, &.active {
        background: $accent-color;  // 橙色
        color: $white;
    }
}
```

### 2. 按钮

**当前：**
```scss
.btn:hover {
    background: $primary-color;
    color: $white;
}
```

**改动后：**
```scss
.btn:hover {
    background: $accent-color;  // 橙色
    color: $white;
    box-shadow: $shadow-sm;
}
```

### 3. 链接

**当前：**
```scss
a:hover {
    text-decoration: underline;
    color: $primary-color;
}
```

**改动后：**
```scss
a:hover {
    color: $accent-color;  // 橙色
}
```

### 4. 卡片 Hover

**当前：**
```scss
.card:hover {
    box-shadow: $shadow-lg;
    transform: translate(-6px, -6px);
}
```

**改动后：**
```scss
.card:hover {
    box-shadow: 8px 8px 0 $accent-color;  // 橙色阴影
    transform: translate(-6px, -6px);
}
```

### 5. 装饰性标题下划线

**新增样式：**
```scss
.post-header h1,
.hero-title {
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
```

### 6. 代码块（保持现状）

代码块保持霓虹风格作为视觉焦点，不改动。

## 文件变更清单

| 文件 | 改动类型 | 说明 |
|------|---------|------|
| `sass/_variables.scss` | 无改动 | 保持现有色值 |
| `sass/_components.scss` | 修改 | 导航栏、按钮、链接、卡片 hover |
| `sass/_layout.scss` | 修改 | 文章标题装饰下划线 |
| `sass/_base.scss` | 修改 | 链接 hover 颜色 |

## 验证标准

1. ✅ 导航栏背景为黑色，文字/hover 为橙色
2. ✅ 卡片 hover 时阴影为橙色
3. ✅ 链接 hover 变为橙色
4. ✅ 文章标题下方有橙色下划线
5. ✅ 整体视觉层次更清晰
6. ✅ 保持 90s 复古印刷风格

## 兼容性

- 响应式设计保持不变
- 无需修改 HTML 结构
- 纯 CSS 改动，不影响功能
