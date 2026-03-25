# x-theme i18n Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add i18n support to x-theme with Chinese (default) and English translations, URL-based language switching.

**Architecture:** TOML translation files in `themes/x-theme/i18n/`, URL path prefix (`/en/`) for English, custom i18n loading via `load_data()` in templates.

**Tech Stack:** Zola, Tera templates, TOML

---

## File Structure

```
themes/x-theme/
├── i18n/
│   ├── zh.toml          # Create
│   └── en.toml          # Create
└── templates/
    ├── base.html        # Modify - add i18n loading + lang switcher
    ├── list.html        # Modify - use i18n keys
    ├── section.html     # Modify - use i18n keys (in root templates/)
    ├── index.html       # Modify - use i18n keys
    └── home.html        # Modify - use i18n keys
themes/x-theme/sass/
├── _variables.scss      # Modify - add lang switcher colors
└── _components.scss     # Modify - add .lang-switcher styles
```

---

## Task 1: Create Translation Files

**Files:**
- Create: `themes/x-theme/i18n/zh.toml`
- Create: `themes/x-theme/i18n/en.toml`

- [ ] **Step 1: Create i18n directory and zh.toml**

```bash
mkdir -p themes/x-theme/i18n
```

```toml
[nav]
home = "首页"
archive = "归档"
tags = "标签"
categories = "分类"
about = "关于"
contact = "联系"

[common]
read_more = "阅读更多"
all_posts = "所有文章"
posts = "篇文章"
```

- [ ] **Step 2: Create en.toml**

```toml
[nav]
home = "Home"
archive = "Archive"
tags = "Tags"
categories = "Categories"
about = "About"
contact = "Contact"

[common]
read_more = "Read More"
all_posts = "All Posts"
posts = "posts"
```

- [ ] **Step 3: Commit**

```bash
git add themes/x-theme/i18n/
git commit -m "feat: add i18n translation files for x-theme"
```

---

## Task 2: Modify base.html for i18n Support

**Files:**
- Modify: `themes/x-theme/templates/base.html:1-70`

- [ ] **Step 1: Read current base.html**

```bash
cat themes/x-theme/templates/base.html
```

- [ ] **Step 2: Add i18n loading logic after extends**

Add at the top of `{% block content %}`:
```jinja2
{% set lang = current_path | truncate(l=3, end="") | trim(start="/") %}
{% if lang != "en" %}{% set_global lang = "zh" %}{% endif %}
{% set i18n = load_data(path="themes/x-theme/i18n/" ~ lang ~ ".toml") %}
```

- [ ] **Step 3: Replace nav link text with i18n keys**

HOME → `{{ i18n.nav.home }}`
ARCHIVE → `{{ i18n.nav.archive }}`
TAGS → `{{ i18n.nav.tags }}`
CATEGORIES → `{{ i18n.nav.categories }}`
ABOUT → `{{ i18n.nav.about }}`
CONTACT → `{{ i18n.nav.contact }}`

- [ ] **Step 4: Add language switcher in nav**

Add before or after nav links:
```jinja2
<div class="lang-switcher">
    {% if lang == "zh" %}
    <a href="/en{{ current_path | replace(starts_with="/", with="/") }}" class="lang-btn">EN</a>
    {% else %}
    <a href="{{ current_path | replace(starts_with="/en", with="") }}" class="lang-btn">中文</a>
    {% endif %}
</div>
```

- [ ] **Step 5: Commit**

```bash
git add themes/x-theme/templates/base.html
git commit -m "feat: add i18n support and lang switcher to base.html"
```

---

## Task 3: Update list.html to Use i18n

**Files:**
- Modify: `themes/x-theme/templates/list.html`

- [ ] **Step 1: Add i18n loading at top of block**

```jinja2
{% set lang = current_path | truncate(l=3, end="") | trim(start="/") %}
{% if lang != "en" %}{% set_global lang = "zh" %}{% endif %}
{% set i18n = load_data(path="themes/x-theme/i18n/" ~ lang ~ ".toml") %}
```

- [ ] **Step 2: Replace "All Posts" with i18n key**

```jinja2
{{ i18n.common.all_posts }}
```

- [ ] **Step 3: Replace "Read More" with i18n key**

```jinja2
{{ i18n.common.read_more }}
```

- [ ] **Step 4: Commit**

```bash
git add themes/x-theme/templates/list.html
git commit -m "feat: use i18n keys in list.html"
```

---

## Task 4: Update section.html (root templates) to Use i18n

**Files:**
- Modify: `templates/section.html`

- [ ] **Step 1: Add i18n loading at top of block**

```jinja2
{% set lang = current_path | truncate(l=3, end="") | trim(start="/") %}
{% if lang != "en" %}{% set_global lang = "zh" %}{% endif %}
{% set i18n = load_data(path="themes/x-theme/i18n/" ~ lang ~ ".toml") %}
```

- [ ] **Step 2: Replace "posts" with i18n key**

Find and replace the hardcoded text showing post count.

- [ ] **Step 3: Commit**

```bash
git add templates/section.html
git commit -m "feat: use i18n keys in section.html"
```

---

## Task 5: Update index.html and home.html to Use i18n

**Files:**
- Modify: `themes/x-theme/templates/index.html`
- Modify: `themes/x-theme/templates/home.html`

- [ ] **Step 1: Add i18n loading to both templates**

```jinja2
{% set lang = current_path | truncate(l=3, end="") | trim(start="/") %}
{% if lang != "en" %}{% set_global lang = "zh" %}{% endif %}
{% set i18n = load_data(path="themes/x-theme/i18n/" ~ lang ~ ".toml") %}
```

- [ ] **Step 2: Replace "Read More" in both templates**

```jinja2
{{ i18n.common.read_more }}
```

- [ ] **Step 3: Commit**

```bash
git add themes/x-theme/templates/index.html themes/x-theme/templates/home.html
git commit -m "feat: use i18n keys in index.html and home.html"
```

---

## Task 6: Add Language Switcher Styles

**Files:**
- Modify: `themes/x-theme/sass/_components.scss`

- [ ] **Step 1: Add .lang-switcher styles**

```scss
.lang-switcher {
    display: flex;
    gap: $spacing-xs;
    
    .lang-btn {
        font-family: $font-heading;
        font-weight: 700;
        font-size: 0.75rem;
        padding: 4px 8px;
        border: 2px solid $border-color;
        background: $white;
        cursor: pointer;
        text-transform: uppercase;
        
        &:hover {
            background: $accent-color;
            color: $white;
        }
        
        &.active {
            background: $accent-color;
            color: $white;
        }
    }
}
```

- [ ] **Step 2: Commit**

```bash
git add themes/x-theme/sass/_components.scss
git commit -m "feat: add lang-switcher styles"
```

---

## Task 7: Verify Build

- [ ] **Step 1: Run zola build**

```bash
zola build
```

Expected: Success with no errors

- [ ] **Step 2: Run zola check**

```bash
zola check
```

Expected: Only pre-existing external link errors (if any)

- [ ] **Step 3: Serve and verify**

```bash
zola serve
```

Open `http://localhost:1111/archives/` and verify:
- Timeline displays correctly
- Language switcher shows "EN"
- Click "EN" goes to `/en/archives/`

---

## Summary

| Task | Files Changed | Commit |
|------|---------------|--------|
| 1 | +2 new files | feat: add i18n translation files |
| 2 | base.html | feat: add i18n support and lang switcher |
| 3 | list.html | feat: use i18n keys in list.html |
| 4 | section.html | feat: use i18n keys in section.html |
| 5 | index.html, home.html | feat: use i18n keys in index.html and home.html |
| 6 | _components.scss | feat: add lang-switcher styles |
| 7 | (verification only) | - |
