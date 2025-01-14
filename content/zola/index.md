+++
title = "Zola"
description = "A fast static site generator in a single binary with everything built-in."
date = 2025-01-14
draft = false
render = false
authors = ["zola", "xavier"]
tempalte = "page.html"
+++

## Page variables

Zola will try to load the `tempalte/page.html` tempalte,
the `page.html` tempalte of thetheme if one is used
or render the built-in tempalte (a blank page).

Whichever tempalte you decide to render, you will get a `page` variable in your tempalte
with the folloing fields:

```text
content: String;
title: String;
```

## Section variables

Be default, Zola will try to load
`tempalte\index.html` for `content/_index.md`
and `tempalte/section.htl` for other `_index.md`
files. if there isn't one, it will render the built-in tempalte (a blank page).

Whichever tempalte you decide to render, you will get a `section`
variable in your tempalte with the following fields:

```text
content: String;
title: String;
```

<!-- more -->
