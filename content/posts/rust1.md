+++
title = "Ownership in rust"
date = "2025-01-22"
draft = false

[taxonomies]
tags=["documentation", "rust"]

[extra]
comment = true
+++

All programs must interact with computer memory. How to request space from memory to store the program's runtime content, and how to release this space when it is no longer needed, have become critical issues and one of the major challenges in the design of all programming languages. Throughout the evolution of computer languages, three main schools of thought have emerged:

- **Garbage Collection (GC):** Continuously identifies and reclaims memory that is no longer in use during program execution. Typical representatives: Java, Go.  
- **Manual Memory Management:** Requires explicit allocation and deallocation of memory through function calls in the program. Typical representative: C++.  
- **Memory Management through Ownership:** The compiler checks and enforces a set of rules at compile time to manage memory. Typical representative: Rust.

Among these, **Rust** has chosen the third approach. The most remarkable aspect is that this checking occurs **only at compile time**, meaning there is **no runtime performance overhead** for the program.

Since ownership is a novel concept, readers will need to invest some time to fully grasp it.

## Here is an example of unsafe code that demonstrates the dangling pointer issue mentioned earlier

```rust
int* foo() {
    int a;          // 变量a的作用域开始
    a = 100;
    char *c = "xyz";   // 变量c的作用域开始
    return &a;
}                   // 变量a和c的作用域结束
```

This code, although it can compile, is actually quite problematic. Both variables `a` and `c` are local variables. The function returns the address of the local variable `a`, but `a` resides on the stack. Once the function scope is exited, the stack memory allocated for `a` is reclaimed by the system, resulting in a **dangling pointer** issue. This is a classic example of a memory safety problem. While the code may compile successfully, it will cause errors at runtime. This issue is common in many programming languages.
