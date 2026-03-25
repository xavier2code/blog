# x-theme i18n Design

## Overview

Add internationalization (i18n) support to x-theme, enabling bilingual content in Chinese and English with URL-based language switching.

## Architecture

- **Language Switching**: URL path prefix (`/en/` for English)
- **Translation Management**: TOML files in `themes/x-theme/i18n/`
- **No Zola built-in i18n**: Custom implementation for flexibility

## File Structure

```
themes/x-theme/
├── i18n/
│   ├── zh.toml    # Chinese translations (default)
│   └── en.toml    # English translations
└── templates/
    ├── base.html  # i18n setup + lang switcher
    └── ...
```

## Translation Files

### `themes/x-theme/i18n/zh.toml`
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

### `themes/x-theme/i18n/en.toml`
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

## URL Structure

| Language | URL |
|----------|-----|
| Chinese (default) | `/archives/`, `/tags/`, `/posts/xxx/` |
| English | `/en/archives/`, `/en/tags/`, `/en/posts/xxx/` |

## Template Implementation

### i18n Loading in base.html

```jinja2
{% set lang = current_path | truncate(l=3, end="") | trim(start="/") %}
{% if lang != "en" %}{% set_global lang = "zh" %}{% endif %}
{% set i18n = load_data(path="themes/x-theme/i18n/" ~ lang ~ ".toml") %}
```

### Translation Usage

```jinja2
<a href="{{ get_url(path="/" ~ (lang ~ "/" if lang == "en" else "")) }}">
  {{ i18n.nav.home }}
</a>
```

### Language Switcher

```jinja2
{% if lang == "zh" %}
<a href="/en{{ current_path | replace(starts_with="/", with="/") }}">EN</a>
{% else %}
<a href="{{ current_path | replace(starts_with="/en", with="") }}">中文</a>
{% endif %}
```

## Implementation Steps

1. Create `themes/x-theme/i18n/` directory
2. Create `zh.toml` and `en.toml` translation files
3. Modify `base.html`:
   - Add i18n loading logic
   - Add language switcher to nav
   - Make nav links use translations
4. Update `list.html`, `section.html`, `index.html`, `home.html` to use i18n keys
5. Add language switcher styles to SCSS
6. Create English content versions under `content/en/` (optional, per-user)

## SCSS Additions

```scss
.lang-switcher {
    .lang-btn {
        font-weight: 700;
        padding: 4px 8px;
        border: 2px solid $border-color;
        
        &.active {
            background: $accent-color;
            color: $white;
        }
    }
}
```

## Considerations

- Content translation (posts) is separate from UI translation
- Users can create `/content/en/` for English posts
- Default language is Chinese (no prefix)
- Language detection via URL path
