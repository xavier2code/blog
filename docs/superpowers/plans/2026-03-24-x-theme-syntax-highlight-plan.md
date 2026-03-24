# x-theme Syntax Highlighting Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Enable Zola syntax highlighting with 90s neon print aesthetic for x-theme

**Architecture:** Enable Zola's built-in syntax highlighter via config with `style = "class"`, create custom SCSS that overrides Zola's Giallo CSS output with neon color classes matching the 90s print aesthetic.

**Tech Stack:** Zola 0.22 (built-in syntax highlighting via Giallo), SCSS

---

## File Structure

| File | Action |
|------|--------|
| `zola.toml` | Modify - add `[markdown.highlighting]` section |
| `themes/x-theme/sass/_syntax.scss` | Create - neon Giallo color overrides |
| `themes/x-theme/sass/main.scss` | Modify - add `@import "syntax";` |
| `themes/x-theme/sass/_layout.scss` | Modify - update pre/code block styles |
| `themes/x-theme/templates/base.html` | Modify - add giallo.css link |

---

## Task 1: Enable Zola Syntax Highlighting (COMPLETED)

**Files:**
- Modify: `zola.toml`

**Correct config for Zola 0.22:**
```toml
[markdown.highlighting]
style = "class"
theme = "github-dark"
```

Note: `style = "class"` generates CSS classes instead of inline styles. Zola will generate `giallo.css` in the static folder.

---

## Task 2: Create Syntax Highlight SCSS

**Files:**
- Create: `themes/x-theme/sass/_syntax.scss`

- [ ] **Step 1: Create _syntax.scss with neon Giallo color overrides**

```scss
/* 90s Neon Print Syntax Highlighting */
/* Overrides Zola's giallo.css with custom neon colors */

@import url("/giallo.css");

/* Base code styling */
.z-code {
    background-color: #0d0d0d;
    color: #f0f0f0;
}

/* Line highlighting */
.z-hl {
    background-color: #1a1a1a !important;
}

/* Line numbers */
.giallo-ln {
    color: #444;
    user-select: none;
}

/* Comments - Gray italic */
.z-comment { color: #666666; font-style: italic; }

/* Keywords - Neon Orange (main accent) */
.z-keyword,
.z-storage {
    color: #ff6b35;
    font-weight: bold;
}

/* Strings - Electric Pink */
.z-string,
.z-source {
    color: #ff6b9d;
}

/* Functions/Support - Cyan */
.z-support,
.z-entity.z-name.z-function,
.z-meta.z-module-reference {
    color: #00d4ff;
}

/* Types/Classes - Neon Green */
.z-entity.z-name.z-tag,
.z-storage.z-type {
    color: #39ff14;
    font-weight: bold;
}

/* Constants/Numbers - Bright Yellow */
.z-constant,
.z-support.z-constant {
    color: #ffd93d;
    font-weight: bold;
}

/* Variables - Off-white */
.z-variable,
.z-variable.z-other {
    color: #f0f0f0;
}

/* Operators/Punctuation - White */
.z-punctuation,
.z-operator {
    color: #ffffff;
}

/* HTML/XML Tags - Hot Pink */
.z-meta.z-tag,
.z-brackethighlighter.z-tag {
    color: #ff69b4;
}

/* Markup/Headings - Cyan */
.z-markup.z-heading {
    color: #00d4ff;
    font-weight: bold;
}

/* Quotes - Neon Green */
.z-markup.z-quote {
    color: #85e89d;
}

/* Deleted/Inserted - Red/Green */
.z-markup.z-deleted {
    color: #ff0000;
    background-color: #86181d;
}

.z-markup.z-inserted {
    color: #85e89d;
    background-color: #144620;
}

/* Invalid/Broken - Bright Red */
.z-invalid {
    color: #ff0000;
    font-style: italic;
}

/* Error message */
.z-message.z-error {
    color: #ff0000;
}

/* Regex */
.z-string.z-regexp,
.z-source.z-regexp {
    color: #dbedff;
}
```

---

## Task 3: Update Main SCSS

**Files:**
- Modify: `themes/x-theme/sass/main.scss`

- [ ] **Step 1: Add syntax import to main.scss**

```scss
@import "variables";
@import "base";
@import "components";
@import "layout";
@import "marquee";
@import "syntax";
```

---

## Task 4: Update Layout SCSS

**Files:**
- Modify: `themes/x-theme/sass/_layout.scss`

- [ ] **Step 1: Update post-content code block styles**

Find the existing `pre` and `code` styles in `.post-content` and replace with:

```scss
.post-content {
    // ... existing styles ...

    blockquote {
        border-left: 4px solid $primary-color;
        padding-left: $spacing-md;
        margin: $spacing-lg 0;
        font-style: italic;
    }

    // Inline code - neon style
    code:not(pre > code) {
        background: #0d0d0d;
        color: #ff6b35;
        padding: 2px 6px;
        border: 1px solid #ff6b35;
        font-family: "JetBrains Mono", "Fira Code", "Consolas", monospace;
        font-size: 0.9em;
    }

    // Code blocks with syntax highlighting
    pre {
        background: #0d0d0d !important;
        color: #f0f0f0;
        padding: $spacing-md;
        overflow-x: auto;
        border: 3px solid #000;
        box-shadow: 6px 6px 0 #ff6b35;
        margin: $spacing-lg 0;
        font-family: "JetBrains Mono", "Fira Code", "Consolas", monospace;
        font-size: 14px;
        line-height: 1.6;

        code {
            background: transparent;
            color: inherit;
            padding: 0;
            border: none;
            font-size: inherit;
        }
    }
}
```

---

## Task 5: Build and Verify

- [ ] **Step 1: Build site**

Run: `zola build`

- [ ] **Step 2: Verify syntax highlighting works**

Check `public/posts/x-theme-guide/index.html` for:
- `<pre class="giallo z-code">` with Giallo classes
- Colors applied to code tokens (via CSS)

Check `public/main.css` for:
- Custom neon color overrides

---

## Task 6: Commit Changes

- [ ] **Step 1: Stage and commit**

```bash
git add zola.toml themes/x-theme/sass/_syntax.scss themes/x-theme/sass/main.scss themes/x-theme/sass/_layout.scss
git commit -m "feat: add 90s neon syntax highlighting to x-theme"
```
