+++
title = "Tera"
description = "A powerful, easy to use template engine for Rust"
date = "2025-01-17"
draft = false

[taxonomies]
tags=["documentation", "rust"]

[extra]
comment = true
+++

## Tera

> 🍇 Slow and steady wins the race.

### Usage

The primary method of using Tera is to load and parse all the templates in a given glob.

```text
templates/
  hello.html
  index.html
  products/
    product.html
    price.html
```

Assuming the Rust file is at the same level as the `templates` folder, we can get a Tera instance that way:

```rust
use tera::Tera;

// use globbing
let tera = match Tera::new("templates/**/*.html") {
  Ok(t) => t,
  Err(e) => {
    println!("Parsing error(s): {}", e);
    std::process::exit(1);
  }
}
```
