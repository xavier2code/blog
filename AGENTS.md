# AGENTS.md - Blog Project Guide

This is a Zola static site generator blog project with a custom theme (x-theme).

## Project Overview

- **Static Site Generator**: Zola 0.22
- **Templates**: Tera (HTML)
- **Styling**: SCSS (compiled to CSS)
- **Content**: Markdown with front matter
- **Theme**: x-theme (90s print aesthetic with neon accent #ff6b35)

## Build/Lint/Test Commands

### Zola Commands

```bash
# Build the site (outputs to public/)
zola build

# Serve locally with live reload (default port 1111)
zola serve

# Serve on custom port
zola serve --interface 0.0.0.0 --port 8080

# Validate site configuration and content
zola check

# Build with specific config file
zola build --config-path custom.toml
```

### GitHub Actions

The site auto-deploys to GitHub Pages on push to `main`. Build uses:
```bash
zola build
```

### Testing Single Pages

1. Run `zola serve`
2. Open `http://localhost:1111` to preview
3. Check generated HTML in `public/` directory

## Code Style Guidelines

### Zola Templates (Tera/HTML)

- Use Tera block syntax: `{% block name %}...{% endblock %}`
- Use Tera variable interpolation: `{{ variable }}`
- Access config: `{{ config.title }}`, `{{ config.extra.key }}`
- Get URL paths: `{{ get_url(path="/about") }}`
- Use `current_path` for active nav states
- Use date formatting: `{{ date | date(format="%Y-%m-%d") }}`

Example nav link with active state:
```html
<a href="{{ get_url(path="/about") }}" class="nav-link {% if current_path == "/about" %}active{% endif %}">ABOUT</a>
```

### SCSS Conventions

**File Organization** (in `themes/x-theme/sass/`):
- `_variables.scss` - Colors, typography, spacing, borders, shadows
- `_base.scss` - Reset and base element styles
- `_components.scss` - Reusable UI components
- `_layout.scss` - Page layout and content styling
- `_marquee.scss` - Marquee ticker animation
- `_syntax.scss` - Code syntax highlighting (90s neon theme)
- `main.scss` - Imports all partials

**Naming Conventions**:
- Variables: `$kebab-case` (e.g., `$primary-color`, `$spacing-md`)
- Classes: `.kebab-case` (e.g., `.nav-container`, `.post-content`)
- Mixins: `@mixin camelCase` (e.g., `@mixin boxShadow`)

**Color Variables** (from `_variables.scss`):
```scss
$bg-color: #f5f0e6;
$primary-color: #2563eb;
$accent-color: #ff6b35;  // Main neon accent
$text-color: #000000;
$white: #ffffff;
$border-color: #000000;
```

**Shadow System** (hard drop shadows):
```scss
$shadow-sm: 4px 4px 0 $border-color;
$shadow-md: 6px 6px 0 $border-color;
$shadow-lg: 8px 8px 0 $border-color;
```

**Border System**:
```scss
$border-width: 3px;
$border: $border-width solid $border-color;
```

### Markdown Content

Front matter format:
```toml
+++
title = "Post Title"
date = 2026-03-25
draft = false
+++
```

Use `<!-- more -->` comment to set excerpt break in posts.

### File Paths

- Content: `content/posts/`, `content/about/`, `content/contact/`, etc.
- Templates: `themes/x-theme/templates/`
- SCSS: `themes/x-theme/sass/`
- Static assets: `static/` (copied as-is to `public/`)

### Zola Configuration (zola.toml)

```toml
base_url = "https://example.com"
title = "My Blog"
compile_sass = true
build_search_index = false
theme = "x-theme"

[markdown.highlighting]
style = "class"
theme = "github-dark"

[extra]
marquee_text = "★ WELCOME ★"
```

### Git Commit Convention

Use conventional commits:
```bash
git commit -m "feat: add new post about topic"
git commit -m "fix: correct syntax highlighting colors"
git commit -m "docs: update AGENTS.md"
```

## Code Review Checklist

Before committing:
- [ ] Run `zola build` - site compiles without errors
- [ ] Run `zola check` - configuration is valid
- [ ] Test in browser via `zola serve`
- [ ] Check SCSS compilation (no Sass::SyntaxError)
- [ ] Verify responsive layout works
- [ ] Check syntax highlighting for code blocks
