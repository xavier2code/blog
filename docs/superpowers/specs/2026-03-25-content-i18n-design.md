# Content i18n Design

## Overview

Add content internationalization (i18n) to Zola blog using Zola's built-in multilingual support. Chinese is the default language, English is optional.

## Architecture

- **Method**: Zola native `[languages]` configuration
- **Default Language**: Chinese (no config needed)
- **Secondary Language**: English (via `/en/` URL prefix)
- **Translation Files**: Existing `themes/x-theme/i18n/zh.toml` and `en.toml`

## URL Structure

| Language | URL |
|----------|-----|
| Chinese (default) | `/archives/`, `/posts/xxx/`, `/about/` |
| English | `/en/archives/`, `/en/posts/xxx/`, `/en/about/` |

## Content Structure

```
content/
├── posts/           # Chinese posts (default)
├── about.md         # Chinese about page
├── contact.md       # Chinese contact page
└── en/              # English content
    ├── _index.md
    ├── posts/
    │   ├── ohmyzsh-vs-starship.md
    │   └── x-theme-guide.md
    ├── about.md
    └── contact.md
```

## config.toml Changes

```toml
[languages.en]
language_code = "en-US"
language_name = "English"
weight = 1

[languages.en.translations]
path = "themes/x-theme/i18n/en.toml"
```

## Theme Template Changes

### 1. Remove Custom i18n Loading

Remove from `base.html`:
```jinja2
{% set lang = current_path | truncate(l=3, end="") | trim(start="/") %}
{% if lang != "en" %}{% set_global lang = "zh" %}{% endif %}
{% set i18n = load_data(path="themes/x-theme/i18n/" ~ lang ~ ".toml") %}
```

### 2. Use Zola's get_text()

Replace:
```jinja2
{{ i18n.nav.home }}
```

With:
```jinja2
{{ "nav.home" | i18n }}
```

### 3. Language Switcher

Replace custom switcher with Zola's built-in `get_url()`:
```jinja2
{% if lang == "en" %}
<a href="{{ get_url(path=current_path, lang="zh") }}">中文</a>
{% else %}
<a href="{{ get_url(path=current_path, lang="en") }}">EN</a>
{% endif %}
```

### 4. Files to Update

- `themes/x-theme/templates/base.html` - Remove custom i18n, use Zola built-in
- `themes/x-theme/templates/list.html` - Remove custom i18n loading
- `themes/x-theme/templates/section.html` - Remove custom i18n loading
- `themes/x-theme/templates/index.html` - Remove custom i18n loading
- `themes/x-theme/templates/home.html` - Remove custom i18n loading

## Translation Files (Existing)

`themes/x-theme/i18n/zh.toml` and `en.toml` already exist and work with Zola's i18n.

## Implementation Steps

1. Update `config.toml` with `[languages.en]` configuration
2. Create `content/en/` directory structure with English content
3. Update theme templates to use Zola's `get_text()` instead of custom `load_data()`
4. Update language switcher to use `get_url(path, lang="en")`
5. Remove custom i18n loading code from templates
6. Test build and verify URLs work correctly

## Considerations

- Default language (Chinese) needs no configuration
- English content goes under `content/en/`
- Zola automatically handles URL routing
- Existing `zh.toml` and `en.toml` translation files remain valid
