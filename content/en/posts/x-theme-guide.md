+++
title = "x-theme Guide"
date = 2026-03-24
draft = false
description = "A 90s retro print-style Zola blog theme with striking typography, hard shadows, and nostalgic scrolling marquee"
translation_key = "posts/x-theme-guide"
[taxonomies]
categories = ["Zola"]
tags = ["theme", "blog", "zola", "90s"]
+++

[x-theme](https://github.com/xavier2code/x-theme) is a Zola static blog theme inspired by 90s magazine print styles. It combines vintage aesthetics with modern web technologies to provide a unique visual experience.

## Theme Features

### Visual Design

- **Retro Print Style** - Bold headlines, hard shadow effects
- **Google Fonts** - Playfair Display (headings) + Noto Serif SC (body)
- **Responsive Design** - Mobile-friendly navigation menu
- **Scrolling Marquee** - Classic 90s-style information ticker

### Pre-built Components

- Sticky navigation bar
- Post cards with hover animations
- Category badges
- Previous/Next post navigation
- Pagination support

## Quick Start

### 1. Install the Theme

```bash
cd your-zola-site
git submodule add git@github.com:xavier2code/x-theme.git themes/x-theme
```

### 2. Configure zola.toml

```toml
base_url = "https://your-site.com"
title = "My Blog"
theme = "x-theme"
compile_sass = true

taxonomies = [
    { name = "categories", feed = true },
    { name = "tags", feed = true }
]

[extra]
marquee_text = "★ WELCOME TO MY BLOG ★"
```

## Content Organization

### Directory Structure

```
content/
├── _index.md          # Home page
├── posts/
│   ├── _index.md      # Posts list page
│   └── hello-world.md # Article
├── archives/
│   └── _index.md      # Archives page
├── about/
│   └── _index.md      # About page
└── contact/
    └── _index.md      # Contact page
```

### Article Front Matter

```markdown
+++
title = "Article Title"
date = 2026-03-24
draft = false
description = "Article description, shown on list pages"
[taxonomies]
categories = ["Tech"]
tags = ["zola", "blog"]
+++

Article content...
```

### Featured Images

Add `extra.image` to the article front matter to display featured images on the home page:

```markdown
+++
title = "Article with Image"
date = 2026-03-24
[extra]
image = "/images/cover.jpg"
+++
```

## Custom Configuration

### Marquee Text

```toml
[extra]
marquee_text = "★ CUSTOM TEXT ★ SUPPORTS ★ SPECIAL CHARS ★"
```

### Disable Marquee

```toml
[extra]
marquee_text = ""
```

## Development Commands

```bash
# Local preview
zola serve

# Listen on all interfaces (for mobile testing)
zola serve --interface 0.0.0.0 --port 1111

# Production build
zola build

# Check for errors
zola check
```

## Template Structure

```
themes/x-theme/templates/
├── base.html          # Base template (navigation, footer)
├── home.html          # Home page (latest posts + sidebar)
├── section.html       # Section pages (archives, categories)
├── list.html          # Post list (with pagination)
└── page.html          # Single post page
```

## Style Customization

The theme is built with Sass, with variables defined in `themes/x-theme/sass/_variables.scss`:

```scss
$primary-color: #2563eb;    // Primary color
$accent-color: #ff6b35;     // Accent color
$text-color: #1a1a1a;       // Body text color
$border: 3px solid black;   // Border thickness
```

---

Theme project: [github.com/xavier2code/x-theme](https://github.com/xavier2code/x-theme)
