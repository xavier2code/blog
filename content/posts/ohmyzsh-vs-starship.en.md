+++
title = "Terminal Prompt Wars: ZSH vs Starship"
date = 2026-03-25
draft = false
[extra]
cover = "/images/posts/ohmyzsh-vs-starship.png"
+++

For heavy command-line users, a beautiful and powerful terminal prompt can significantly improve the development experience. This article provides a comprehensive comparison of **Oh My ZSH**, **Starship**, and **Fish Shell**.

<!-- more -->

## Oh My ZSH

> 300+ plugins, ready out of the box, mature community

**Oh My ZSH** is an open-source ZSH framework with rich plugin and theme support.

**Pros:**
- Mature plugin ecosystem with 300+ built-in plugins (git, docker, npm, etc.)
- Simple installation with one-click script
- Excellent compatibility across Linux distributions and macOS
- Active community with comprehensive documentation

**Cons:**
- Theme customization requires learning ZSH scripting
- Loading speed may slow down with more plugins
- Default prompt provides relatively basic information

## Starship

> Cross-shell prompt written in Rust, extremely fast

**Starship** is known for its speed and aesthetics, working with any shell.

**Pros:**
- Extremely fast startup (10-100ms faster than Oh My ZSH)
- Auto-detects Git repository state and language versions
- Smart display of branch, commit status, and framework info
- Configuration via `starship.toml`, no ZSH scripting required
- Cross-platform support, configure once, sync everywhere
- Works with any shell (ZSH, Fish, Bash, etc.)

**Cons:**
- Requires Nerd Font for proper icon display
- Primarily a prompt tool, no rich plugin ecosystem like Oh My ZSH

## Fish Shell

> "Works out of the box" design philosophy

**Fish Shell** focuses on interactive experience, with many features built-in that ZSH requires plugins for.

**Pros:**
- Built-in smart completions, syntax highlighting, history search
- Lighter than ZSH, more responsive
- Function system more powerful than aliases, supports parameters
- Plugin ecosystem: Fisher, Oh-My-Fish package managers

**Fish vs ZSH:**

| Concept | ZSH | Fish |
|---------|-----|------|
| Alias | `alias ls='ls -la'` | `abbr ls 'ls -la'` |
| Env vars | `export VAR=value` | `set -x VAR value` |
| Function files | No specific requirement | Must be in `~/.config/fish/functions/` |

## Best Practices: Combine and Use

### Option 1: Oh My ZSH + Starship

```bash
# Add to ~/.zshrc
eval "$(starship init zsh)"
```

### Option 2: Fish + Starship

```fish
# Install
brew install starship fish

# Configure
echo "starship init fish | source" >> ~/.config/fish/config.fish
```

## Summary

| Feature | Oh My ZSH | Starship | Fish |
|---------|-----------|----------|------|
| Role | ZSH framework | Prompt tool | Interactive shell |
| Performance | Medium | Extremely fast | Fast |
| Plugin ecosystem | Rich (300+) | None | Medium |
| Out of box | Moderate | Yes | Yes |
| Shell requirement | ZSH required | Any shell | Standalone |

**Recommendations:**
- ZSH familiar:**Oh My ZSH + Starship combo**
- Modern experience:**Fish + Starship combo**
- Maximum simplicity:**Pure Starship** (works with any shell)

---

*Sources: [Alex Shepherd](https://alexshepherd.me/posts/zsh-ohmyzsh-starship-rust/) & [Josh Finnie](https://www.joshfinnie.com/blog/moving-from-oh-my-zsh-to-starship-and-fish-shell/)*
