+++
title = "终端提示符战争：ZSH vs Starship"
date = 2026-03-25
draft = false
[extra]
cover = "/images/posts/ohmyzsh-vs-starship.png"
[taxonomies]
categories = ["Terminal"]
tags = ["zsh", "starship", "fish", "oh-my-zsh", "tool"]
+++

对于命令行重度用户而言，一个美观且功能强大的终端提示符能显著提升开发体验。本文对 **Oh My ZSH**、**Starship** 和 **Fish Shell** 进行全面对比。

<!-- more -->

## Oh My ZSH

> 300+ 插件生态，开箱即用，社区成熟

**Oh My ZSH** 是一个开源的 ZSH 框架，提供了丰富的插件和主题支持。

**优势：**
- 插件生态成熟，内置 300+ 插件（git、docker、npm 等）
- 安装简单，一键脚本完成配置
- 兼容性好，支持所有 Linux 发行版和 macOS
- 社区活跃，文档完善

**不足：**
- 主题定制需要学习 ZSH 脚本语法
- 插件增多后加载速度变慢
- 默认提示符信息相对简单

## Starship

> Rust 编写的跨 shell 提示符工具，速度极快

**Starship** 以速度和美观著称，能在任意 shell 中使用。

**优势：**
- 启动速度极快（比 Oh My ZSH 快 10-100ms）
- 自动检测 Git 仓库状态、语言版本
- 智能显示分支、提交状态、框架信息
- 配置通过 `starship.toml`，无需学习 ZSH 语法
- 跨平台支持，配置一次，多端同步
- 可与任意 shell 配合使用（ZSH、Fish、Bash 等）

**不足：**
- 需要安装 Nerd Font 才能正常显示图标
- 主要是提示符工具，不提供 Oh My ZSH 的插件生态

## Fish Shell

> 无需配置即可使用，设计哲学是"开箱即用"

**Fish Shell** 专注于交互体验，内置了许多 ZSH 需要插件才能实现的功能。

**优势：**
- 内置智能补全、语法高亮、历史搜索
- 比 ZSH 更轻量，响应更灵敏
- 函数系统比 alias 更强大，支持参数传递
- 插件生态：Fisher、Oh-My-Fish 等包管理器

**Fish vs ZSH：**

| 概念 | ZSH | Fish |
|------|-----|------|
| 别名 | `alias ls='ls -la'` | `abbr ls 'ls -la'` |
| 环境变量 | `export VAR=value` | `set -x VAR value` |
| 函数文件 | 无特定要求 | 需放在 `~/.config/fish/functions/` |

## 最佳实践：组合使用

### 方案一：Oh My ZSH + Starship

```bash
# 在 ~/.zshrc 底部添加
eval "$(starship init zsh)"
```

### 方案二：Fish + Starship

```fish
# 安装
brew install starship fish

# 配置
echo "starship init fish | source" >> ~/.config/fish/config.fish
```

## 总结

| 特性 | Oh My ZSH | Starship | Fish |
|------|-----------|----------|------|
| 定位 | ZSH 框架 | 提示符工具 | 交互式 shell |
| 性能 | 中等 | 极快 | 快 |
| 插件生态 | 丰富（300+） | 无 | 中等 |
| 开箱即用 | 一般 | 是 | 是 |
| Shell 搭配 | 需 ZSH | 任意 shell | 独立使用 |

**推荐：**
- 熟悉 ZSH：**Oh My ZSH + Starship 组合**
- 追求现代体验：**Fish + Starship 组合**
- 追求简洁：**纯 Starship**（可搭配任意 shell）

---

*参考来源：[Alex Shepherd](https://alexshepherd.me/posts/zsh-ohmyzsh-starship-rust/) & [Josh Finnie](https://www.joshfinnie.com/blog/moving-from-oh-my-zsh-to-starship-and-fish-shell/)*
