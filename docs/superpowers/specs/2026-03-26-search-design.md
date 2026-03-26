# Search Feature Design

## Overview

Add client-side real-time search to x-theme with Chinese language support. Search box lives in the header navigation bar, uses FlexSearch for indexing, and provides instant search results via a dropdown overlay.

## Requirements

- Real-time (input-as-you-type) search experience
- Support both English and Chinese content
- Search box in header navigation bar
- Search results shown in dropdown with title + excerpt
- Fallback to traditional enter/button submit if needed

## Architecture

### Zola Integration
- Enable `build_search_index = true` in `config.toml`
- Zola generates `public/search_index.json` at build time containing all pages/posts
- Index includes: `title`, `permalink`, `content` (plain text), `description`

### Client-Side Search
- **Library**: FlexSearch v0.7.x (CDN)
- **Chinese tokenization**: FlexSearch's built-in Chinese tokenizer via `zh` language option
- **Data flow**: Page loads → fetch `search_index.json` → FlexSearch index initialized → user types → results update instantly

### Search Index Structure
```json
[
  {
    "title": "Post Title",
    "permalink": "https://example.com/posts/slug/",
    "body": "Plain text content...",
    "description": "Post description"
  }
]
```

## Components

### 1. Search Box (Header)
- Location: Header navigation bar, right side
- Width: ~250px desktop, full-width mobile
- States: default, focused, has-results
- Style: 90s print aesthetic matching theme (border, shadow)

### 2. Search Results Dropdown
- Appears below search box on input
- Max-height with scroll
- Each result: title (link) + description excerpt
- Keyboard navigation: arrow keys + enter to select
- Click outside to close

### 3. Search JS Module
- `themes/x-theme/static/js/search.js`
- Responsibilities: fetch index, init FlexSearch, handle input events, render results
- Debounce: 150ms to avoid excessive searches

## File Changes

| File | Change |
|------|--------|
| `config.toml` | Enable `build_search_index = true` |
| `themes/x-theme/templates/base.html` | Add search box markup, include search.js |
| `themes/x-theme/sass/_components.scss` | Add `.search-*` styles |
| `themes/x-theme/static/js/search.js` | New: search logic |
| `themes/x-theme/templates/index.html` | Stretch: full search results page |

## UI States

### Search Box
- **Default**: Placeholder "Search..." visible
- **Focused**: Border highlight
- **Has results**: Dropdown appears below

### Results Dropdown
- **Empty query**: Hidden
- **No results**: "No results found" message
- **Has results**: List of matching posts

## Responsive Behavior

- Desktop (>768px): Search box ~250px in header
- Mobile (<768px): Search box full-width below header title

## Dependencies (CDN)

```html
<script src="https://cdn.jsdelivr.net/npm/flexsearch@0.7.43/dist/flexsearch.bundle.js"></script>
```

## Verification

1. `zola build` — search_index.json generated in public/
2. `zola serve` — search box appears in header
3. Type query — results appear in real-time
4. Chinese query — results returned correctly
5. Mobile view — search box responsive
6. Click result — navigates to post

## Out of Scope

- Full search results page (can be added later)
- Search within categories/tags filters
- Search analytics
