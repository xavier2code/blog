# My Blog

[![Zola](https://img.shields.io/badge/Zola-0.22-orange)](https://www.getzola.org/)
[![Deploy to GitHub Pages](https://github.com/xavier2code/blog/actions/workflows/action.yml/badge.svg)](https://github.com/xavier2code/blog/actions/workflows/action.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A static blog with a 90s print magazine aesthetic — bold typography, hard drop shadows, and scrolling marquees.

## Features

- **90s Print Aesthetic** — Bold headlines, hard shadows, neon accent (#ff6b35)
- **SCSS Styling** — Organized partials for variables, base, components, layout
- **Zola Static Site** — Fast builds, Tera templates, Markdown content
- **Syntax Highlighting** — Dark theme for code blocks
- **Responsive Design** — Works on desktop and mobile

## Quick Start

```bash
# Serve locally (http://localhost:1111)
zola serve

# Build for production
zola build

# Validate configuration
zola check
```

## Tech Stack

| Tool | Purpose |
|------|---------|
| [Zola](https://www.getzola.org/) 0.22+ | Static site generator |
| [Tera](https://tera.netlify.app/) | Template engine |
| SCSS | Stylesheets |

## Documentation

- [AGENTS.md](./AGENTS.md) — Development guide, conventions, commands
- [themes/x-theme/README.md](./themes/x-theme/README.md) — Theme details

## Project Structure

```
├── config.toml          # Zola configuration
├── content/             # Markdown posts and pages
├── static/              # Static assets
├── templates/           # Page templates
└── themes/x-theme/      # Custom theme
    ├── sass/            # SCSS stylesheets
    ├── templates/       # Tera HTML templates
    └── i18n/            # Internationalization
```

## License

MIT
