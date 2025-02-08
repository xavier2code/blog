+++
title = "Formatted Output in Rust"
date = "2025-02-08"
draft = false

[taxonomies]
tags=["documentation", "rust"]

[extra]
comment = true
+++

In Rust, `{}` and `{:?}` are used in the `format!` macro and other formatting contexts (like println!) to specify how values should be formatted. They are placeholders that get replaced by the actual values you provide. Here’s a detailed explanation of the differences between them:

## `{}` (Display Trait)

- Purpose: The `{}` placeholder is used for types that implement the `std::fmt::Display` trait. This trait is intended for user-facing output and is designed to produce a human-readable representation of a value.
- Usage: It is typically used for types where you want to provide a simple, readable string representation. Many primitive types (like `i32`, `f64`, `String`, etc.) implement `Display` by default.
- Example:

```rust
let number = 42;
let text = "Hello, world!";
println!("Number: {}, Text: {}", number, text);
```

**Output:**
`Number: 42, Text: Hello, world!`

## `{:?}` (Debug Trait)

- Purpose: The `{:?}` placeholder is used for types that implement the `std::fmt::Debug` trait. This trait is intended for debugging purposes and is designed to produce a representation that is useful for developers. It often includes more detailed information about the structure of the value.
- Usage: It is typically used for complex types (like structs, enums, vectors, etc.) where you want to inspect the internal state of the value. The output is often more verbose and includes information about the type and structure of the value.
- Example:

```rust
let vec = vec![1, 2, 3];
let point = (10, 20);
println!("Vector: {:?}, Point: {:?}", vec, point);
```

**Output:**
`Vector: [1, 2, 3], Point: (10, 20)`

## Key Differences

1. Trait Implementation:

- `{}` requires the `Display` trait.
- `{:?}` requires the `Debug` trait.

2. Output Style:

- `{}` produces a human-readable, user-friendly string.
- `{:?}` produces a more detailed, developer-friendly string.

3. Default Implementations:

- Many primitive types implement `Display` by default.
- The `Debug` trait is automatically derived for structs and enums using `#[derive(Debug)]`.

## Example with Structs

Here’s an example with a custom struct to illustrate the difference:

```rust
#[derive(Debug)] // Automatically derive Debug implementation
struct Person {
    name: String,
    age: u32,
}

impl std::fmt::Display for Person {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        write!(f, "{} (age: {})", self.name, self.age)
    }
}

fn main() {
    let person = Person {
        name: String::from("Alice"),
        age: 30,
    };

    println!("Display: {}", person); // Uses Display trait
    println!("Debug: {:?}", person); // Uses Debug trait
}
```

**Output:**

```sh
Display: Alice (age: 30)
Debug: Person { name: "Alice", age: 30 }

```

**In this example:**

- The `Display` implementation provides a concise, user-friendly string.
- The `Debug` implementation, derived automatically, provides a detailed, developer-friendly string.

## Summary

- Use `{}` when you want a simple, human-readable representation.
- Use `{:?}` when you need a detailed, developer-friendly representation for debugging purposes.
