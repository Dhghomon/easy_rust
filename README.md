# Introduction

Rust is a new language, but already has many textbooks. Many textbooks for Rust have a friendly feel, but Rust needs a textbook written in simple English. A textbook for Rust in simple English will make it easier for more people to learn Rust.

# Rust Playground

If you don't want to install yet, the Rust Playground at https://play.rust-lang.org/ is the best place to start experimenting with Rust. You can write your code and click Run to see the results fast.

Here are some things to know for the Rust Playground:

* Run your code with Run
* Change Debug to Release if you want your code to be faster. Debug: compiles faster, runs slower, contains debug information. Release: compiles slower, runs much faster, removes debug information.
* Click on Share to get a url. You can use that to share your code if you want help.
* Tools: Rustfmt will format your code nicely.
* Tools: Clippy will give you extra information about how to make your code better.
* Config: here you can change your theme to dark mode, and many other configurations.

If you want to install Rust, go here https://www.rust-lang.org/tools/install and follow the instructions. Usually you will use ```rustup``` to install and update Rust.

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



## Floats

Floats are numbers with decimal points. 5.5 is a float, and 6 is an integer. 5.0 is also a float, and even 5. is a float.

```rust
fn main() {
    let my_float = 5.; // Rust sees . and knows that it is a float
}
```

But the types are not called ```float```, they are called ```f32``` and ```f64```. It is the same as integers: the number after ```f``` shows the number of bytes. If you don't write the type, Rust will choose ```f64```.

Of course, only floats of the same type can be used together.

```rust
fn main() {
    let my_float: f64 = 5.0; // This is an f64
    let my_other_float: f32 = 8.5; // This is an f32

    let third_float = my_float + my_other_float;
}
```

When you try to run this, Rust will say:

```
error[E0308]: mismatched types
 --> src\main.rs:5:34
  |
5 |     let third_float = my_float + my_other_float;
  |                                  ^^^^^^^^^^^^^^ expected `f64`, found `f32`
```

The compiler often writes '''expected (type), found (type)''' when you use the wrong type. This means:

```
let my_float: f64 = 5.0; // The compiler sees an f64
let my_other_float: f32 = 8.5; // The compiler sees an f32
let third_float = my_float + // The compiler sees a new variable. It is going to be f64 plus another f64. Now it expects an f64...
let third_float = my_float + my_other_float; // But it found an f32.
```

So when you see "expected (type), found (type)", you must find why the compiler expected a different type.

Of course, with simple numbers it is easy to fix. You can cast the f32 to an f64:

```rust
fn main() {
    let my_float: f64 = 5.0;
    let my_other_float: f32 = 8.5;

    let third_float = my_float + my_other_float as f64; // my_other_float as f64 = use it like an f64
}
```

Or even more simply, remove the type declarations:

```rust
fn main() {
    let my_float = 5.0; // Rust will choose f64
    let my_other_float = 8.5; // Here again it will choose f64

    let third_float = my_float + my_other_float;
}
```

The Rust compiler is smart and will not choose f64 if you need f32:

```rust
fn main() {
    let my_float: f32 = 5.0;
    let my_other_float = 8.5; // Rust will choose f32, because it knows you need to add it to an f32

    let third_float = my_float + my_other_float;
}
```


# Printing hello, world!

A new Rust program always starts with this:

```rust
fn main() {
    println!("Hello, world!");
}
```

* ```fn``` means function,
* ```main``` is the function that starts the program,
* ```()``` means that we didn't give the function anything to start.

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
- Returns an ```i32```. The ```->``` (called a "skinny arrow") shows what the function returns.

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

When you want to give variables to a function, put them inside the ```()```. You have to give them name and write the type.

```rust
fn main() {
    multiply(8, 9); // We can give the numbers directly
    let some_number = 10; // Or we can declare two variables
    let some_other_number = 2;
    multiply(some_number, some_other_number); // and put them in the function
}

fn multiply(number_one: i32, number_two: i32) { // Two i32s will enter the function. We will call them number_one and number_two.
    let result = number_one * number_two;
    println!("{} times {} is {}", number_one, number_two, result);
}
```

Of course, we can also return an i32:

```rust
fn main() {
    let multiply_result = multiply(8, 9); // We used multiply() to print and to give the result to multiply_result
}

fn multiply(number_one: i32, number_two: i32) -> i32 {
    let result = number_one * number_two;
    println!("{} times {} is {}", number_one, number_two, result);
    result
}
```

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

You can use a code block to return a value:

```rust
fn main() {
    let my_number = {
	let second_number = 8;
        second_number + 9 // No semicolon, so the code block returns 8 + 9
    };

    println!("My number is: {}", my_number);
}
```

If you add a semicolon inside the block, it will return ```()``` (nothing):

```rust
fn main() {
    let my_number = {
	let second_number = 8; // declare second_number,
        second_number + 9; // add 9 to second_number
		           // but we didn't return it!
                           // second_number dies now
    };

    println!("My number is: {:?}", my_number);
}
```

So why did we write ```{:?}``` and not ```{}```? We will talk about that now.

# Display and debug

Simple variables in Rust can be printed with ```{}``` inside ```println!()```. But some variables can't, and you need to **debug print**. Debug print is printing for the programmer, because it usually shows more information.

How do you know if you need ```{:?}``` and not ```{}```? The compiler will tell you. For example:

```rust
fn main() {
    let doesnt_print = ();
    println!("This will not print: {}", doesnt_print);
}
```

When we run this, the compiler says:

```
error[E0277]: `()` doesn't implement `std::fmt::Display`
 --> src\main.rs:3:41
  |
3 |     println!("This will not print: {}", doesnt_print);
  |                                         ^^^^^^^^^^^^ `()` cannot be formatted with the default formatter
  |
  = help: the trait `std::fmt::Display` is not implemented for `()`
  = note: in format strings you may be able to use `{:?}` (or {:#?} for pretty-print) instead
  = note: required by `std::fmt::Display::fmt`
  = note: this error originates in a macro (in Nightly builds, run with -Z macro-backtrace for more info)
```

This is a lot of information. But the important part is: ```you may be able to use `{:?}` (or {:#?} for pretty-print) instead```. This means that you can try ```{:?}```, and also ```{:#?}``` (```{:#?}``` prints with different formatting).

So Display means printing with ```{}```, and Debug means printing with ```{:?}```.

One more thing: you can also use print!() without ```ln``` if you don't want a new line.

```rust
fn main() {
    print!("This will not print a new line");
    println!(" so this will be on the same line");
}
```

This prints ```This will not print a new line so this will be on the same line```.


# Mutability (changing)

When you declare a variable with ```let```, it is immutable (cannot be changed).

This will not work:

```rust
fn main() {
    let my_number = 8;
    my_number = 10;
}
```

The compiler says: ```error[E0384]: cannot assign twice to immutable variable `my_number```. This is because variables are immutable if you only write ```let```.

To change a variable, add ```mut```:

```rust
fn main() {
    let mut my_number = 8;
    my_number = 10;
}
```

Now there is no problem.

However, you cannot change the type even with ```mut```. This will not work:

```rust
fn main() {
    let mut my_variable = 8;
    my_variable = "Hello, world!";
}
```

You will see the same "expected" message from the compiler: ```expected integer, found `&str```` (```&str``` is a string type that we will learn soon).

## Shadowing

Shadowing means using ```let``` to declare a new variable with the same name as another variable. It looks like mutability, but it is completely different. Shadowing looks like this:

```rust
fn main() {
    let my_number = 8; // This is an i32
    println!("{}", my_number); // prints 8
    let my_number = 9.2; // This is an f64. It is not my_number - it is completely different!
    println!("{}", my_number) // Prints 9.2
}
```

Here we say that we "shadowed" ```my_number``` with a new "let binding".

So is the first ```my_number``` destroyed? No, but when we call ```my_number``` we now get ```my_number``` the ```f64```. And because they are in the same scope block, we can't see the first ```my_number``` anymore.

But if they are in different blocks, we can see both. For example:

So when you shadow a variable, you don't destroy it. You **block** it.

```rust
fn main() {
    let my_number = 8; // This is an i32
    println!("{}", my_number); // prints 8
    {
        let my_number = 9.2; // This is an f64. It is not my_number - it is completely different!
        println!("{}", my_number) // Prints 9.2
                                  // But the shadowed my_number only lives until here.
                                  // The first my_number is still alive!
    }
    println!("{}", my_number); // prints 8
}
```

So what is the advantage of shadowing? Shadowing is good when you need to change a variable a lot.

```rust
fn main() {
    let final_number = {
        let y = 10;
        let x = 9; // x starts at 9
        let x = times_two(x); // shadow with new x: 18
        let x = x + y; // shadow with new x: 28
        x // return x: final_number is now the value of x
    };
    println!("The number is now: {}", final_number)
}

fn times_two(number: i32) -> i32 {
    number * 2
}
```

Without shadowing you would have to think of different names, even though you don't care about x:

```rust
fn main() {
	// Pretending we are using Rust without shadowing
    let final_number = {
        let y = 10;
        let x = 9; // x starts at 9
        let x_twice = times_two(x); // second name for x
        let x_twice_and_y = x + y; // third name for x
        x_twice_and_y // too bad we didn't have shadowing - we could have just used x
    };
    println!("The number is now: {}", final_number)
}

fn times_two(number: i32) -> i32 {
    number * 2
}
```
