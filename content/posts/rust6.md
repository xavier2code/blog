+++
title = "Understanding proc_macro_attribute in Rust"
date = "2025-02-08"
draft = false

[taxonomies]
tags=["documentation", "rust"]

[extra]
comment = true
+++

`proc_macro_attribute` is a type of procedural macro in Rust that allows you to define custom attributes. These attributes can be attached to items like functions, structs, enums, and more. The macro can then manipulate or generate code based on the item it is attached to.

## Key Concepts

1. Procedural Macros:

- Procedural macros are unhygienic, meaning they behave as if the output token stream was written inline to the code it’s next to.
- They can be function-like, derive, or attribute macros.

2. Attribute Macros:

- Attribute macros define new outer attributes that can be attached to items.
- They are defined by a public function with the `proc_macro_attribute` attribute and a signature of ``(TokenStream, TokenStream) -> TokenStream`.

## Example of `proc_macro_attribute`

Let's create a custom attribute macro that logs the input and output token streams.

1. Create a new procedural macro crate:

```sh
cargo new my_macro --lib
cd my_macro
```

2. Modify `Cargo.toml`:

```toml
[lib]
proc-macro = true

[dependencies]
proc-macro2 = "1.0"
quote = "1.0"
syn = "1.0"
```

3. Implement the attribute macro in `src/lib.rs`:

```rust
extern crate proc_macro;

use proc_macro::TokenStream;
use quote::quote;
use syn::{parse_macro_input, ItemFn};

# [proc_macro_attribute]
pub fn log_streams(attr: TokenStream, item: TokenStream) -> TokenStream {
// Parse the input token stream as a function item
let input_fn = parse_macro_input!(item as ItemFn);

    // Convert the function item back to a token stream for logging
    let item_str = item.to_string();
    let attr_str = attr.to_string();

    // Log the input streams
    println!("Attribute: {}", attr_str);
    println!("Item: {}", item_str);

    // Generate the output token stream
    let expanded = quote! {
        #input_fn
    };

    // Return the generated token stream
    TokenStream::from(expanded)

}
```

4. Use the attribute macro in another crate:

```sh
cargo new my_project
cd my_project
```

Modify `Cargo.toml` to include the macro crate as a dependency:

```toml
[dependencies]
my_macro = { path = "../my_macro" }
```

Use the attribute macro in `src/main.rs`:

```rust
extern crate my_macro;

use my_macro::log_streams;

# [log_streams]
fn my_function() {
  println!("Hello, world!");
}

fn main() {
  my_function();
}
```

When you run this code, the `log_streams` macro will log the input attribute and item token streams to the console.

## Explanation

- Input Token Streams:
  - The first `TokenStream` (`attr`) contains the tokens following the attribute name.
  - The second `TokenStream` (`item`) contains the tokens of the item the attribute is attached to.
- Output Token Stream:
  - The macro generates a new `TokenStream` that replaces the original item. In this example, it simply returns the original item unchanged.
- Use Case:
  - This example logs the token streams for debugging purposes. In a real-world scenario, you might generate additional code or modify the item based on the attribute.

## Summary

`proc_macro_attribute` allows you to define custom attributes that can manipulate or generate code based on the items they are attached to. By using procedural macros, you can create powerful tools for code generation and manipulation at compile time.
