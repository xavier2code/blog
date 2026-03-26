# x-theme Decorative Elements Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add Bold Memphis-style decorative elements (drop caps, pull quotes, dividers) to x-theme post content styling.

**Architecture:** Add CSS classes to `_layout.scss` within `.post-content` block. All decorative elements are pure CSS with pseudo-elements for geometric shapes.

**Tech Stack:** SCSS, CSS pseudo-elements, CSS gradients

---

## File Structure

- Modify: `themes/x-theme/sass/_layout.scss:235-293` (add new styles within `.post-content` block)

---

## Tasks

### Task 1: Add Drop Cap Styles

**Files:**
- Modify: `themes/x-theme/sass/_layout.scss` (add after `.post-content .highlight` around line 292)

- [ ] **Step 1: Add drop cap CSS**

```scss
// Drop cap - Bold Memphis style
.post-content > p:first-of-type::first-letter {
    font-family: $font-heading;
    font-size: 4rem;
    font-weight: 900;
    float: left;
    margin-right: 0.5rem;
    margin-top: 0.25rem;
    background: $accent-color;
    color: $white;
    border: $border;
    box-shadow: $shadow-sm;
    padding: 0.5rem 1rem;
    line-height: 1;
    margin-bottom: -0.5rem;
    transform: rotate(-5deg);
    
    @media (max-width: 768px) {
        font-size: 3rem;
    }
}
```

- [ ] **Step 2: Test by building site**

Run: `zola build`
Expected: Build succeeds

---

### Task 2: Add Pull Quote Styles

**Files:**
- Modify: `themes/x-theme/sass/_layout.scss` (add after drop cap styles)

- [ ] **Step 1: Add pull quote CSS**

```scss
// Pull quote - Bold Memphis style
.post-content blockquote.pull-quote {
    font-size: 1.5rem;
    text-align: center;
    padding: 2rem;
    margin: 2rem auto;
    max-width: 80%;
    border: none;
    border-top: $border;
    border-bottom: $border;
    position: relative;
    transform: rotate(-1deg);
    background: $accent-light;
    
    // Decorative quote marks
    &::before {
        content: '"';
        font-family: $font-heading;
        font-size: 4rem;
        font-weight: 900;
        color: $accent-color;
        position: absolute;
        top: -1rem;
        left: 50%;
        transform: translateX(-50%);
        background: $bg-color;
        padding: 0 0.5rem;
    }
    
    // Geometric corner decorations (4 corners)
    &::before {
        content: '◆';
        font-size: 1rem;
        color: $accent-color;
        position: absolute;
        top: -0.5rem;
        left: -0.5rem;
        background: $bg-color;
        padding: 0 0.25rem;
    }
    
    &::after {
        content: '◆';
        font-size: 1rem;
        color: $accent-color;
        position: absolute;
        bottom: -0.5rem;
        right: -0.5rem;
        background: $bg-color;
        padding: 0 0.25rem;
    }
    
    p {
        margin-bottom: 0;
        font-style: normal;
    }
    
    @media (max-width: 768px) {
        font-size: 1.25rem;
        padding: 1.5rem;
        max-width: 100%;
    }
}
```

- [ ] **Step 2: Test by building site**

Run: `zola build`
Expected: Build succeeds

---

### Task 3: Add Decorative Divider Styles

**Files:**
- Modify: `themes/x-theme/sass/_layout.scss` (add after pull quote styles)

- [ ] **Step 1: Add divider base styles**

```scss
// Decorative dividers - Bold Memphis style
.post-content .divider {
    border: none;
    height: 20px;
    margin: 3rem auto;
    max-width: 200px;
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
    
    // Zigzag default
    &--zigzag {
        background: linear-gradient(135deg, transparent 50%, $border-color 50%) 0 0 / 10px 3px,
                    linear-gradient(45deg, transparent 50%, $border-color 50%) 0 0 / 10px 3px;
        background-repeat: repeat-x;
        height: 12px;
        
        &::before {
            content: '♥';
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            font-size: 1.25rem;
            color: $accent-color;
            background: $bg-color;
            padding: 0 0.5rem;
        }
    }
    
    // Geometric shapes row
    &--shapes {
        height: 20px;
        max-width: 300px;
        background: linear-gradient(to right, 
            $border-color 0%, $border-color 20%, 
            transparent 20%, transparent 25%,
            $border-color 25%, $border-color 45%,
            transparent 45%, transparent 50%,
            $border-color 50%, $border-color 70%,
            transparent 70%, transparent 75%,
            $border-color 75%, $border-color 100%
        );
        
        &::before {
            content: '◆ ◆ ◆ ◆ ◆';
            position: absolute;
            font-size: 0.5rem;
            color: $accent-color;
            letter-spacing: 8px;
            background: $bg-color;
            padding: 0 1rem;
        }
    }
    
    // Starburst divider
    &--star {
        height: 40px;
        background: linear-gradient(to right, 
            $border-color 0%, $border-color 100%
        );
        background-size: 100% 3px;
        background-position: center;
        background-repeat: no-repeat;
        
        &::before {
            content: '✦';
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            font-size: 1.5rem;
            color: $accent-color;
            background: $bg-color;
            padding: 0.5rem 1rem;
        }
    }
    
    @media (max-width: 768px) {
        max-width: 150px;
    }
}
```

- [ ] **Step 2: Test by building site**

Run: `zola build`
Expected: Build succeeds

---

### Task 4: Add List and Link Styling

**Files:**
- Modify: `themes/x-theme/sass/_layout.scss` (add within `.post-content` block, after existing styles)

- [ ] **Step 1: Add list styling with Memphis accent**

```scss
// Styled lists
.post-content ul, .post-content ol {
    padding-left: 1.5rem;
    margin-bottom: $spacing-md;
    
    li {
        margin-bottom: $spacing-xs;
        position: relative;
    }
}

.post-content ul li::before {
    content: '◆';
    color: $accent-color;
    font-size: 0.5rem;
    position: absolute;
    left: -1.25rem;
    top: 0.5rem;
}

.post-content ol {
    counter-reset: list-counter;
    
    li {
        counter-increment: list-counter;
        
        &::before {
            content: counter(list-counter);
            color: $accent-color;
            font-weight: 700;
            font-family: $font-heading;
            position: absolute;
            left: -1.5rem;
            top: 0;
        }
    }
}

// Links
.post-content a {
    color: $primary-color;
    text-decoration: underline;
    text-decoration-thickness: 2px;
    text-underline-offset: 2px;
    transition: color $duration-fast $ease-smooth;
    
    &:hover {
        color: $accent-color;
        text-decoration: none;
    }
}
```

- [ ] **Step 2: Test by building site**

Run: `zola build`
Expected: Build succeeds

---

### Task 5: Add Table Styling

**Files:**
- Modify: `themes/x-theme/sass/_layout.scss` (add within `.post-content` block)

- [ ] **Step 1: Add table styling**

```scss
// Tables - Bold Memphis style
.post-content table {
    width: 100%;
    border-collapse: collapse;
    margin: $spacing-lg 0;
    box-shadow: $shadow-sm;
    border: $border;
    
    th {
        background: $border-color;
        color: $white;
        font-family: $font-heading;
        font-weight: 700;
        padding: $spacing-sm;
        text-align: left;
        border: 1px solid $border-color;
    }
    
    td {
        padding: $spacing-sm;
        border: 1px solid $border-color;
        background: $white;
    }
    
    tr:nth-child(even) td {
        background: rgba($accent-color, 0.05);
    }
    
    tr:hover td {
        background: $accent-light;
    }
}
```

- [ ] **Step 2: Test by building site**

Run: `zola build`
Expected: Build succeeds

---

### Task 6: Commit Changes

- [ ] **Step 1: Commit all changes**

```bash
git add themes/x-theme/sass/_layout.scss
git commit -m "feat(x-theme): add Bold Memphis decorative elements

- Add drop cap styling with accent color background
- Add pull quote with decorative quote marks
- Add three divider variants (zigzag, shapes, star)
- Add styled lists with geometric markers
- Add Memphis-style table styling
- Add link hover effects with accent color"
```

---

## Verification

After implementation:
1. Run `zola build` - should succeed without errors
2. Run `zola serve` and check a post page (e.g., `/posts/x-theme-guide/`) to see decorative elements applied
3. Verify drop cap appears on first paragraph
4. Test pull quote styling with a blockquote
