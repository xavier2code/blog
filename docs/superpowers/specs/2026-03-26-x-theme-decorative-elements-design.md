# x-theme Post Content Decorative Elements Design

**Date**: 2026-03-26
**Author**: xavier2code
**Status**: Approved

---

## Overview

Add Bold Memphis-style decorative elements to x-theme post content to enhance the 90s print aesthetic. These elements will be implemented as CSS classes that can be applied to Markdown-generated HTML.

---

## Design Language

### Bold Memphis Style
- **Geometry**: Triangles, circles, squiggles, zigzag patterns
- **Colors**: Accent #ff6b35 (orange), Primary #2563eb (blue), Black #000
- **Borders**: Thick black borders (3px solid)
- **Shadows**: Hard drop shadows (offset, no blur)
- **Feel**: Playful, energetic, retro magazine

---

## Components

### 1. Drop Cap `.post-content .drop-cap`

**Purpose**: Large decorative first letter at the start of articles

**Appearance**:
- Font size: 4rem, font-weight: 900
- Font family: Playfair Display (heading font)
- Float: left with margin-right
- Background: Accent color (#ff6b35)
- Border: 3px solid black
- Box shadow: 4px 4px 0 black
- Padding: 0.5rem 1rem
- Line height: 1
- Margin bottom: -0.5rem (tight wrap)
- Transform: rotate(-5deg) for playful tilt

**Usage**: Apply class to first `<span>` or `<p>` first character via CSS `:first-of-type::first-letter`

---

### 2. Pull Quote `blockquote.pull-quote`

**Purpose**: Highlight key quotes from article content

**Appearance**:
- Font size: 1.5rem
- Text align: center
- Padding: 2rem
- Margin: 2rem auto
- Max-width: 80%
- Position: relative
- Border: none (remove default left border)
- Border-top and border-bottom: 3px solid black
- Quote marks: Large decorative " " using ::before/::after pseudo-elements in accent color
- Transform: rotate(-1deg) slight tilt
- Background: optional subtle pattern

**Decorative Elements**:
- Zigzag border using SVG or CSS gradient
- Small geometric shapes (circles) at corners in accent color

---

### 3. Decorative Divider

**Purpose**: Section breaks between article parts

**Appearance - Three Variants**:

**A) Zigzag `.divider--zigzag`**:
```
♥ ~ ♥ ~ ♥ ~ ♥
```
- Uses CSS/SVG zigzag pattern
- Color: black, height: 20px
- Margin: 3rem auto
- Max-width: 200px

**B) Geometric Row `.divider--shapes`**:
```
◆ ─ ◆ ─ ◆ ─ ◆ ─ ◆
```
- Small squares/diamonds in accent color
- Separated by horizontal lines in black
- Margin: 2rem auto
- Max-width: 300px

**C) Starburst `.divider--star`**:
```
─────────────────
        ★
─────────────────
```
- Horizontal lines with centered star/starburst
- Lines: 3px solid black
- Star: accent color, 1.5rem size

---

## Implementation Location

All styles will be added to `themes/x-theme/sass/_layout.scss` within the `.post-content` block.

---

## Responsive Behavior

- Drop cap: Scale down to 3rem on mobile
- Pull quote: Full width on mobile, reduced padding
- Dividers: Reduce max-width by 50% on mobile

---

## Usage Examples

### Drop Cap
Automatically applied via CSS `:first-of-type::first-letter` to `.post-content > p:first-of-type`

### Pull Quote
```html
<blockquote class="pull-quote">
  This is an important quote that deserves emphasis.
</blockquote>
```

### Divider
```html
<hr class="divider divider--zigzag">
```

---

## Additional Content Styling

### 4. List Styling `.post-content ul, ol`

**Purpose**: Style unordered and ordered lists to match Memphis theme

**Appearance**:
- Unordered lists: Diamond (◆) markers in accent color
- Ordered lists: Numbered counters in accent color with heading font
- Left padding for marker space
- Bottom margin between items

### 5. Link Styling `.post-content a`

**Purpose**: Make links visually distinct with theme colors

**Appearance**:
- Color: Primary blue (#2563eb)
- Underline: 2px thickness, offset 2px
- Hover: Accent color (#ff6b35), no underline

### 6. Table Styling `.post-content table`

**Purpose**: Style Markdown tables in Memphis style

**Appearance**:
- Full width with border and shadow
- Header: Black background, white text, heading font
- Alternating row colors (subtle accent tint)
- Hover state on rows (accent background)

---

## Color Variables

| Variable | Value | Usage |
|----------|-------|-------|
| `$accent-color` | #ff6b35 | Primary decorative color |
| `$primary-color` | #2563eb | Secondary accent |
| `$border-color` | #000000 | Borders and lines |
| `$white` | #ffffff | Backgrounds |
| `$bg-color` | #f5f0e6 | Page background |
