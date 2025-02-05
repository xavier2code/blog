+++
title = "Ownership in rust"
date = "2025-02-05"
draft = false

[taxonomies]
tags=["documentation", "rust"]

[extra]
comment = true
+++

## The Concept of Ownership

In Rust, ownership is a set of rules that govern how memory is managed in a program.
Unlike languages that use garbage collection (e.g., Java or Python), Rust manages
memory through a system of ownership with a set of rules that the compiler checks
at compile time. These rules ensure that memory is always valid and that there are
no data races or undefined behavior.
The ownership system in Rust is based on three core rules:
Each value in Rust has a single owner. At any given time, only one variable can own
a value. When the owner goes out of scope, the value is dropped. When the owner variable
goes out of scope, the value is automatically deallocated.
Ownership can be transferred between variables. Ownership can be moved from one variable
to another, but only one variable can own the value at a time.

## The Importance of Ownership

Ownership is a fundamental concept in Rust that ensures memory safety without the
need for a garbage collector. It helps prevent common bugs such as null pointer
dereferencing, data races, and memory leaks. By enforcing these rules at compile
time, Rust provides strong guarantees about the safety and correctness of code.

## Applications of Ownership

### Ownership and Variables

When a variable is assigned a value, it becomes the owner of that value. When
the variable goes out of scope, the value is dropped.

Example:

```rust
fn main() {
    let s1 = String::from("hello"); // s1 owns the String value
    {
        let s2 = s1; // s2 now owns the String value, s1 is no longer valid
        println!("{}", s2);
    } // s2 goes out of scope, the String value is dropped
    // println!("{}", s1); // This would cause a compile-time error because s1 no longer owns the value
}
```

In this example, s1 initially owns the String value. When s2 is assigned the value of s1, ownership is transferred to s2, and s1 is no longer valid. When s2 goes out of scope, the String value is dropped.

### Ownership and Functions

When a value is passed to a function, ownership is transferred to the function parameter. When the function returns, ownership is transferred back to the caller.

Example:

```rust
fn take_ownership(s: String) {
    println!("{}", s);
} // s is dropped here

fn main() {
    let s = String::from("hello");
    take_ownership(s); // Ownership of s is transferred to the function
    // println!("{}", s); // This would cause a compile-time error because s no longer owns the value
}
```

In this example, when s is passed to take_ownership, ownership is transferred to the function parameter s. When the function ends, s is dropped, and the original variable s in main is no longer valid.

### Borrowing and References

Rust also allows borrowing values through references, which do not take ownership. References can be either mutable or immutable.
Immutable references (&T) allow multiple references to the same data, but the data cannot be modified.
Mutable references (&mut T) allow a single reference to modify the data, but no other references can exist at the same time.

Example:

```rust
fn main() {
    let s1 = String::from("hello");

    let len = calculate_length(&s1); // Immutable borrow
    println!("The length of '{}' is {}.", s1, len);

    let mut s2 = String::from("hello");
    change(&mut s2); // Mutable borrow
    println!("{}", s2);
}

fn calculate_length(s: &String) -> usize { // s is an immutable reference
    s.len()
} // s goes out of scope here, but it doesn't drop the String value

fn change(s: &mut String) { // s is a mutable reference
    s.push_str(", world");
} // s goes out of scope here, but it doesn't drop the String value
```

In this example, calculate_length takes an immutable reference to s1, allowing it to read the length without taking ownership. change takes a mutable reference to s2, allowing it to modify the String value without taking ownership.

### Ownership and Structs

Structs can own data, and when a struct is dropped, all of its owned data is also dropped.

Example:

```rust
struct User {
    username: String,
    email: String,
    sign_in_count: u64,
}

fn main() {
    let user1 = User {
        email: String::from("someone@example.com"),
        username: String::from("someusername123"),
        sign_in_count: 1,
    };

    let user2 = user1; // Ownership of user1's fields is transferred to user2
    // println!("{}", user1.email); // This would cause a compile-time error because user1 no longer owns its fields
}
```

In this example, user1 owns the String values for email and username. When user2 is assigned the value of user1, ownership of these fields is transferred to user2, and user1 is no longer valid.

### Ownership and Enums

Enums can also own data, and when an enum is dropped, all of its owned data is also dropped.

Example:

```rust
enum IpAddr {
    V4(String),
    V6(String),
}

fn main() {
    let home = IpAddr::V4(String::from("127.0.0.1"));

    let loopback = home; // Ownership of home's data is transferred to loopback
    // println!("{:?}", home); // This would cause a compile-time error because home no longer owns its data
}
```

In this example, home owns the String value for the V4 variant. When loopback is assigned the value of home, ownership of the String value is transferred to loopback, and home is no longer valid.

## Summary

Ownership is a fundamental concept in Rust that ensures memory safety and prevents common bugs such as null pointer dereferencing and data races. By managing memory through a set of ownership rules, Rust provides strong guarantees about the safety and correctness of code. Understanding ownership is crucial for writing idiomatic and safe Rust programs.
