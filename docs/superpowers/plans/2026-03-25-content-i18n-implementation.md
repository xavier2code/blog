# Content i18n Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add content internationalization using Zola's built-in multilingual support with Chinese as default language.

**Architecture:** Zola native `[languages]` configuration, `/en/` URL prefix for English content, Zola's `get_text()` for translations.

**Tech Stack:** Zola, Tera templates, TOML

---

## File Structure

```
content/
├── posts/           # Chinese posts (default) - existing
├── about.md        # Chinese - existing
├── contact.md      # Chinese - existing
└── en/             # English content - CREATE
    ├── _index.md
    ├── posts/
    │   ├── ohmyzsh-vs-starship.md
    │   └── x-theme-guide.md
    ├── about.md
    └── contact.md

config.toml          # MODIFY - add [languages.en] section

themes/x-theme/templates/
├── base.html        # MODIFY - use Zola i18n, remove custom load_data
├── list.html        # MODIFY - remove custom i18n loading
├── section.html     # MODIFY - remove custom i18n loading
├── index.html       # MODIFY - remove custom i18n loading
└── home.html        # MODIFY - remove custom i18n loading
```

---

## Task 1: Update config.toml with [languages.en]

**Files:**
- Modify: `config.toml`

- [ ] **Step 1: Read current config.toml**

```bash
cat config.toml
```

- [ ] **Step 2: Add [languages.en] configuration**

Add at end of file:
```toml
[languages.en]
language_code = "en-US"
language_name = "English"
weight = 1

[languages.en.translations]
path = "themes/x-theme/i18n/en.toml"
```

- [ ] **Step 3: Commit**

```bash
git add config.toml
git commit -m "feat: add English language configuration"
```

---

## Task 2: Create English Content Directory Structure

**Files:**
- Create: `content/en/_index.md`
- Create: `content/en/posts/_index.md`
- Create: `content/en/posts/ohmyzsh-vs-starship.md`
- Create: `content/en/posts/x-theme-guide.md`
- Create: `content/en/about.md`
- Create: `content/en/contact.md`

- [ ] **Step 1: Create English content directories**

```bash
mkdir -p content/en/posts
```

- [ ] **Step 2: Create content/en/_index.md**

```markdown
+++
title = "English"
generate_feed = true
+++
```

- [ ] **Step 3: Create content/en/posts/_index.md**

```markdown
+++
title = "Posts"
generate_feed = true
+++
```

- [ ] **Step 4: Create English about.md**

Create translation of content/about.md

- [ ] **Step 5: Create English contact.md**

Create translation of content/contact.md

- [ ] **Step 6: Create English posts**

Create translations of posts with proper front matter (translation_key linking to Chinese original)

- [ ] **Step 7: Commit**

```bash
git add content/en/
git commit -m "feat: add English content translations"
```

---

## Task 3: Update base.html to Use Zola i18n

**Files:**
- Modify: `themes/x-theme/templates/base.html`

- [ ] **Step 1: Read current base.html**

```bash
cat themes/x-theme/templates/base.html
```

- [ ] **Step 2: Remove custom i18n loading code (lines 16-18)**

Remove:
```jinja2
{% set lang = current_path | truncate(l=3, end="") | trim(start="/") %}
{% if lang != "en" %}{% set_global lang = "zh" %}{% endif %}
{% set i18n = load_data(path="themes/x-theme/i18n/" ~ lang ~ ".toml") %}
```

- [ ] **Step 3: Replace i18n.nav.* with get_text()**

Replace:
- `{{ i18n.nav.home }}` → `{{ "nav.home" | i18n }}`
- `{{ i18n.nav.archive }}` → `{{ "nav.archive" | i18n }}`
- etc.

- [ ] **Step 4: Update language switcher**

Replace custom switcher with Zola's built-in:
```jinja2
<div class="lang-switcher">
    {% if lang == "en" %}
    <a href="{{ get_url(path=current_path, lang="zh") }}" class="lang-btn">中文</a>
    {% else %}
    <a href="{{ get_url(path=current_path, lang="en") }}" class="lang-btn">EN</a>
    {% endif %}
</div>
```

- [ ] **Step 5: Commit**

```bash
git add themes/x-theme/templates/base.html
git commit -m "feat: use Zola built-in i18n in base.html"
```

---

## Task 4: Update list.html to Use Zola i18n

**Files:**
- Modify: `themes/x-theme/templates/list.html`

- [ ] **Step 1: Read current list.html**

```bash
cat themes/x-theme/templates/list.html
```

- [ ] **Step 2: Remove custom i18n loading (lines 4-6)**

Remove:
```jinja2
{% set lang = current_path | truncate(l=3, end="") | trim(start="/") %}
{% if lang != "en" %}{% set_global lang = "zh" %}{% endif %}
{% set i18n = load_data(path="themes/x-theme/i18n/" ~ lang ~ ".toml") %}
```

- [ ] **Step 3: Replace i18n.common.* with get_text()**

- `{{ i18n.common.all_posts }}` → `{{ "common.all_posts" | i18n }}`

- [ ] **Step 4: Commit**

```bash
git add themes/x-theme/templates/list.html
git commit -m "feat: use Zola built-in i18n in list.html"
```

---

## Task 5: Update section.html (root templates) to Use Zola i18n

**Files:**
- Modify: `templates/section.html`

- [ ] **Step 1: Read current section.html**

```bash
cat templates/section.html
```

- [ ] **Step 2: Remove custom i18n loading**

- [ ] **Step 3: Replace i18n references with get_text()**

- [ ] **Step 4: Commit**

```bash
git add templates/section.html
git commit -m "feat: use Zola built-in i18n in section.html"
```

---

## Task 6: Update index.html and home.html to Use Zola i18n

**Files:**
- Modify: `themes/x-theme/templates/index.html`
- Modify: `themes/x-theme/templates/home.html`

- [ ] **Step 1: Read both files**

- [ ] **Step 2: Remove custom i18n loading from both**

- [ ] **Step 3: Replace i18n references with get_text()**

- [ ] **Step 4: Commit**

```bash
git add themes/x-theme/templates/index.html themes/x-theme/templates/home.html
git commit -m "feat: use Zola built-in i18n in index.html and home.html"
```

---

## Task 7: Verify Build

- [ ] **Step 1: Run zola build**

```bash
zola build
```

Expected: Success

- [ ] **Step 2: Run zola check**

```bash
zola check
```

Expected: Only pre-existing external link errors

- [ ] **Step 3: Verify URLs**

Check that:
- `/archives/` shows Chinese content
- `/en/archives/` shows English content
- Language switcher works correctly

---

## Summary

| Task | Files Changed | Commit |
|------|---------------|--------|
| 1 | config.toml | feat: add English language configuration |
| 2 | +6 files in content/en/ | feat: add English content translations |
| 3 | base.html | feat: use Zola built-in i18n in base.html |
| 4 | list.html | feat: use Zola built-in i18n in list.html |
| 5 | section.html | feat: use Zola built-in i18n in section.html |
| 6 | index.html, home.html | feat: use Zola built-in i18n in index.html and home.html |
| 7 | (verification only) | - |
