# 中文搜索修复方案

## 目标

修复 x-theme 主题的搜索功能，使其能够正确搜索中文内容。

## 问题分析

当前实现使用 `elasticlunr.js`，该库按空格/标点分词。中文没有空格作为词边界，导致中文内容无法被正确分词和搜索。

## 技术方案

### 技术选型

- **搜索库**: FlexSearch（轻量、支持分词、性能好）
- **中文分词**: js-segment（成熟的 JS 中文分词库）

### 文件修改

#### 1. themes/x-theme/templates/base.html

- 移除 elasticlunr.js CDN
- 添加 flexsearch.min.js CDN
- 添加 segment.min.js CDN（用于中文分词）

#### 2. themes/x-theme/static/js/search.js

- 改用 FlexSearch 构建索引
- 接入 segment.js 对中文内容进行分词后再索引

#### 3. themes/x-theme/static/search_index.json

- 保持现有结构不变（已包含 title、description、content 字段）

### 分词流程

**建索引时：**
1. 取出 title、description、content
2. 使用 segment.js 对中文文本进行分词
3. 将词数组转为空格分隔的字符串
4. 使用 FlexSearch 索引

**搜索时：**
1. 用户输入查询词
2. 使用 segment.js 对查询词进行分词
3. 使用 FlexSearch 匹配分词后的词

## 依赖CDN

- FlexSearch: `https://unpkg.com/flexsearch@0.7.43/dist/flexsearch.min.js`
- Segment.js: `https://unpkg.com/segment@0.1.9/dist/segment.min.js`
