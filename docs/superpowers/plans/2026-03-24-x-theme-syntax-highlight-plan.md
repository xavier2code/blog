# x-theme Syntax Highlighting Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Enable Zola syntax highlighting with 90s neon print aesthetic for x-theme

**Architecture:** Enable Zola's built-in syntax highlighter via config, create custom SCSS with neon color classes that override Zola's Chroma output, apply matching styles to inline code and code blocks with hard shadow effect.

**Tech Stack:** Zola (built-in syntax highlighting), SCSS

---

## File Structure

| File | Action |
|------|--------|
| `zola.toml` | Modify - add `[markdown]` section with `highlight_code = true` |
| `themes/x-theme/sass/_syntax.scss` | Create - neon syntax color classes |
| `themes/x-theme/sass/main.scss` | Modify - add `@import "syntax";` |
| `themes/x-theme/sass/_layout.scss` | Modify - update pre/code block styles |

---

## Task 1: Enable Zola Syntax Highlighting

**Files:**
- Modify: `zola.toml`

- [ ] **Step 1: Add markdown highlight config to zola.toml**

Read current `zola.toml` and add:

```toml
[markdown]
highlight_code = true
```

---

## Task 2: Create Syntax Highlight SCSS

**Files:**
- Create: `themes/x-theme/sass/_syntax.scss`

- [ ] **Step 1: Create _syntax.scss with neon color classes**

```scss
/* 90s Neon Print Syntax Highlighting */

.highlight {
    background: #0d0d0d;
    color: #f0f0f0;
}

// Comments
.chroma {
    background: #0d0d0d;
    color: #f0f0f0;
}

.chroma .c { color: #666666; font-style: italic; } /* Comment */
.chroma .cm { color: #666666; font-style: italic; } /* Comment.Multiline */
.chroma .cp { color: #666666; } /* Comment.Preproc */
.chroma .c1 { color: #666666; font-style: italic; } /* Comment.Single */
.chroma .cs { color: #666666; font-style: italic; } /* Comment.Special */

// Keywords (orange - main accent)
.chroma .k { color: #ff6b35; font-weight: bold; } /* Keyword */
.chroma .kc { color: #ff6b35; font-weight: bold; } /* Keyword.Constant */
.chroma .kd { color: #ff6b35; font-weight: bold; } /* Keyword.Declaration */
.chroma .kn { color: #ff6b35; font-weight: bold; } /* Keyword.Namespace */
.chroma .kp { color: #ff6b35; font-weight: bold; } /* Keyword.Pseudo */
.chroma .kr { color: #ff6b35; font-weight: bold; } /* Keyword.Reserved */
.chroma .kt { color: #ff6b35; font-weight: bold; } /* Keyword.Type */

// Strings (electric pink)
.chroma .s { color: #ff6b9d; } /* String */
.chroma .sa { color: #ff6b9d; } /* String.Addy */
.chroma .sb { color: #ff6b9d; } /* String.Backtick */
.chroma .sc { color: #ff6b9d; } /* String.Char */
.chroma .dl { color: #ff6b9d; } /* String.Delimiter */
.chroma .sd { color: #ff6b9d; } /* String.Doc */
.chroma .se { color: #ff6b9d; font-weight: bold; } /* String.Escape */
.chroma .sh { color: #ff6b9d; } /* String.Heredoc */
.chroma .si { color: #ff6b9d; } /* String.Interpol */
.chroma .sx { color: #ff6b9d; } /* String.Other */
.chroma .sr { color: #ff6b9d; } /* String.Regex */
.chroma .s1 { color: #ff6b9d; } /* String.Single */
.chroma .s2 { color: #ff6b9d; } /* String.Double */

// Functions (cyan)
.chroma .nf { color: #00d4ff; } /* Name.Function */
.chroma .fm { color: #00d4ff; } /* Name.Function.Magic */
.chroma .py { color: #00d4ff; } /* Name.Property */
.chroma .nb { color: #00d4ff; } /* Name.Builtin */
.chroma .bp { color: #00d4ff; } /* Name.Builtin.Pseudo */

// Types/Classes (neon green)
.chroma .nc { color: #39ff14; font-weight: bold; } /* Name.Class */
.chroma .nn { color: #39ff14; } /* Name.Namespace */
.chroma .no { color: #39ff14; } /* Name.Constant */
.chroma .nd { color: #39ff14; } /* Name.Decorator */
.chroma .ni { color: #39ff14; } /* Name.Entity */
.chroma .nl { color: #39ff14; } /* Name.Label */
.chroma .nt { color: #39ff14; } /* Name.Tag */

// Numbers/Constants (bright yellow)
.chroma .m { color: #ffd93d; font-weight: bold; } /* Literal.Number */
.chroma .mb { color: #ffd93d; font-weight: bold; } /* Literal.Number.Bin */
.chroma .mf { color: #ffd93d; font-weight: bold; } /* Literal.Number.Float */
.chroma .mh { color: #ffd93d; font-weight: bold; } /* Literal.Number.Hex */
.chroma .mi { color: #ffd93d; font-weight: bold; } /* Literal.Number.Integer */
.chroma .mo { color: #ffd93d; font-weight: bold; } /* Literal.Number.Oct */
.chroma .il { color: #ffd93d; font-weight: bold; } /* Literal.Number.Integer.Long */
.chroma .a { color: #ffd93d; } /* Literal.Affix */
.chroma .o { color: #ffd93d; } /* Literal.Operator */

// HTML/XML Tags (hot pink)
.chroma .p { color: #ff69b4; } /* Punctuation */
.chroma .ow { color: #ff69b4; font-weight: bold; } /* Operator.Word */

// Variables/Attributes (white)
.chroma .n { color: #f0f0f0; } /* Name */
.chroma .nv { color: #f0f0f0; } /* Name.Variable */
.chroma .vc { color: #f0f0f0; } /* Name.Variable.Class */
.chroma .vg { color: #f0f0f0; } /* Name.Variable.Global */
.chroma .vi { color: #f0f0f0; } /* Name.Variable.Instance */

// Error/Warning
.chroma .err { color: #ff0000; background: #0d0d0d; } /* Error */
.chroma .w { color: #666666; } /* Generic.Whitespace */

// Line numbers
.chroma .ln {
    user-select: none;
    color: #444;
    border-right: 1px solid #333;
    padding-right: 8px;
    margin-right: 12px;
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
        border: 2px solid #ff6b35;
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
- `<pre class="highlight">` with Chroma classes
- Colors applied to code tokens

---

## Task 6: Commit Changes

- [ ] **Step 1: Stage and commit**

```bash
git add zola.toml themes/x-theme/sass/_syntax.scss themes/x-theme/sass/main.scss themes/x-theme/sass/_layout.scss
git commit -m "feat: add 90s neon syntax highlighting to x-theme"
```
