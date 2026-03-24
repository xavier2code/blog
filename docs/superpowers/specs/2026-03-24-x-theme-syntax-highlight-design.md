# x-theme Syntax Highlighting Design Spec

## Overview

Add syntax highlighting to x-theme with a 90s neon print aesthetic that matches the existing accent color (#ff6b35) and retro magazine feel.

## Background

The current code blocks in x-theme render with Zola's default styling (plain black background #1a1a1a with white text), which lacks visual distinction between language constructs and doesn't complement the 90s print aesthetic theme.

## Design Language

### Color Palette (90s Neon Print)

Based on the existing theme accent color (#ff6b35), using high-contrast neon tones inspired by 90s magazine printing:

| Role | Color | Hex |
|------|-------|-----|
| Background | Deep Black | #0d0d0d |
| Primary Text | Off-White | #f0f0f0 |
| Accent (keywords) | Neon Orange | #ff6b35 |
| Strings | Electric Pink | #ff6b9d |
| Functions | Cyan | #00d4ff |
| Numbers/Constants | Bright Yellow | #ffd93d |
| Comments | Gray | #666666 |
| Operators/Punctuation | White | #ffffff |
| Types | Neon Green | #39ff14 |
| Tags (HTML) | Hot Pink | #ff69b4 |

### Typography

- Code font: `"JetBrains Mono", "Fira Code", "Consolas", monospace`
- Font size: 14px
- Line height: 1.6

## Implementation Plan

### 1. Zola Configuration

Update `zola.toml` to enable syntax highlighting:

```toml
[markdown]
highlight_code = true
```

### 2. Create Syntax Highlight SCSS

File: `themes/x-theme/sass/_syntax.scss`

Create CSS classes for each token type that Zola's built-in syntax highlighter outputs:
- `.chroma` (container)
- `.chroma .c` (comments)
- `.chroma .k` (keywords)
- `.chroma .o` (operators)
- `.chroma .s` (strings)
- `.chroma .m` (numbers)
- `.chroma .nf` (function names)
- `.chroma .p` (punctuation)
- `.chroma .nc` (type/class names)
- etc.

### 3. Update Main SCSS

File: `themes/x-theme/sass/main.scss`

Add import for new file:

```scss
@import "syntax";
```

### 4. Add Code Block Styles

Enhance existing `_layout.scss` code block styles to work with syntax highlighter:

```scss
.post-content {
    pre {
        background: #0d0d0d;
        color: #f0f0f0;
        border: 3px solid #000;
        box-shadow: 6px 6px 0 #ff6b35; // Hard shadow with accent color
    }
    
    // Inline code
    code:not(pre > code) {
        background: #0d0d0d;
        color: #ff6b35;
        padding: 2px 6px;
        border: 1px solid #ff6b35;
    }
}
```

## File Changes

| File | Action |
|------|--------|
| `zola.toml` | Add `highlight_code = true` under `[markdown]` |
| `themes/x-theme/sass/_syntax.scss` | Create with neon color classes |
| `themes/x-theme/sass/main.scss` | Add `@import "syntax";` |
| `themes/x-theme/sass/_layout.scss` | Update pre/code styles |

## Testing

1. Build site: `zola build`
2. Verify code blocks render with neon colors
3. Test multiple languages (bash, toml, markdown, html, scss)
4. Test inline code styling
5. Verify hard shadow effect renders correctly
