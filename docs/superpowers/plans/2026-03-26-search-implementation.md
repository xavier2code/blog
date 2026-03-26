# Search Feature Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add real-time client-side search with Chinese support to x-theme via FlexSearch.

**Architecture:** Zola generates `search_index.json` at build time. Browser loads FlexSearch from CDN, fetches index, and performs real-time search with Chinese tokenization. Results appear in a dropdown below the search box in the header.

**Tech Stack:** FlexSearch 0.7.43 (CDN), Vanilla JS, SCSS

---

## File Changes

| File | Change |
|------|--------|
| `config.toml` | Enable `build_search_index = true` |
| `themes/x-theme/templates/base.html` | Add search box, include FlexSearch CDN + search.js |
| `themes/x-theme/static/js/search.js` | New: search logic with FlexSearch |
| `themes/x-theme/sass/_components.scss` | Add `.search-*` styles |

---

## Tasks

### Task 1: Enable search index in config.toml

**Files:**
- Modify: `config.toml:4`

- [ ] **Step 1: Enable build_search_index**

```diff
 build_search_index = false
+build_search_index = true
```

- [ ] **Step 2: Commit**

```bash
git add config.toml
git commit -m "feat: enable Zola search index"
```

---

### Task 2: Create search.js module

**Files:**
- Create: `themes/x-theme/static/js/search.js`

- [ ] **Step 1: Write search.js**

```javascript
(function() {
    const FLEXSEARCH_CDN = 'https://cdn.jsdelivr.net/npm/flexsearch@0.7.43/dist/flexsearch.bundle.js';
    const SEARCH_INDEX_URL = '/search_index.json';
    const DEBOUNCE_MS = 150;

    let searchIndex = null;
    let searchData = [];
    let searchBox = null;
    let resultsDropdown = null;
    let debounceTimer = null;
    let activeIndex = -1;
    let resultLinks = [];

    async function loadFlexSearch() {
        if (window.FlexSearch) return;
        return new Promise((resolve, reject) => {
            const script = document.createElement('script');
            script.src = FLEXSEARCH_CDN;
            script.onload = resolve;
            script.onerror = reject;
            document.head.appendChild(script);
        });
    }

    async function loadSearchIndex() {
        const response = await fetch(SEARCH_INDEX_URL);
        if (!response.ok) {
            console.warn('Search index not found');
            return [];
        }
        return response.json();
    }

    function initFlexSearch(data) {
        searchData = data;
        searchIndex = new FlexSearch.Document({
            document: {
                id: 'permalink',
                index: ['title', 'body', 'description'],
                store: ['title', 'permalink', 'description']
            },
            tokenize: 'zh',
            resolution: 9,
            cache: 100
        });

        data.forEach((item, i) => {
            searchIndex.add({
                permalink: item.permalink,
                title: item.title,
                body: item.body || '',
                description: item.description || ''
            });
        });
    }

    function escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    function getExcerpt(text, query, maxLength = 100) {
        if (!text) return '';
        const lowerText = text.toLowerCase();
        const lowerQuery = query.toLowerCase();
        const idx = lowerText.indexOf(lowerQuery);
        if (idx === -1) return text.slice(0, maxLength) + '...';
        
        const start = Math.max(0, idx - 30);
        const end = Math.min(text.length, idx + query.length + 70);
        let excerpt = text.slice(start, end);
        if (start > 0) excerpt = '...' + excerpt;
        if (end < text.length) excerpt += '...';
        return excerpt;
    }

    function renderResults(query) {
        if (!query.trim()) {
            resultsDropdown.innerHTML = '';
            resultsDropdown.classList.remove('show');
            return;
        }

        const results = searchIndex.search(query, { limit: 8, enrich: true });
        
        const seen = new Set();
        const uniqueResults = [];
        results.forEach(r => {
            r.result.forEach(item => {
                if (!seen.has(item.id)) {
                    seen.add(item.id);
                    uniqueResults.push(item.doc);
                }
            });
        });

        if (uniqueResults.length === 0) {
            resultsDropdown.innerHTML = '<div class="search-no-results">No results found</div>';
            resultsDropdown.classList.add('show');
            return;
        }

        resultsDropdown.innerHTML = uniqueResults.map(item => `
            <a href="${escapeHtml(item.permalink)}" class="search-result">
                <div class="search-result-title">${escapeHtml(item.title)}</div>
                ${item.description ? `<div class="search-result-excerpt">${escapeHtml(getExcerpt(item.description, query))}</div>` : ''}
            </a>
        `).join('');
        resultsDropdown.classList.add('show');
        activeIndex = -1;
        resultLinks = Array.from(resultsDropdown.querySelectorAll('.search-result'));
    }

    function handleInput(e) {
        clearTimeout(debounceTimer);
        const query = e.target.value;
        debounceTimer = setTimeout(() => renderResults(query), DEBOUNCE_MS);
    }

    function handleClickOutside(e) {
        if (searchBox && !searchBox.contains(e.target) && !resultsDropdown.contains(e.target)) {
            resultsDropdown.classList.remove('show');
            activeIndex = -1;
        }
    }

    function handleKeydown(e) {
        if (!resultsDropdown.classList.contains('show')) return;
        
        if (e.key === 'Escape') {
            resultsDropdown.classList.remove('show');
        } else if (e.key === 'ArrowDown') {
            e.preventDefault();
            if (activeIndex < resultLinks.length - 1) {
                activeIndex++;
                updateActiveResult();
            }
        } else if (e.key === 'ArrowUp') {
            e.preventDefault();
            if (activeIndex > 0) {
                activeIndex--;
                updateActiveResult();
            }
        } else if (e.key === 'Enter' && activeIndex >= 0) {
            e.preventDefault();
            if (resultLinks[activeIndex]) {
                resultLinks[activeIndex].click();
            }
        }
    }
    
    function updateActiveResult() {
        resultLinks.forEach((link, i) => {
            link.classList.toggle('active', i === activeIndex);
        });
        if (resultLinks[activeIndex]) {
            resultLinks[activeIndex].scrollIntoView({ block: 'nearest' });
        }
    }

    async function init() {
        await loadFlexSearch();
        const data = await loadSearchIndex();
        if (data.length === 0) return;

        initFlexSearch(data);

        searchBox = document.querySelector('.search-input');
        resultsDropdown = document.querySelector('.search-results');

        if (searchBox) {
            searchBox.addEventListener('input', handleInput);
            searchBox.addEventListener('focus', () => {
                if (searchBox.value.trim()) renderResults(searchBox.value);
            });
        }

        document.addEventListener('click', handleClickOutside);
        document.addEventListener('keydown', handleKeydown);
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();
```

- [ ] **Step 2: Commit**

```bash
git add themes/x-theme/static/js/search.js
git commit -m "feat: add search.js with FlexSearch"
```

---

### Task 3: Add search styles to _components.scss

**Files:**
- Modify: `themes/x-theme/sass/_components.scss:302` (append)

- [ ] **Step 1: Add search styles**

Append to end of `_components.scss`:

```scss
// Search
.search-container {
    position: relative;
    margin-left: auto;
    display: flex;
    align-items: center;
}

.search-input {
    font-family: $font-heading;
    font-size: 0.875rem;
    font-weight: 700;
    padding: $spacing-xs $spacing-sm;
    border: 2px solid $border-color;
    background: $white;
    width: 250px;
    outline: none;
    transition: box-shadow $duration-fast $ease-smooth,
                border-color $duration-fast $ease-smooth;
    
    &:focus {
        border-color: $accent-color;
        box-shadow: $shadow-sm;
    }
    
    @media (max-width: 768px) {
        width: 100%;
    }
}

.search-results {
    position: absolute;
    top: 100%;
    right: 0;
    width: 320px;
    max-height: 400px;
    overflow-y: auto;
    background: $white;
    border: $border;
    box-shadow: $shadow-md;
    display: none;
    z-index: 200;
    
    &.show {
        display: block;
    }
    
    @media (max-width: 768px) {
        width: 100%;
        right: 0;
        left: 0;
    }
}

.search-result {
    display: block;
    padding: $spacing-sm;
    border-bottom: 1px solid lighten($border-color, 50%);
    transition: background-color $duration-fast $ease-smooth;
    
    &:last-child {
        border-bottom: none;
    }
    
    &:hover {
        background: lighten($primary-color, 45%);
        text-decoration: none;
    }
}

.search-result-title {
    font-family: $font-heading;
    font-weight: 700;
    font-size: 0.875rem;
    color: $text-color;
    margin-bottom: 2px;
}

.search-result-excerpt {
    font-size: 0.75rem;
    color: #666;
    line-height: 1.4;
}

.search-result.active {
    background: lighten($primary-color, 45%);
}

.search-no-results {
    padding: $spacing-sm;
    font-size: 0.875rem;
    color: #666;
    text-align: center;
}
```

- [ ] **Step 2: Commit**

```bash
git add themes/x-theme/sass/_components.scss
git commit -m "feat: add search component styles"
```

---

### Task 4: Add search box to base.html

**Files:**
- Modify: `themes/x-theme/templates/base.html`

- [ ] **Step 1: Add search container to nav**

After line 45 (`</div>` closing lang-switcher), add:

```html
<div class="search-container">
    <input type="text" class="search-input" placeholder="Search..." aria-label="Search">
    <div class="search-results"></div>
</div>
```

- [ ] **Step 2: Add FlexSearch CDN before closing </head>**

After line 13 (`<link rel="stylesheet"...>`), add:

```html
<script src="https://cdn.jsdelivr.net/npm/flexsearch@0.7.43/dist/flexsearch.bundle.js"></script>
```

- [ ] **Step 3: Include search.js before closing </body>**

After line 86 (closing `</script>`), add:

```html
<script src="{{ get_url(path="js/search.js") }}"></script>
```

- [ ] **Step 4: Commit**

```bash
git add themes/x-theme/templates/base.html
git commit -m "feat: add search box to header navigation"
```

---

### Task 5: Verify implementation

- [ ] **Step 1: Build and check for errors**

```bash
zola build
```

Expected: Builds successfully, generates `public/search_index.json`

- [ ] **Step 2: Verify search index exists**

```bash
ls -la public/search_index.json && head -50 public/search_index.json
```

Expected: JSON file with posts indexed

- [ ] **Step 3: Serve and test in browser**

```bash
zola serve
```

Open http://localhost:1111, type in search box, verify:
- Dropdown appears with results
- Chinese queries return results
- Click result navigates to post
- Click outside closes dropdown

---

## Stretch Goal

### Task 6: Full search results page (index.html)

**Files:**
- Create: `themes/x-theme/templates/index.html`

This renders when visiting `/search` or `/`. Displays all posts with search filter. Optional — implement after core search works.
