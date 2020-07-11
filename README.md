# Introduction

Rust is a new language, but already has many textbooks. Many textbooks for Rust have a friendly feel, but Rust needs a textbook written in simple English. A textbook for Rust in simple English will make it easier for more people to learn Rust.

# Primitive types
Primitive types means simple types. We will start with integers. Integers are whole numbers with no decimal point. There are two types of integers:

- Signed integers,
- Unsigned integers.

Signs are ```+``` and ```-```, so signed integers can be positive or negative (e.g. +8, -8). But unsigned integers can only be positive, because they do not have a sign.

The signed integers are: ```i8```, ```i16```, ```i32```, ```i64```, ```i128```, and ```isize```.
The unsigned integers are: ```u8```, ```u16```, ```u64```, ```u128```, and ```usize```.

The number after the i or the u means the number of bits for the number, so numbers with more bits can be larger.

So what is ```isize``` and ```usize```? This means the number of bits on your type of computer. So ```isize``` and ```usize``` on a 32-bit computer is like ```i32``` and ```u32```, and ```isize``` and ```usize``` on a 64-bit computer is like ```i64``` and ```u64```.

If you want to see the smallest and biggest numbers, you can use MIN and MAX. 

```rust
fn main() {
    println!("The smallest i8 is {} and the biggest i8 is {}.", std::i8::MIN, std::i8::MAX);
    println!("The smallest u8 is {} and the biggest u8 is {}.", std::u8::MIN, std::u8::MAX);
    println!("The smallest i16 is {} and the biggest i16 is {}.", std::i16::MIN, std::i16::MAX);
    println!("The smallest u16 is {} and the biggest u16 is {}.", std::u16::MIN, std::u16::MAX);
    println!("The smallest i32 is {} and the biggest i32 is {}.", std::i32::MIN, std::i32::MAX);
    println!("The smallest u32 is {} and the biggest u32 is {}.", std::u32::MIN, std::u32::MAX);
    println!("The smallest i64 is {} and the biggest i64 is {}.", std::i64::MIN, std::i64::MAX);
    println!("The smallest u64 is {} and the biggest u64 is {}.", std::u64::MIN, std::u64::MAX);
    println!("The smallest i128 is {} and the biggest i128 is {}.", std::i128::MIN, std::i128::MAX);
    println!("The smallest u128 is {} and the biggest u128 is {}.", std::u128::MIN, std::u128::MAX);

}
```

This will print:
```rust
The smallest i8 is -128 and the biggest i8 is 127.
The smallest u8 is 0 and the biggest u8 is 255.
The smallest i16 is -32768 and the biggest i16 is 32767.
The smallest u16 is 0 and the biggest u16 is 65535.
The smallest i32 is -2147483648 and the biggest i32 is 2147483647.
The smallest u32 is 0 and the biggest u32 is 4294967295.
The smallest i64 is -9223372036854775808 and the biggest i64 is 9223372036854775807.
The smallest u64 is 0 and the biggest u64 is 18446744073709551615.
The smallest i128 is -170141183460469231731687303715884105728 and the biggest i128 is 170141183460469231731687303715884105727.  
The smallest u128 is 0 and the biggest u128 is 340282366920938463463374607431768211455.
```

There are many uses for the different types of integers. One use is computer performance: a smaller number of bytes is faster to process. But here are some other uses:

```u8``` only goes up to 255, and Unicode and ASCII are the same for these numbers. This means that Rust can safely cast a ```u8``` into a ```char```, using ```as```. (Cast means "simple change")

Casting with ```as``` is useful because Rust always needs to know the type of the integer. For example, this will not compile:

```rust
fn main() {
    let my_number = 100; // We didn't write a type of integer, 
                         // so Rust chooses i32
    println!("{}", my_number as char);

}
```

Here is the reason:

```
error[E0604]: only `u8` can be cast as `char`, not `i32`
 --> src\main.rs:3:20
  |
3 |     println!("{}", my_number as char);
  |                    ^^^^^^^^^^^^^^^^^
```

One easy way to fix this is with ```as```. First we use ```as``` to make my_number a ```u8```, then one more ```as``` to make it a ```char```. Now it will compile:

```rust
fn main() {
    let my_number = 100;
    println!("{}", my_number as u8 as char);
}
```

 
# Type inference

Type inference means that if you don't tell the compiler the type, but it can decide by itself, it will decide. The compiler always needs to know the type of the variables, but you don’t always need to tell it. For example, for ```let my_number = 8```, ```my_number``` will be an ```i32``` (the compiler chooses i32 for integers if you don't tell it) But if you say ```let my_number: u8 = 8```, it will make ```my_number``` a ```u8```, because you told it ```u8```.

Sometimes you need to tell the compiler, for two reasons:
1) You are doing something very complex and the compiler doesn't know the type you want,
2) You want a different type (for example, you want an ```i128```, not an ```i32```)

To specify a type, add a colon after the variable name.
```rust
fn main() {
    let small_number: u8 = 10;
}
```

For numbers, you can specify a type after the number.

```rust
fn main() {
    let small_number = 10u8;
}
```

You can also add ```_``` if you want to make the number easy to read.
```rust
fn main() {
    let small_number = 10_u8;
    let big_number = 100_000_000_i32;
}
```

The ```_``` does not change the number. It is only to make it easy for you to read. And it doesn't matter how many ```_``` you use:

```rust
fn main() {
    let number = 0________u8;
    let number2 = 1___6______2____4______i32;
    println!("{}, {}", number, number2);
}
```

This prints ```0, 1624```.


# Printing hello, world!

A new Rust program always starts with this:

```rust
fn main() {
    println!("Hello, world!");
}
```

*```fn``` means function,
*```main``` is the function that starts the program,
*```()``` means that we didn't give the function anything to start.

```{}``` is a **code block**.

```println!``` is a **macro** that prints to the console. A **macro** is like a function, but more complicated. Macros have a ```!``` after them. We will learn about making macros later. For now, please remember that ```!``` means that it is a macro.

To learn about the ```;```, we will create another function. First, in ```main``` we will print a number 8:

```rust
fn main() {
    println!("Hello, world number {}!", 8);
}
```

The ```{}``` in ```println!``` means "put the variable inside here". This prints ```Hello world number 8```.

We can put more in:

```rust
fn main() {
    println!("Hello, worlds number {} and {}!", 8, 9);
}
```

This prints ```Hello, worlds number 8 and 9!```.

Now let's create the function.

```rust
fn main() {
    println!("Hello, world number {}", number());
}

fn number() -> i32 {
    8
}
```

This also prints ```Hello, world number 8!```. When Rust looks at ```number()``` it sees a function. This function:
- Does not take anything (because it has ```()```)
- Returns an ```i32```.

Inside the function is just ```8```. Because there is no ```;```, this is the value it returns. If it had a ```;```, it would not return anything. Rust will not compile if it has a ```;```:

```rust
fn main() {
    println!("Hello, world number {}", number());
}

fn number() -> i32 {
    8;
}
```

```rust
5 | fn number() -> i32 {
  |    ------      ^^^ expected `i32`, found `()`
  |    |
  |    implicitly returns `()` as its body has no tail or `return` expression
6 |     8;
  |      - help: consider removing this semicolon
```

This means "you told me that ```number()``` returns an ```i32```, but you added a ```;``` so it doesn't return anything". So the compiler suggests removing the semicolon.

## Declaring variables and code blocks

Use ```let``` to declare a variable (declare a variable = tell Rust to make a variable).

```rust
fn main() {
    let my_number = 8;
    println!("Hello, number {}", my_number);
}
```

Variables start and end inside a code block ```{}```. In this example, ```my_number``` ends before we call ```println!```, because it is inside its own code block.

```rust
fn main() {
    {
        let my_number = 8; // my_number starts here
                           // my_number ends here!
    }
    
    println!("Hello, number {}", my_number); // there is no my_number and
                                             // println!() can't find it
}
```
