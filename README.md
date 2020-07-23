# Introduction

Rust is a new language that already has good textbooks. But sometimes its textbooks are difficult because they are for native English speakers. Many companies and people now learn Rust, and could learn faster with a book that has easy English. This textbook is for these companies and people to learn Rust with simple English.

- [Rust Playground](#rust-playground)
- [Types](#types)
  - [Primitive types](#primitive-types)
- [Chars](#chars)
- [Type inference](#type-inference)
  - [Floats](#floats)
- [Printing hello, world!](#printing-hello-world)
  - [Declaring variables and code blocks](#declaring-variables-and-code-blocks)
- [Display and debug](#display-and-debug)
  - [Smallest and largest numbers](#smallest-and-largest-numbers)
- [Mutability (changing)](#mutability-changing)
  - [Shadowing](#shadowing)
- [The stack, the heap, and pointers](#the-stack-the-heap-and-pointers)
  - [More about printing](#more-about-printing)
- [Strings](#strings)
- [const and static](#const-and-static)
- [More on references](#more-on-references)
- [Mutable references](#mutable-references)
  - [Shadowing again](#shadowing-again)
- [Giving references to functions](#giving-references-to-functions)
- [Copy types](#copy-types)
  - [Variables without values](#variables-without-values)
- [Collection types](#collection-types)
  - [Arrays](#arrays)
- [Vectors](#vectors)
- [Tuples](#tuples)
- [Control flow](#control-flow)
- [Structs](#structs)
- [Enums](#enums)
  - [Enums to use multiple types](#enums-to-use-multiple-types)
- [References and the dot operator](#references-and-the-dot-operator)
- [Destructuring](#destructuring)
- [Loops](#loops)
- [Implementing structs and enums](#implementing-structs-and-enums)
  - [Self](#self)
- [Generics](#generics)
- [Option and Result](#option-and-result)
  - [Result](#result)
- [The ? operator](#the--operator)
  - [When panic and unwrap are good](#when-panic-and-unwrap-are-good)
- [Traits](#traits)
  - [Taking a String and a &str in a function](#taking-a-string-and-a-str-in-a-function)
- [Chaining methods](#chaining-methods)
- [Iterators](#iterators)
  - [How does an iterator work?](#how-does-an-iterator-work)
- [Closures](#closures)
  - [|_| in a closure](#_-in-a-closure)
  - [The dbg! macro and .inspect](#the-dbg-macro-and-inspect)
- [Types of &str](#types-of-str)
- [Lifetimes](#lifetimes)
- [Interior mutability](#interior-mutability)
  - [Cell](#cell)
- [RefCell](#refcell)
- [Mutex](#mutex)
- [RwLock](#rwlock)
- [Cow](#cow)
- [Type aliases](#type-aliases)
  - [Importing inside a function](#importing-inside-a-function)
- [The todo! macro](#the-todo-macro)
- [Rc](#rc)
- [Multiple threads](#multiple-threads)
- [Arc](#arc)
- [Channels](#channels)
- [Reading Rust documents](#reading-rust-documents)
  - [assert_eq!](#assert_eq)
  - [Searching](#searching)
  - [[src] button](#src-button)


# Rust Playground

Maybe you don't want to install Rust yet, and that's okay. You can go to https://play.rust-lang.org/ and start writing Rust. You can write your code there and click Run to see the results.

Here are some tips when using the Rust Playground:

* Run your code with Run
* Change Debug to Release if you want your code to be faster. Debug: compiles faster, runs slower, contains debug information. Release: compiles slower, runs much faster, removes debug information.
* Click on Share to get a url. You can use that to share your code if you want help.
* Tools: Rustfmt will format your code nicely.
* Tools: Clippy will give you extra information about how to make your code better.
* Config: here you can change your theme to dark mode, and many other configurations.

If you want to install Rust, go here https://www.rust-lang.org/tools/install and follow the instructions. Usually you will use ```rustup``` to install and update Rust.

# Types

## Primitive types
Rust has simple types that are called **primitive types**. We will start with integers. Integers are whole numbers with no decimal point. There are two types of integers:

- Signed integers,
- Unsigned integers.

Signs means ```+``` (plus sign) and ```-``` (minus sign), so signed integers can be positive or negative (e.g. +8, -8). But unsigned integers can only be positive, because they do not have a sign.

The signed integers are: ```i8```, ```i16```, ```i32```, ```i64```, ```i128```, and ```isize```.
The unsigned integers are: ```u8```, ```u16```, ```u32```, ```u64```, ```u128```, and ```usize```.

The number after the i or the u means the number of bits for the number, so numbers with more bits can be larger. 8 bits = one byte, so i8 is one byte, i64 is 8 bytes, and so on. Number types with larger sizes can hold larger numbers. For example, a u8 can hold up to 255, but a u16 can hold up to 65535. And a u128 can hold up to 340282366920938463463374607431768211455.

So what is ```isize``` and ```usize```? This means the number of bits on your type of computer. (This is called the **architecture** of your computer.) So ```isize``` and ```usize``` on a 32-bit computer is like ```i32``` and ```u32```, and ```isize``` and ```usize``` on a 64-bit computer is like ```i64``` and ```u64```.

There are many reasons for the different types of integers. One reason is computer performance: a smaller number of bytes is faster to process. But here are some other uses:

Characters in Rust are called ```char```. Every ```char``` has a number: the letter ```A``` is number 65, while the character ```友``` ("friend" in Chinese) is number 21451. The list of numbers is called "Unicode". Unicode uses smaller numbers for characters that are used more, like A through Z, or digits 0 through 9, or space. The characters that are used most get numbers that are less than 256, and they can fit into a ```u8```. This means that Rust can safely **cast** a ```u8``` into a ```char```, using ```as```. (Cast ```u8``` as ```char``` means "pretend ```u8``` is a ```char```")

Casting with ```as``` is useful because Rust always needs to know the type of the integer. For example, this will not compile:

```rust
fn main() {
    let my_number = 100; // We didn't write a type of integer, 
                         // so Rust chooses i32. Rust always
			 // chooses i32 for integers if you don't
			 // tell it to use a different type
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

# Chars

A ```char``` is one character. For a ```char```, use ```''``` instead of ```""```.

All chars are 4 bytes. They are 4 bytes because some characters in a string are more than one byte. For example:

```rust
fn main() {
    let slice = "Hello!";
    println!("Slice is {:?} bytes.", std::mem::size_of_val(slice)); // std::mem::size_of_val gives the size in bytes
    let slice2 = "안녕!"; // Korean for "hi"
    println!("Slice2 is {:?} bytes.", std::mem::size_of_val(slice2));
}
```

```slice``` is six characters in length and six bytes, but ```slice2``` is three characters in length and seven bytes. ```char``` needs to fit any character in any language, so it is 4 bytes long.


 
# Type inference

Type inference means that if you don't tell the compiler the type, but it can decide by itself, it will decide. The compiler always needs to know the type of the variables, but you don’t always need to tell it. For example, for ```let my_number = 8```, ```my_number``` will be an ```i32```. That is because the compiler chooses i32 for integers if you don't tell it. But if you say ```let my_number: u8 = 8```, it will make ```my_number``` a ```u8```, because you told it ```u8```.

So usually the compiler can guess. But sometimes you need to tell it, for two reasons:
1) You are doing something very complex and the compiler doesn't know the type you want.
2) You want a different type (for example, you want an ```i128```, not an ```i32```).

To specify a type, add a colon after the variable name.
```rust
fn main() {
    let small_number: u8 = 10;
}
```

For numbers, you can say the type after the number. You don't need a space - just type it right after the number.

```rust
fn main() {
    let small_number = 10u8; // 10u8 = 10 of type u8
}
```

You can also add ```_``` if you want to make the number easy to read.
```rust
fn main() {
    let small_number = 10_u8; // This is easier to read
    let big_number = 100_000_000_i32; // 100 million is easy to read with _
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

But the types are not called ```float```, they are called ```f32``` and ```f64```. It is the same as integers: the number after ```f``` shows the number of bits. If you don't write the type, Rust will choose ```f64```.

Of course, only floats of the same type can be used together. So you can't add an f32 to an f64.

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

The compiler writes '''expected (type), found (type)''' when you use the wrong type. It reads your code like this:

```rust
let my_float: f64 = 5.0; // The compiler sees an f64
let my_other_float: f32 = 8.5; // The compiler sees an f32. It is a different type.
let third_float = my_float + // The compiler sees a new variable. It must be an f64 plus another f64. Now it expects an f64...
let third_float = my_float + my_other_float; // But it found an f32. It can't add them.
```

So when you see "expected (type), found (type)", you must find why the compiler expected a different type.

Of course, with simple numbers it is easy to fix. You can cast the f32 to an f64 with ```as```:

```rust
fn main() {
    let my_float: f64 = 5.0;
    let my_other_float: f32 = 8.5;

    let third_float = my_float + my_other_float as f64; // my_other_float as f64 = use my_other_float like an f64
}
```

Or even more simply, remove the type declarations. Rust will choose types that can add together.

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
    let my_other_float = 8.5; // Rust will choose f32,

    let third_float = my_float + my_other_float; // because it knows you need to add it to an f32
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

```println!``` is a **macro** that prints to the console. A **macro** is like a function that writes code for you. Macros have a ```!``` after them. We will learn about making macros later. For now, remember that ```!``` means that it is a macro.

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

Inside the function is just ```8```. Because there is no ```;```, this is the value it returns. If it had a ```;```, it would not return anything. Rust will not compile this if it has a ```;```, because the return is ```i32``` and ```;``` returns ```()```, not ```i32```:

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

You can also write ```return 8;``` but in Rust it is normal to just remove the ```;``` to ```return```.

When you want to give variables to a function, put them inside the ```()```. You have to give them a name and write the type.

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
    result // this is the i32 that we return
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
        second_number + 9 // No semicolon, so the code block returns 8 + 9.
	                  // It works just like a function
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

    println!("My number is: {:?}", my_number); // my_number is ()
}
```

So why did we write ```{:?}``` and not ```{}```? We will talk about that now.

# Display and debug

Simple variables in Rust can be printed with ```{}``` inside ```println!()```. But some variables can't, and you need to **debug print**. Debug print is printing for the programmer, because it usually shows more information. Debug sometimes doesn't look pretty, because it has extra information to help you.

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

## Smallest and largest numbers

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

You will see the same "expected" message from the compiler: ```expected integer, found `&str````. ```&str``` is a string type that we will learn soon.

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

# The stack, the heap, and pointers

The stack, the heap, and pointers are very important in Rust.

The stack and the heap are two places to keep memory. The important differences are:

* The stack is very fast, but the heap is not so fast.
* The stack needs to know the size of a variable at compile time. So simple variables like i32 go on the stack, because we know their exact size.
* Some types don't know the size at compile time. But the stack needs to know the exact size. What do you do? You put the data in the heap, because the heap can have any size of data. And to find it, a pointer goes on the stack, because we always know the size of a pointer.

A pointer is like a table of contents in a book.

```
MY BOOK

Chapter                        Page
Chapter 1: My life              1
Chapter 2: My cat               15
Chapter 3: My job               23
Chapter 4: My family            30
Chapter 5: Future plans         43
```

So this is like five pointers. Where is the chapter "My life"? It's on page 1 (it points to page 1). Where is the chapter "My job?" It's on page 23.

A pointer in Rust is usually called a **reference**. A reference means you *borrow* the value, but you don't own it. In Rust, references have a ```&```. So:

* ```let my_variable = 8``` makes a regular variable, but 
* ```let my_reference = &my_variable``` makes a reference. 

This means that ```my_reference``` is only looking at the data of ```my_variable```. ```my_variable``` still owns its data.

## More about printing

We know that ```println!``` can print with ```{}``` (for Display) and ```{:?}``` (for Debug), plus ```{:#?}``` for pretty printing. But there are many other ways to print.

For example, if you have a reference, you can use {:p} to print the pointer address.

```rust
fn main() {
    let number = 9;
    let number_ref = &number;
    println!("{:p}", number_ref);
}
```
This prints ```0xe2bc0ffcfc``` or some other address (it can be different every time).

Or you can print binary, hexadecimal and octal:

```rust
fn main() {
    let number = 555;
    println!("Binary: {:b}, hexadecimal: {:x}, octal: {:o}", number, number, number);
}
```

Or you can add numbers to change the order:

```rust
fn main() {
    let father_name = "Vlad";
    let son_name = "Adrian Fahrenheit";
    let family_name = "Țepeș";
    println!("This is {1} {2}, son of {0} {2}.", father_name, son_name, family_name);
}
```

```father_name``` is in position 0, ```son_name``` is in position 1, and ```family_name``` is in position 2. So it prints ```This is Adrian Fahrenheit Țepeș, son of Vlad Țepeș```.

Maybe you have a very complex string to print and want to add names to the ```{}```. You can do that:

```rust
fn main() {
    println!("{city1} is in {country} and {city2} is also in {country},
but {city3} is not in {country}.", city1 = "Seoul", city2 = "Busan", city3 = "Tokyo", country = "Korea");
}
```

Very complex printing is not used too much in Rust. But here is how to do it.

{variable:padding alignment minimum.maximum}

1) Do you want a variable name?
(Then add a ```:```)
2) Do you want a padding character?
3) What alignment (left / middle / right) or the padding?
4) Do you want a minimum length? (just write a number)
5) Do you want a maximum length? (write a number with a ```.``` in front)


For example, if I want to write "a" with five ㅎ characters on the left and five ㅎ characters on the right:

```rust
fn main() {
    let letter = "a";
    println!("{:ㅎ^11}", letter);
}
```

This prints ```ㅎㅎㅎㅎㅎaㅎㅎㅎㅎㅎ```. Let's look at 1) to 5) for this.

* Do you want a variable name? ```{:ㅎ^11}``` No variable name: it comes before ```:```.
* Do you want a padding character? ```{:ㅎ^11}``` Yes. ㅎ comes after the ```:``` and has a ```^```. ```<``` means padding with the character on the left, ```>``` means on the right, and ```^``` means in the middle.
* Do you want a minimum length? ```{:ㅎ^11}``` Yes: there is an 11 after.
* Do you want a maximum length? ```{:ㅎ^11}``` No: there is no number with a ```.``` before.

Here is an example of many types of formatting.
```rust
fn main() {
    let title = "TODAY'S NEWS";
    println!("{:-^30}", title); // no variable name, pad with -, put in centre, 30 characters long
    let bar = "|";
    println!("{: <15}{: >15}", bar, bar); // no variable name, pad with space, 15 characters each, one to the left, one to the right
    let a = "SEOUL";
    let b = "TOKYO";
    println!("{city1:-<15}{city2:->15}", city1 = a, city2 = b); // variable names city1 and city2, pad with -, one to the left, one to the right
}
```

It prints:
```rust
---------TODAY'S NEWS---------
|                            |
SEOUL--------------------TOKYO
```



# Strings

Rust has two main types of strings: ```String``` and ```&str```. What is the difference?

* ```&str``` is a simple string. When you write ```let my_variable = "Hello, world!"```, you create a ```&str```. A ```&str``` is very fast.
* ```String``` is a more complicated string. It is a bit slower, and has more functions. A ```String``` is a pointer, with data on the heap.

Both ```&str``` and ```String``` are UTF-8. For example, you can write:

```rust
fn main() {
    let name = "서태지"; // This is a Korean name. No problem, because a &str is UTF-8.
    let other_name = String::from("Adrian Fahrenheit Țepeș"); // Ț and ș are no problem in UTF-8.
}
```

You can even write emojis thanks to UTF-8.

```rust
fn main() {
    let name = "😂";
    println!("My name is actually {}", name);   
}
```

So why do we need a ```&``` in front of ```str```, but not for ```String```?

* ```str``` is a dynamically sized type (dynamically sized = the size can be different). For example, the names "서태지" and "Adrian Fahrenheit Țepeș" are not the same size on the stack:

```rust
fn main() {

    println!("A String is always {:?} bytes. It is Sized.", std::mem::size_of::<String>()); // std::mem::size_of::<Type>() gives you the size in bytes of a type
    println!("And an i8 is always {:?} bytes. It is Sized.", std::mem::size_of::<i8>());
    println!("And an f64 is always {:?} bytes. It is Sized.", std::mem::size_of::<f64>());
    println!("But a &str? It can be anything. '서태지' is {:?} bytes. It is not Sized.", std::mem::size_of_val("서태지")); // std::mem::size_of_val() gives you the size in bytes of a variable
    println!("And 'Adrian Fahrenheit Țepeș' is {:?} bytes. It is not Sized.", std::mem::size_of_val("Adrian Fahrenheit Țepeș"));
    
}
```

That is why we need a &, because ```&``` makes a pointer, and Rust knows the size of the pointer. So the pointer goes on the stack. If we wrote ```str```, Rust wouldn't know what to do because it doesn't know the size.

There are many ways to make a ```String```. Here are some:

* ```String::from("This is the string text");``` This a method for String that takes text and creates a String.
* ```"This is the string text".to_string()```. This is a method for &str that makes it a String.
* The ```format!``` macro. This is like ```println!``` except it creates a String instead of printing. So you can do this:

```rust
fn main() {
    let my_name = "Billybrobby";
    let my_country = "USA";
    let my_home = "Korea";

    let together = format!(
        "I am {} and I come from {} but I live in {}.",
        my_name, my_country, my_home
    );
}
```

Now we have a string named together but did not print it yet.

One other way to make a String is called ```.into()``` but it is a bit different. ```.into()``` takes a reference type and makes it a non-reference type. In other words, it makes a non-owned type an owned type. ```&str``` does not own its data because it is just a reference, but ```String``` owns its data. But String is not the only owned type, so this won't work:

```rust
fn main() {
    let my_string = "Try to make this a String".into();
}
```

Rust doesn't know what type you want.

```rust
error[E0282]: type annotations needed
 --> src\main.rs:2:9
  |
2 |     let my_string = "Try to make this a String".into();
  |         ^^^^^^^^^ consider giving `my_string` a type
```

So you can do this:

```rust
fn main() {
    let my_string: String = "Try to make this a String".into();
}
```

And now you get a String.

# const and static
There are two types that don't use ```let``` to declare: ```const``` and ```static```. Also, you need to write the type for them. These are for variables that don't change (```const``` means constant). The difference is that:

* ```const``` is a value that does not change,
* ```static``` is a value that does not change and has a fixed memory location.

So they are almost the same. Rust programmers almost always use ```const```.

You write them with ALL CAPITAL LETTERS, and usually outside of the ```main``` function. 

Two examples are: ```const NUMBER_OF_MONTHS: u32 = 12;``` and ```const SEASONS: [&str; 4] = ["Spring", "Summer", "Fall", "Winter"];```

# More on references

References are very important in Rust. Rust uses references to make sure that all memory access is safe. We know that we use ```&``` to create a reference:

```rust
fn main() {
    let country = String::from("Austria");
    let ref_one = &country;
    let ref_two = &country;

    println!("{}", ref_one);
}
```

```country``` is a ```String```. We created two references to ```country```. They have the type ```&String```: a "reference to a String". We could create one hundred references to ```country``` and it would be no problem.

But this is a problem:

```rust
fn main() {
    let country = return_str();
}

fn return_str() -> &str {
    let country = String::from("Austria");
    let country_ref = &country;
    country_ref
}
```

The function ```return_str()``` creates a String, then it creates a reference to the string. Then it tries to return the reference. But ```country``` only lives inside the function. So after the function is over, ```country_ref``` is referring to memory that is already gone. Rust prevents us from making a mistake with memory.



# Mutable references

If you want to use a reference to change data, you can use a mutable reference. For a mutable reference, you write ```&mut```.

```rust
fn main() {
    let mut my_number = 8; // don't forget to write mut here!
    let num_ref = &mut my_number;
}
```

So what are the two types? ```my_number``` is an ```i32```, and ```num_ref``` is ```&mut i32``` (a "mutable reference to an i32).

So let's use it to add 10 to my_number. But you can't write ```num_ref += 10```, because ```num_ref``` is not the ```i32``` value. To reach the value, we use ```*```. ```*``` means "I don't want the reference, I want the value behind the reference". In other words, one ```*``` erases one ```&```.

```rust
fn main() {
    let mut my_number = 8; 
    let num_ref = &mut my_number;
    *num_ref += 10; // Use * to change the i32 value.
    println!("{}", my_number);
}
```

Because using ```&``` is called "referencing", using ```*``` is called "**de**referencing".


Rust has rules for mutable and immutable references.

Rule 1: If you have only immutable references, you can have as many as you want.
Rule 2: If you have a mutable references, you can only have one. You can't have an immutable reference **and** a mutable reference.

This is because mutable references can change the data. You could get problems if you change the data when other references are reading it.

A good way to understand is to think of a Powerpoint presentation.

Situation one is about only one mutable reference. 

Situation one: An employee is writing a Powerpoint presentation. He wants his manager to help him. The employee gives his login information to his manager, and asks him to help by making edits. Now the manager has a "mutable reference" to the employee's presentation. This is fine, because nobody else is looking at the presentation.

Situation two is about only immutable references.

Situation two: The employee is giving the presentation to 100 people. All 100 people can now see the employee's data. This is fine, because nobody can change the data.

Situation three is the problem situation.

Situation three: The Employee his manager his login information. Then the employee went to give the presentation to 100 people. This is not fine, because the manager can log in and do anything. Maybe his manager will log into the computer and type an email to his mother? Now the 100 people have to watch the manager write an email to his mother instead of the presentation. That's not what they expected to see.

Here is an example of a mutable borrow with an immutable borrow:

```rust
fn main() {
    let mut number = 10;
    let number_ref = &number; 
    let number_change = &mut number; 
    *number_change += 10;
    println!("{}", number_ref); 
}
```

The compiler prints a helpful message to show us the problem.

```
error[E0502]: cannot borrow `number` as mutable because it is also borrowed as immutable
 --> src\main.rs:4:25
  |
3 |     let number_ref = &number;
  |                      ------- immutable borrow occurs here
4 |     let number_change = &mut number;
  |                         ^^^^^^^^^^^ mutable borrow occurs here
5 |     *number_change += 10;
6 |     println!("{}", number_ref);
  |                    ---------- immutable borrow later used here
```

However, this code will work. Why?

```rust
fn main() {
    let mut number = 10;
    let number_change = &mut number; // create a mutable reference
    *number_change += 10; // use mutable reference to add 10
    let number_ref = &number; // create an immutable reference
    println!("{}", number_ref); // print the immutable reference
}
```

The compiler knows that we used ```number_change``` to change ```number```, but didn't use it again. So here there is no problem. We are not using immutable and mutable references together.

## Shadowing again

Remember when we said that shadowing doesn't **destroy** a value but **blocks** it? Now we can use references to see this.

```rust
fn main() {
    let country = String::from("Austria");
    let country_ref = &country;
    let country = 8;
    println!("{}, {}", country_ref, country);

}
```

Does this print ```Austria, 8``` or ```8, 8```? It prints ```Austria, 8```. First we declare a ```String``` called ```country```. Then we create a reference ```country_ref``` to this string. Then we shadow country with 8, which is an ```i32```. But the first ```country``` was not destroyed, so ```country_ref``` still says "Austria", not "8".

# Giving references to functions

References are very useful for functions. The rule in Rust on variables is: a variable can only have one owner.

This code will not work:

```rust
fn main() {
    let country = String::from("Austria");
    print_country(country); // We print "Austria"
    print_country(country); // That was fun, let's do it again!
}

fn print_country(country_name: String) {
    println!("{}", country_name);
}
```

It does not work because ```country``` is destroyed. Here's how:

- Step 1: We create the ```String``` ```country```. ```country``` is the owner.
- Step 2: We give ```country``` to ```print_country```. ```print_country``` doesn't have an ```->```, so it doesn't return anything. After ```print_country``` finishes, our ```String``` is now dead.
- Step 3: We try to give ```country``` to ```print_country```, but we already did that. We don't have ```country``` to give anymore.

We can fix this by adding ```&```.

```rust
fn main() {
    let country = String::from("Austria");
    print_country(&country); // We print "Austria"
    print_country(&country); // That was fun, let's do it again!
}

fn print_country(country_name: &String) {
    println!("{}", country_name);
}
```

Now ```print_country()``` is a function that takes a reference to a ```String```: a ```&String```. Also, we give it a reference to country by writing ```&country```. This says "you can look at it, but I will keep it".

Here is an example of a function that uses a mutable variable.

```rust
fn main() {
    let mut country = String::from("Austria");
    add_hungary(&mut country);
}

fn add_hungary(country_name: &mut String) {
    country_name.push_str("-Hungary"); // push_str() adds a &str to a String
    println!("Now it says: {}", country_name);
}
```

So to conclude:

* ```fn function_name(variable: String)``` takes a ```String``` and owns it. If it doesn't return anything, then the variable dies after the function is done.
* ```fn function_name(variable: &String)``` borrows a ```String``` and can look at it
* ```fn function_name(variable: &mut String)``` borrows a ```String``` and can change it

Here is an example that looks like a mutable reference, but it is different.

```rust
fn main() {
    let country = String::from("Austria"); // country is not mutable
    adds_hungary(country);
}

fn adds_hungary(mut country: String) { // but adds_hungary takes the string and it is mutable!
    country.push_str("-Hungary");
    println!("{}", country);
}
```

How is this possible? It is because ```mut hungary``` is not a reference: ```adds_hungary``` owns ```country``` now. (Remember, it takes ```String``` and not ```&String```). ```adds_hungary``` is the full owner, so it can take ```country``` as mutable.


# Copy types

Some types in Rust are very simple. They are called **copy types**. These simple types are all on the stack, and the compiler knows their size. That means that they are very easy to copy, so the compiler always copies when you send it to a function. So you don't need to worry about ownership.

These simple types include: integers, floats, booleans (true and false), and char.

How do you know if a type **implements** copy? (implements = can use) You can check the documentation. For example, here is the documentation for char:

https://doc.rust-lang.org/std/primitive.char.html

On the left you can see **Trait Implementations**. You can see for example **Copy**, **Debug**, and **Display**. So you know that a ```char```:

* is copied when you send it to a function (**Copy**)
* can use ```{}``` to print (**Display**)
* can use ```{:?}``` to print (**Debug**)


```rust
fn main() {
    let my_number = 8;
    prints_number(my_number); // Prints 8. prints_number gets a copy of my_number
    prints_number(my_number); // Prints 8 again.
                              // No problem, because my_number is copy type!
}

prints_number(number: i32) { // No return with ->
                             // If number was not copy type, it would take it
                             // and we couldn't use it again
    println!("{}", number);
}
```

But if you look at the documentation for String, it is not copy type.

https://doc.rust-lang.org/std/string/struct.String.html

On the left in **Trait Implementations** you can look in alphabetical order. A, B, C... there is no **Copy** in C. But there is **Clone**. **Clone** is similar to **Copy**, but needs more memory.

In this example, ```prints_country()``` prints the country name, a ```String```. We want to print it two times, but we can't:

```rust
fn main() {
    let country = String::from("Kiribati");
    prints_country(country);
    prints_country(country);
}

fn prints_country(country_name: String) {
    println!("{}", country_name);
}
```

But now we understand the message.

```
error[E0382]: use of moved value: `country`
 --> src\main.rs:4:20
  |
2 |     let country = String::from("Kiribati");
  |         ------- move occurs because `country` has type `std::string::String`, which does not implement the `Copy` trait
3 |     prints_country(country);
  |                    ------- value moved here
4 |     prints_country(country);
  |                    ^^^^^^^ value used here after move
```

The important part is ```which does not implement the `Copy` trait```. But in the documentation we saw that String implements the Clone trait. So we can add ```.clone()```. This creates a clone, and we send the clone to the function. ```country``` is still alive, so we can use it.

```rust
fn main() {
    let country = String::from("Kiribati");
    prints_country(country.clone()); // make a clone and give it to the function
    prints_country(country);
}

fn prints_country(country_name: String) {
    println!("{}", country_name);
}
```

Of course, if the ```String``` is very large, ```.clone()``` can use a lot of memory. For example, one ```String``` can be a whole book, and every time we call ```.clone()``` it will copy the book. So using ```&``` for a reference is faster, if you can.

```rust
fn main() {
    let mut country = String::from("Kiribati"); // country is mutable
    let country_ref = &country; // country_ref needs a reference
    changes_country(&mut country); // changes_country needs a &mut ref
    println!("{}", country_ref); // immutable and mutable borrow together

}

fn prints_country(country_name: String) {
    println!("{}", country_name);
}

fn changes_country(country_name: &mut String) {
    country_name.push_str(" is a country");
    println!("{}", country_name);
}
```

Maybe we can change the order, but we can also just ```.clone()```.

```rust
fn main() {
    let mut country = String::from("Kiribati"); // country is mutable
    let country_ref = &country; // country_ref needs a reference
    changes_country(&mut country.clone()); // give changes_country a clone instead
    println!("{}", country_ref); // now the code works

}

fn prints_country(country_name: String) {
    println!("{}", country_name);
}

fn changes_country(country_name: &mut String) {
    country_name.push_str(" is a country");
    println!("{}", country_name);
}
```

## Variables without values

A variable without a value is called an "uninitialized" variable. Uninitialized means "hasn't started yet". They are simple, just ```let``` and the name:

```rust
let my_variable;
```

But you can't use it yet. Your program won't compile if it tries to use it.

But sometimes they can be useful. A good example is when:

* You have a code block and inside that is the value for your variable, and
* The variable needs to live outside of the code block.

```rust
fn loop_then_return(mut counter: i32) -> i32 {
    loop {
        counter += 1;
        if counter % 50 == 0 {
            break;
        }
    }
    counter
}

fn main() {
    let my_number;

    {
        // Pretend we need to have this code block
        let number = {
            // Pretend there is code here to make a number
            7
        };

        my_number = loop_then_return(number);
    }

    println!("{}", my_number);
}
```

It is important to know that ```my_number``` was declared in the ```main()``` function, so it lives until the end. But it gets its value from inside a loop. However, that value lives as long as ```my_number```, because ```my_number``` has the value.

It helps to imagine if you simplify the code. ```loop_then_return(number)``` gives the result 50, so let's delete it and write ```50``` instead. Also, now we don't need ```number``` so we will delete it too. Now it looks like this:

```rust
fn main() {
    let my_number;
    {
        my_number = 50;
    }

    println!("{}", my_number);
}
```

So it's almost like saying ```let my_number = { 50 };```.

Also note that ```my_number``` is not ```mut```. We didn't give it a value until we gave it 50, so it never changed its value.


# Collection types

Here are some types for making a collection.

## Arrays

An array is data inside square brackets: ```[]```. Arrays:

* must not change their size,
* must only contain the same type.

They are very fast, however.

The type of an array is: ```[type; number]```. For example, the type of ["One", "Two"] is [&str; 2]. This means that even these two arrays have different types:

```rust
let array1 = ["One", "Two"];
let array2 = ["One", "Two", "Five"];
```

A good tip: to know the type of a variable, you can "ask" the compiler by giving it bad instructions. For example:

```rust
fn main() {
    let seasons = ["Spring", "Summer", "Autumn", "Winter"];
    let seasons2 = ["Spring", "Summer", "Fall", "Autumn", "Winter"];
    let () = seasons; // This will make an error
    let () = seasons2; // This will also make an error
}
```

The compiler says "seasons isn't type () and seasons2 isn't type () either!" as you can see:

```
error[E0308]: mismatched types
 --> src\main.rs:4:9
  |
4 |     let () = seasons;     
  |         ^^   ------- this expression has type `[&str; 4]`
  |         |
  |         expected array `[&str; 4]`, found `()`

error[E0308]: mismatched types
 --> src\main.rs:5:9
  |
5 |     let () = seasons2;
  |         ^^   -------- this expression has type `[&str; 5]`
  |         |
  |         expected array `[&str; 5]`, found `()`
```

If you want an array with all the same value, you can declare it like this:

```rust
fn main() {
    let my_array = ["a"; 20];
    println!("{:?}", my_array);
}
```

This prints ```["a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a"]```.

This method is used a lot to create buffers. For example, ```let mut buffer = [0; 640]``` creates an array of 640 zeroes. Then we can change zero to other numbers in order to add data.

You can index (get) entries in an array with []. The first entry is [0], the second is [1], and so on.

```rust
fn main() { 
    let my_numbers = [0, 10, -20];
    println!("{}", my_numbers[1]); // prints 10
}
```

You can get a slice (a piece) of an array. First you need a &, because the compiler doesn't know the size. Then you can use .. to show the range.

For example, let's use this array: ```[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]```.

```rust
fn main() {
    let array_of_ten = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    let three_to_five = &array_of_ten[2..5];
    let start_at_two = &array_of_ten[1..];
    let end_at_five = &array_of_ten[..5];
    let everything = &array_of_ten[..];

    println!("Three to five: {:?},
start at two: {:?}
end at five: {:?}
everything: {:?}", three_to_five, start_at_two, end_at_five, everything);
}
```

Remember that:
* Index numbers start at 0 (not 1)
* Index ranges are **exclusive** (they do not include the last number)

So ```[0..2]``` means the first index and the second index (0 and 1). Or you can call it the "zeroth and first" index. It doesn't have the third item, which is index 2.

You can also have an **inclusive** range, which means it includes the last number too. To do this, add ```=``` to write ```..=``` instead of ```..```. So instead of ```[0..2]``` you can write ```[0..=2]``` if you want the first, second, and third item.

# Vectors

In the same way that we have &str and String, we have arrays and vectors. Arrays are faster with less functionality, and vectors are slower with more functionality. The type is written ```Vec```.

There are two main ways to declare a vector. One is like with ```String``` using ```new```:

```rust
fn main() {
    let name1 = String::from("Windy");
    let name2 = String::from("Gomesy");
    
    let mut my_vec = Vec::new();
    // If we run the program now, the compiler will give an error.
    // It doesn't know the type of vec.

    my_vec.push(name1); // Now it knows: it's Vec<String>
    my_vec.push(name2);

}
```

Or you can just declare the type.

```rust
fn main() {
    let mut my_vec: Vec<String> = Vec::new(); // The compiler knows the type
                                              // so there is no error.
}
```

You can see that items in vectors must have the same type.

Another easy way to create a vector is with the ```vec!``` macro. It looks like an array declaration, but has ```vec!``` in front of it.

```rust
fn main() {
    let mut my_vec = vec![8, 10, 10];
}
```

The type is ```Vec<i32>```. You call it a "vec of i32s". And a Vec<String> is a "vec of strings". And a Vec<Vec<String>> is a "vec of a vec of strings".

You can slice a vector too, just like in an array.

```
fn main() {
    let vec_of_ten = vec![1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
	// Everything is the same except we added vec!
    let three_to_five = &vec_of_ten[2..5];
    let start_at_two = &vec_of_ten[1..];
    let end_at_five = &vec_of_ten[..5];
    let everything = &vec_of_ten[..];

    println!("Three to five: {:?},
start at two: {:?}
end at five: {:?}
everything: {:?}", three_to_five, start_at_two, end_at_five, everything);
}
```

Because a vec is slower than an array, we can use some methods to make it faster. A vec has a **capacity**, which means the space given to the vector. If you add more to a vector than its capacity, it will make its capacity double and copy the items into the new space. This is called reallocation.

For example:

```rust
fn main() {
    let mut num_vec = Vec::new();
    num_vec.push('a'); // add one character
    println!("{}", num_vec.capacity()); // prints 1
    num_vec.push('a'); // add one more
    println!("{}", num_vec.capacity()); // prints 2
    num_vec.push('a'); // add one more
    println!("{}", num_vec.capacity()); // prints 4. It has three elements, but capacity is 4
    num_vec.push('a'); // add one more
    num_vec.push('a'); // add one more // Now we have 5 elements
    println!("{}", num_vec.capacity()); // Now capacity is 8
}
```

So this vector has three reallocations: 1 to 2, 2 to 4, and 4 to 8. We can make it faster:

```rust
fn main() {
    let mut num_vec = Vec::with_capacity(8); // Give it capacity 8
    num_vec.push('a'); // add one character
    println!("{}", num_vec.capacity()); // prints 8
    num_vec.push('a'); // add one more
    println!("{}", num_vec.capacity()); // prints 8
    num_vec.push('a'); // add one more
    println!("{}", num_vec.capacity()); // prints 8.
    num_vec.push('a'); // add one more
    num_vec.push('a'); // add one more // Now we have 5 elements
    println!("{}", num_vec.capacity()); // Still 8
}
```

This vector has 0 reallocations, which is better. So if you think you know how many elements you need, you can use Vec::with_capacity() to make it faster.

You remember that you can use ```.into()``` to make a ```&str``` into a ```String```. You can also use it to make an array into a ```Vec```. You have to tell ```.into()``` that you want a ```Vec```, but you don't have to choose the type of ```Vec```. If you don't want to choose, you can write ```Vec<_>```.

```rust
fn main() {
    let my_vec: Vec<u8> = [1, 2, 3].into();
    let my_vec2: Vec<_> = [9, 0, 10].into(); // Vec<_> means "choose the Vec type for me"
                                             // Rust will choose Vec<i32>
}
```

# Tuples

Tuples in Rust use ```()```. We have seen many empty tuples already. ```fn do_something() {}``` has an empty tuple. Also, when you don't return anything in a function, you actually return an empty tuple.

```rust
fn main() {
  
}

fn just_prints() {
    println!("I am printing"); // Adding ; means we return an empty tuple
}
```

But tuples can hold many things, and can hold different types too. To access the items inside of a tuple, don't use ```[]```, use ```.```.

```rust
fn main() {
    let mut new_vec = Vec::new();
    new_vec.push('a');
    let random_tuple = ("Here is a name", 8, new_vec, 'b', [8, 9, 10], 7.7);
    println!(
        "Inside the tuple is: First item: {:?} 
Second item: {:?} 
Third item: {:?} 
Fourth item: {:?} 
Fifth item: {:?} 
Sixth item: {:?}",
        random_tuple.0,
        random_tuple.1,
        random_tuple.2,
        random_tuple.3,
        random_tuple.4,
        random_tuple.5,
    )
}
```


You can use a tuple to create multiple variables.

```rust
fn main() {
    let str_vec = vec!["one", "two", "three"];

    let (a, b, c) = (str_vec[0], str_vec[1], str_vec[2]);
    println!("{:?}", b);
}
```

There are many more collection types, and many more ways to use arrays, vecs, and tuples. We will learn more about them. But first we will learn control flow.

# Control flow

Control flow means telling your code what to do in different situations. The simplest control flow is ```if```.

```
fn main() {
    let my_number = 5;
    if my_number == 7 {
        println!("It's seven");
    }
}
```

Please note that we wrote ```if my_number == 7``` and not ```if (my_number == 7)```. You don't need ```()``` with ```if``` in Rust.

```else if``` and ```else``` gives you more control:

```rust
fn main() {
    let my_number = 5;
    if my_number == 7 {
        println!("It's seven");
    } else if my_number == 6 {
        println!("It's six")
    } else {
        println!("It's a different number")
    }
}
```

You can add more conditions with ```&&``` (and) and ```||``` (or).

Too much ```if```, ```else```, and ```else if``` can be difficult to read. You can use ```match``` instead. But you must match for every possible result. For example, this will not work:

```rust
fn main() {
    let my_number: u8 = 5;
    match my_number {
        0 => println!("it's zero"),
        1 => println!("it's one"),
        2 => println!("it's two"),
    }
}
```

The compiler says:

```
error[E0004]: non-exhaustive patterns: `3u8..=std::u8::MAX` not covered
 --> src\main.rs:3:11
  |
3 |     match my_number {
  |           ^^^^^^^^^ pattern `3u8..=std::u8::MAX` not covered
```

This means "you told me about 0 to 2, but u8s can go up to 255. What about 3? What about 4? What about 5?" And so on. So you can add ```_``` which means "anything else".


```rust
fn main() {
    let my_number: u8 = 5;
    match my_number {
        0 => println!("it's zero"),
        1 => println!("it's one"),
        2 => println!("it's two"),
        _ => println!("It's some other number"),
    }
}
```

Remember this for match:

* You write ```match``` and then make a ```{}``` code block.
* Write the pattern on the left and use a ```=>``` fat arrow to say what to do when it matches.
* Each line is called an "arm".
* Put a comma between the arms (not a semicolon).

You can declare a value with a match:

```rust
fn main() {
    let my_number = 5;
    let second_number = match my_number {
        0 => 0,
        5 => 10,
        _ => 2,
    };
}
```

Do you see the semicolon at the end? That is because, after the match is over, we actually told the compiler this: ```let second_number = 10;```

You can match on more complicated things too. You use a tuple to do it.

```rust
fn main() {
    let sky = "cloudy";
    let temperature = "warm";

    match (sky, temperature) {
        ("cloudy", "cold") => println!("It's dark and unpleasant today"),
        ("clear", "warm") => println!("It's a nice day"),
        ("cloudy", "warm") => println!("It's dark but not bad"),
        _ => println!("Not sure what the weather is."),
    }
}
```

You can even put ```if``` inside of ```match```.

```rust
fn main() {
    let children = 5;
    let married = true;

    match (children, married) {
        (children, married) if married == false => println!("Not married with {} children", children),
        (children, married) if children == 0 && married == true => println!("Married but no children"),
        _ => println!("Married? {}. Number of children: {}.", married, children),
    }
}
```

You can use _ as many times as you want in a match. In this match on colours, we have three but only check one at a time.

```rust
fn match_colours(rbg: (i32, i32, i32)) {
    
    match rbg {
        (r, _, _) if r < 10 => println!("Not much red"),
        (_, b, _) if b < 10 => println!("Not much blue"),
        (_, _, g) if g < 10 => println!("Not much green"),
        _ => println!("Each colour has at least 10"),
    }
}

fn main() {
    let first = (200, 0, 0);
    let second = (50, 50, 50);
    let third = (200, 50, 0);

    match_colours(first);
    match_colours(second);
    match_colours(third);    

}
```

This prints:

```
Not much blue
Each colour has at least 10
Not much green
```

This also shows how ```match``` statements work, because in the first example it only printed ```Not much blue```. But ```first``` also has not much green. A ```match``` statement always stops when it finds a match, and doesn't check the rest. This is a good example of code that compiles well but is not the code you want. You can make a really big ```match``` statement to fix it, but it is probably better to use a ```for``` loop. We will talk about loops soon.

A match has to return the same type. So you can't do this:

```rust
fn main() {
    let my_number = 10;
    let some_variable = match my_number {
        10 => 8,
        _ => "Not ten",
    };
}
```

The compiler tells you that:

```
error[E0308]: `match` arms have incompatible types
  --> src\main.rs:17:14
   |
15 |       let some_variable = match my_number {
   |  _________________________-
16 | |         10 => 8,
   | |               - this is found to be of type `{integer}`
17 | |         _ => "Not ten",
   | |              ^^^^^^^^^ expected integer, found `&str`
18 | |     };
   | |_____- `match` arms have incompatible types
```

This will also not work, for the same reason:

```rust
let some_variable = if my_number == 10 { 8 } else { "something else "};
```

But this works, because you have a different ```let``` statement.

```rust
fn main() {
    let my_number = 10;

    if my_number == 10 {
        let some_variable = 8;
    } else {
        let some_variable = "Something else";
    }
}
```

You can also use ```@``` to use the value of a ```match``` expression when you want to. In this example we match an ```i32``` input in a function. If it's 4 or 13 we want to use that number in a ```println!``` statement. Otherwise, we don't need to use it.

```rust
fn match_number(input: i32) {
    match input {
    number @ 4 => println!("{} is an unlucky number in China (sounds close to 死)!", number),
    number @ 13 => println!("{} is unlucky in North America, lucky in Italy! In bocca al lupo!", number),
    _ => println!("Looks like a normal number"),
    }
}

fn main() {
    match_number(50);
    match_number(13);
    match_number(4);
}
```

And when you use ```@```, you have to use the value. It will give an error if you don't:

```
error: 1 positional argument in format string, but no arguments were given
 --> src\main.rs:4:30
  |
4 |     number @ 13 => println!("{} is unlucky in North America, lucky in Italy! In bocca al lupo!"),
```

# Structs

With structs, you can create your own type. Structs are created with the keyword ```struct```. The name of a struct should be in UpperCamelCase (capital letter for each word, no spaces).

There are three types of structs. One is a "unit struct". Unit means "doesn't have anything".

```rust
struct FileDirectory;
```

The next is a ```tuple struct```, or an ```unnamed struct```. It is "unnamed" because you only need to write the types, not the variable names. Tuple structs are good when you need a simple struct and don't need to remember names.

```rust
struct Colour(u8, u8, u8);

fn main() {
    let my_colour = Colour(50, 0, 50); // Make a colour out of RGB (red, green, blue)
    println!("The second part of the colour is: {}", my_colour.1);
}
```

The third type is the named struct. This is probably the most common struct. In this struct you declare variable names and types inside a ```{}```code block.

```rust
struct Colour(u8, u8, u8); // Declare the same Colour tuple struct

struct SizeAndColour {
    size: u32,
    colour: Colour, // And we put it in our new named struct
}

fn main() {
    let my_colour = Colour(50, 0, 50);
    
    let size_and_colour = SizeAndColour {
        size: 150,
        colour: my_colour
    };
}
```

Let's create a ```Country``` struct to give an example. The ```Country``` struct has the fields ```population```, ```capital```, and ```leader_name```.

```rust
struct Country {
    population: u32,
    capital: String,
    leader_name: String
}

fn main() {
    let population = 500_000;
    let capital = String::from("Elist");
    let leader_name = String::from("Batu Khasikov");

    let kalmykia = Country {
        population: population,
        capital: capital,
        leader_name: leader_name,
    };

}
```

Did you notice that we wrote the same thing twice? Actually, you don't need to do that. If the field name and variable name are the same, you don't have to write it twice.

```rust
struct Country {
    population: u32,
    capital: String,
    leader_name: String
}

fn main() {
    let population = 500_000;
    let capital = String::from("Elist");
    let leader_name = String::from("Batu Khasikov");

    let kalmykia = Country {
        population,
        capital,
        leader_name,
    };

}
```

# Enums

An ```enum``` is short for enumerations. They look similar to a struct, but are different. Here is the difference:

* Use a struct when you want one thing AND another thing.
* Use an enum when you want one thing OR another thing.

So structs are for **many things** together, while enums are for **many choices** together.

To declare an enum, write ```enum``` and use a code block with the options, separated by commas. We will create an enum called ```SkyState```:

```rust
enum ThingsInTheSky {
    Sun,
    Stars,
}
```

This is an enum because you can either see the sun, **or** the stars: you have to choose one. These are called **variants**.

```rust
// create the enum with two choices
enum ThingsInTheSky {
    Sun,
    Stars,
}

// With this function we can use an i32 to create ThingsInTheSky.
fn create_skystate(time: i32) -> ThingsInTheSky {
    match time {
        6..=18 => ThingsInTheSky::Sun, // Between 6 and 18 hours we can see the sun
        _ => ThingsInTheSky::Stars, // Otherwise, we can see stars
    }
}

// With this function we can match against the two choices in ThingsInTheSky.
fn check_skystate(state: &ThingsInTheSky) {
    match state {
        ThingsInTheSky::Sun => println!("I can see the sun!"),
        ThingsInTheSky::Stars => println!("I can see the stars!")
    }
}

fn main() {
    
    let time = 8; // it's 8 o'clock
    let skystate = create_skystate(time); // create_skystate returns a ThingsInTheSky
    check_skystate(&skystate); // Give it a reference so it can read the varible skystate

}
```

You can add data to an enum too.

```rust
enum ThingsInTheSky {
    Sun(String), // Now each variant has a string
    Stars(String),
}

fn create_skystate(time: i32) -> ThingsInTheSky {
    match time {
        6..=18 => ThingsInTheSky::Sun(String::from("I can see the sun!")), // Write the strings here
        _ => ThingsInTheSky::Stars(String::from("I can see the stars!")),
    }
}

fn check_skystate(state: &ThingsInTheSky) {
    match state {
        ThingsInTheSky::Sun(description) => println!("{}", description), // Give the string the name description so we can use it
        ThingsInTheSky::Stars(n) => println!("{}", n), // Or you can name it n. Or anything else - it doesn't matter
    }
}

fn main() {
    
    let time = 8; // it's 8 o'clock
    let skystate = create_skystate(time); // create_skystate returns a ThingsInTheSky
    check_skystate(&skystate); // Give it a reference so it can read the varible skystate

}
```

## Enums to use multiple types

You know that items in a Vec, array, etc. all need the same type (only tuples are different). But you can actually use an enum to put different types in. Imagine we want to have a Vec with ```u32```s or ```i32```s. Of course, you can make a Vec<(u32, i32)> (a vec with ```(u32, i32)``` tuples) but we only want one. So here you can use an enum. Here is a simple example:

```rust
enum Number {
    U32(u32),
    I32(i32),
}
```

So there are two variants: the ```U32``` variant with a ```u32``` inside, and the ```I32``` variant with ```i32``` inside. ```U32``` and ```I32``` are just names we made. They could have been ```UThirtyTwo``` or ```IThirtyTwo``` or anything else.

Now, if we put them into a Vec we just have a ```Vec<Number>```, and the compiler is happy. Because it's an enum, you have to pick one. We will use the ```.is_positive()``` method to pick. If it's ```true``` then we will choose ```U32```, and if it's ```false``` then we will choose ```I32```.

Now the code looks like this:

```rust
#[derive(Debug)] // So we can print it
enum Number {
    U32(u32),
    I32(i32),
}

impl Number {
    fn new(number: i32) -> Number { // input number is i32
        match number.is_positive() {
            true => Number::U32(number as u32), // change it to u32 if it's positive
            false => Number::I32(number), // otherwise just give the number because it's already i32
        }
    }
    
}

fn main() {
    let my_vec = vec![Number::new(-800), Number::new(8)];

    for item in my_vec {
        println!("{:?}", item);
    }

}
```

This prints what we wanted to see:

```
I32(-800)
U32(8)
```

# References and the dot operator

We learned that when you have a reference, you need to use ```*``` to get to the value. A reference is a different type, so this won't work:

```rust
fn main() {
    let my_number = 9;
    let reference = &my_number;

    println!("{}", my_number == reference);

}
```

The compiler prints:

```rust
error[E0277]: can't compare `{integer}` with `&{integer}`
 --> src\main.rs:5:30
  |
5 |     println!("{}", my_number == reference);
  |                              ^^ no implementation for `{integer} == &{integer}`
```

So we change line 5 to ```println!("{}", my_number == *reference);``` and now it prints ```true```. This is called dereferencing.

But when you use a method, Rust will dereference for you. The ```.``` in a function is called the dot operator.

First, let's make a struct with one ```u8``` field. Then we will make a reference to it and try to compare. It will not work:

```rust
struct Item {
    number: u8,
}

fn main() {
    let item = Item {
        number: 8,
    };

    let reference_number = &item.number; // reference number type is &u8

    println!("{}", reference_number == 8); // &u8 and u8 cannot be compared
}
```

To make it work, we need to dereference: ```println!("{}", *reference_number == 8);```.

But with the dot operator, we don't need ```*```. For example:

```rust
struct Item {
    number: u8,
}

fn main() {
    let item = Item {
        number: 8,
    };

    let reference_item = &item;

    println!("{}", reference_item.number == 8); // we don't need to write *reference_item.number
}
```

Now let's create a method for ```Item``` that compares ```number``` to another number. We don't need to use ```*``` anywhere:

```rust
struct Item {
    number: u8,
}

impl Item {
    fn compare_number(&self, other_number: u8) { // takes a reference to self
        println!("Are {} and {} equal? {}", self.number, other_number, self.number == other_number); 
            // We don't need to write *self.number
    }
}

fn main() {
    let item = Item {
        number: 8,
    };

    let reference_item = &item; // This is type &Item
    let reference_item_two = &reference_item; // This is type &&Item

    item.compare_number(8); // the method works
    reference_item.compare_number(8); // it works here too
    reference_item_two.compare_number(8); // and here

}
```

So just remember: when you use the ```.``` operator, you don't need to worry about ```*```.


# Destructuring
You can get the values from a struct or enum by using ```let``` backwards. This is called ```destructuring```, and gives you the values separately. First a simple example:

```rust
struct Person { // make a simple struct for a person
    name: String,
    real_name: String,
    height: u8,
    happiness: bool
}

fn main() {
    let papa_doc = Person { // create variable papa_doc
        name: "Papa Doc".to_string(),
        real_name: "Clarence".to_string(),
        height: 170,
        happiness: false
    };

    let Person { // destructure papa_doc
        name: a,
        real_name: b,
        height: c,
        happiness: d
    } = papa_doc;

    println!("Our four values are: {}, {}, {}, and {}.", d, c, b, a);

}
```

You can see that it's backwards. First we say let ```papa_doc = Person { fields }``` to create the struct. Then we say ```let Person {fields} = papa_doc``` to destructure it.

You don't have to write ```name: a``` - you can just write ```name```. But here we write ```name = a``` because we want to use the variable name ```a```.

Now a bigger example. In this example we have a ```City``` struct. We give it a ```new``` function to make it. Then we have a ```process_city_values``` function to do things with the values. In the function we just create a ```Vec```, but you can imagine that we can do much more after we destructure it.

```rust
struct City {
    name: String,
    name_before: String,
    population: u32,
    date_founded: u32,
}

impl City {
    fn new(name: String, name_before: String, population: u32, date_founded: u32) -> Self {
        Self {
            name,
            name_before,
            population,
            date_founded,
        }
    }
}

fn main() {
    let tallinn = City::new("Tallinn".to_string(), "Reval".to_string(), 426_538, 1219);
    process_city_values(&tallinn);
}

fn process_city_values(city: &City) {
    let City {
        name,
        name_before,
        population,
        date_founded,
    } = city;
        // now we have the values to use separately
    let two_names = vec![name, name_before];
    println!("{:?}", two_names);
}
```

# Loops

With loops you can tell Rust to continue something until you want it to stop. With ```loop``` you can start a loop that does not stop, unless you tell it when to ```break```.

```rust
fn main() { // This program will never stop
    loop {
 	       
    }
}
```

So let's tell the compiler when it can break.

```rust
fn main() {
    let mut counter = 0; // set a counter to 0
    loop {
        counter +=1; // increase the counter by 1
        println!("The counter is now: {}", counter);
        if counter == 5 { // stop when counter == 5
            break;
        }
    }
}
```

This will print:

```
The counter is now: 1
The counter is now: 2
The counter is now: 3
The counter is now: 4
The counter is now: 5
```

If you have a loop inside of a loop, you can give them names. With names, you can tell Rust which loop to ```break``` out of. Use ```'``` (called a "tick") and a ```:``` to give it a name:

```rust
fn main() {
    let mut counter = 0;
    let mut counter2 = 0;
    println!("Now entering the first loop.");

    'first_loop: loop { // Give the first loop a name
        counter +=1;
        println!("The counter is now: {}", counter);
        if counter > 9 { // Starts a second loop inside this loop
            println!("Now entering the second loop.");

            'second_loop: loop { // now we are inside `second_loop
                println!("The second counter is now: {}", counter2);
                counter2 +=1;
                if counter2 == 3 {
                    break 'first_loop; // Break out of `first_loop so we can exit the program
                }
            }
        }
    }
}
```

A ```while``` loop is a loop that continues while something is still ```true```. Each loop, Rust will check if it is still ```true```. If it becomes ```false```, Rust will stop the loop.

```rust
fn main() {
    let mut counter = 0;

    while counter < 5 {
        counter +=1;
        println!("The counter is now: {}", counter);
    }
}
```

A ```for``` loop lets you tell Rust what to do each time. But in a ```for``` loop, the loop stops after a certain number of times. ```for``` loops use **ranges** very often. You use ```..``` and ```..=``` to create a range.

* ```..``` creates an **exclusive** range: ```0..3``` creates ```0, 1, 2```.
* ```..=``` creates an **inclusive** range: ```0..=3``` = ```0, 1, 2, 3```.

```rust
fn main() {
    for number in 0..3 {
        println!("The number is: {}", number);
    }

    for number in 0..=3 {
        println!("The next number is: {}", number);
    }
}
```

Also notice that ```number``` becomes the variable name for 0..3. We can then use that name in ```println!```.

If you don't need a variable name, use ```_```.

```rust
fn main() {
    for _ in 0..3 {
        println!("Printing the same thing three times");
    }
}
```

Actually, if you give a variable name and don't use it, Rust will tell you:

```rust
fn main() {
    for number in 0..3 {
        println!("Printing the same thing three times");
    }
}
```

This is not an error, but Rust will remind you that you didn't use ```number```:

```rust
warning: unused variable: `number`
 --> src\main.rs:2:9
  |
2 |     for number in 0..3 {
  |         ^^^^^^ help: if this is intentional, prefix it with an underscore: `_number`
```

Rust also suggests ```_number```. Putting ```_``` in front of a variable name means "maybe I will use it later". But using just ```_``` means "I don't care about this variable at all".

You can also use ```break``` to return a value. You write the value right after ```break``` and use a ```;```. Here is an example with a ```loop``` and a break that gives ```my_number``` its value.

```rust
fn main() {
    let mut counter = 5;
    let my_number = loop {
        counter +=1;
        if counter % 53 == 3 {
            break counter;
        }
    };
    println!("{}", my_number);
}
```

```break counter;``` means "break with the value of counter". And because the whole bloock starts with ```let```, ```my_number``` gets the value.

Now that we know how to use loops, here is a better solution to the ```match``` problem with colours. It is a better solution because we want to compare everything, and a ```for``` loop looks at every item.

```rust
fn match_colours(rbg: (i32, i32, i32)) {
    
    let new_vec = vec![(rbg.0, "red"), (rbg.1, "blue"), (rbg.2, "green")]; // Put the colours in a vec. Inside are tuples with the colour names
    let mut all_have_at_least_10 = true; // Start with true. We will set it to false if one colour is less than 10
    for item in new_vec {
        if item.0 < 10 {
            all_have_at_least_10 = false; // Now it's false
            println!("Not much {}.", item.1) // And we print the colour name.
        }
    }
    if all_have_at_least_10 { // Check if it's still true, and print if true
        println!("Each colour has at least 10.")
    }

}

fn main() {
    let first = (200, 0, 0);
    let second = (50, 50, 50);
    let third = (200, 50, 0);

    match_colours(first);
    match_colours(second);
    match_colours(third);    

}
```

# Implementing structs and enums

To call functions on a ```struct``` or an ```enum```, use an ```impl``` block. These functions are called **methods**. There are two kinds of methods in an ```impl``` block.

* Regular methods: these take **self** (or **&self** or **&mut self**). Regular methods use a ```.```. ```.clone()``` is a regular method.
* Associated methods (or "static" methods): these do not take self. They are written differently, using ```::```. ```String::from()``` is an associated method. You usually use associated methods to create new variables.

In our example we are going to create animals and print them. For a new struct or enum, you need to give it **Debug** if you want to use ```{:?}``` to print. If you write ```#[derive(Debug)]``` above the struct or enum then you can print it with ```{:?}```.

```rust
#[derive(Debug)]
struct Animal {
    age: u8,
    animal_type: AnimalType,
}

impl Animal {
    fn new() -> Self {
        // Self means AnimalType.
        //You can also write AnimalType instead of Self

        Self {
            // When we write Animal::new(), we always get a cat that is 10 years old
            age: 10,
            animal_type: AnimalType::Cat,
        }
    }

    fn change_to_dog(&mut self) {
        // use .change_to_dog() to change the cat to a dog
        // with &mut self we can change it
        println!("Changing animal to dog!");
        self.animal_type = AnimalType::Dog;
    }

    fn change_to_cat(&mut self) {
        // use .change_to_dog() to change the cat to a dog
        // with &mut self we can change it
        println!("Changing animal to cat!");
        self.animal_type = AnimalType::Cat;
    }

    fn check_type(&self) {
        // we want to read self
        match self.animal_type {
            AnimalType::Dog => println!("The animal is a dog"),
            AnimalType::Cat => println!("The animal is a cat"),
        }
    }
}

#[derive(Debug)]
enum AnimalType {
    Cat,
    Dog,
}

fn main() {
    let mut new_animal = Animal::new(); // Associated method to create a new animal
                                        // It is a cat, 10 years old
    new_animal.check_type();
    new_animal.change_to_dog();
    new_animal.check_type();
    new_animal.change_to_cat();
    new_animal.check_type();
}
```

This prints:

```
The animal is a cat
Changing animal to dog!
The animal is a dog
Changing animal to cat!
The animal is a cat
```

## Self

Remember that Self (the type Self) and self (the variable self) are abbreviations. (abbreviation = short way to write) 

So in our code, Self = AnimalType. Also, ```fn change_to_dog(&mut self)``` means ```fn change_to_dog(&mut AnimalType)```

# Generics

In functions, you write what type to take as input:

```rust
fn return_number(number: i32) -> i32 {
    println!("Here is your number.");
    number
}

fn main() {
    let number = return_number(5);
}
```

But maybe you also want to input an ```i8```, or a ```u32```, and so on. You can use generics for this. Generics means "maybe one type, maybe another type".

For generics, you use angle brackets with the type inside: ```<T>``` This means "any type you put into the function". Usually, generics uses types with one capital letter (T, U, V, etc.).

This is how you change the function:

```rust
fn return_number<T>(number: T) -> T {
    println!("Here is your number.");
    number
}
```

The important part is the ```<T>``` after the function name. Without this, Rust will think that T is a concrete (concrete = not generic) type, like ```String``` or ```i8```.

This is easier to understand if we write out a type name:

```rust
fn return_number(number: MyType) -> MyType {
    println!("Here is your number.");
    number
}
```

As you can see, MyType is concrete, not generic. So we need to write this:

```rust
fn return_number<MyType>(number: MyType) -> MyType {
    println!("Here is your number.");
    number
}
```

So now it works:

```rust
fn return_number<MyType>(number: MyType) -> MyType {
    println!("Here is your number.");
    number
}

fn main() {
    let number = return_number(5);
}
```

Now we will go back to type ```T```, because Rust code usually uses ```T```.

You will remember that some types in Rust are **Copy**, some are **Clone**, some are **Display**, some are **Debug**, and so on. With **Debug**, we can print with ```{}```. So now you can see that this is a problem:

```rust
fn print_number<T>(number: T) {
    println!("Here is your number: {:?}", number);
}

fn main() {
    print_number(5);
}
```

```print_number``` needs **Debug** to print ```number```, but is ```T``` a type with ```Debug```? Maybe not. The compiler doesn't know, so it gives an error:

```
error[E0277]: `T` doesn't implement `std::fmt::Debug`
  --> src\main.rs:29:43
   |
29 |     println!("Here is your number: {:?}", number);
   |                                           ^^^^^^ `T` cannot be formatted using `{:?}` because it doesn't implement `std::fmt::Debug`
```

T doesn't implement **Debug**. So do we implement Debug for T? No, because we don't know what T is. But we can tell the function: "only accept types that have Debug".

```rust
use std::fmt::Debug; // Debug is located at std::fmt::Debug. If we write this,
                     // then now we can just write 'Debug'.

fn print_number<T: Debug>(number: T) {
    println!("Here is your number: {:?}", number);
}

fn main() {
    print_number(5);
}
```

So now the compiler knows: "Okay, I will only take a type if it has Debug". Now the code works, because i32 is Debug. Now we can give it many types: String, &str, and so on.

Now we can create a struct and give it Debug, and now we can print it too. Our function can take i32, the struct Animal, and more:

```rust
use std::fmt::Debug;

#[derive(Debug)]
struct Animal {
    name: String,
    age: u8,
}

fn print_item<T: Debug>(item: T) {
    println!("Here is your item: {:?}", item);
}

fn main() {
    let charlie = Animal {
        name: "Charlie".to_string(),
        age: 1,
    };
    
    let number = 55;

    print_item(charlie);
    print_item(number);
}
```

This prints:

```
Here is your item: Animal { name: "Charlie", age: 1 }
Here is your item: 55
```

Sometimes we need more than one type in a generic function. We have to write out each type name, and think about how we want to use it. In this example, we want two types. First we want to print a statement for type T. Printing with ```{}``` is nicer, so we will require Display for T. 

Next is type U, and two variables have type U (U is some sort of number). We want to compare them, so we need PartialOrd. We want to print them too, so we require Display for U as well.

```rust
use std::fmt::Display;
use std::cmp::PartialOrd;

fn compare_and_display<T: Display, U: Display + PartialOrd>(statement: T, num_1: U, num_2: U) {
    println!("{}! Is {} greater than {}? {}", statement, num_1, num_2, num_1 > num_2);
}

fn main() {
    compare_and_display("Listen up!", 9, 8);
}
```

So ```fn compare_and_display<T: Display, U: Display + PartialOrd>(statement: T, num_1: U, num_2: U)``` says:

* The function name is compare_and_display,
* The first type is T, and it is generic. It must be a type that can print with {}.
* The next type is U, and it is generic. It must be a type that can print with {}. Also, it must be a type that can compare (use ```>```, ```<```, and ```==```).

Now we can give ```compare_and_display``` different types. ```statement``` can be a String, a &str, anything with Display.

To make generic functions easier to read, we can also write it like this:

```rust
use std::cmp::PartialOrd;
use std::fmt::Display;

fn compare_and_display<T, U>(statement: T, num_1: U, num_2: U)
where
    T: Display,
    U: Display + PartialOrd,
{
    println!("{}! Is {} greater than {}? {}", statement, num_1, num_2, num_1 > num_2);
}

fn main() {
    compare_and_display("Listen up!", 9, 8);
}

```

Using ```where``` is a good idea when you have many generic types.

Also note:

* If you have one type T and another type T, they must be the same.
* If you have one type T and another type U, they can be different. But they can also be the same.

For example:

```rust
use std::fmt::Display;

fn say_two<T: Display, U: Display>(statement_1: T, statement_2: U) { // Type T needs Display, type U needs Display
    println!("I have two things to say: {} and {}", statement_1, statement_2);
}

fn main() {

    say_two("Hello there!", String::from("I hate sand.")); // Type T is a &str. Type U is a String.
    say_two(String::from("Where is Padme?"), String::from("Is she all right?")); // Both types are String.
}
```

# Option and Result

We understand enums and generics now, so we can understand ```Option``` and ```Result```. Rust uses these two enums to make code safer. We will start with Option.

You use Option when you have a value that might exist, or might not exist. Here is an example of bad code that can be improved with Option.

```rust
fn main() {
    let new_vec = vec![1, 2];
    let index = take_fifth(new_vec);
}

fn take_fifth(value: Vec<i32>) -> i32 {
    value[4]
}
```

When we run the code, it panics. Here is the message:

```
thread 'main' panicked at 'index out of bounds: the len is 2 but the index is 4', src\main.rs:34:5
```

Panic means that the program stops before the problem happens. Rust sees that the function wants something impossible, and stops. It "unwinds the stack" (takes the values off the stack) and tells you "sorry, I can't do that".

So now we will change the return type from ```i32``` to ```Option<i32>```. This means "give me an i32 if it's there, and give me ```None``` if it's not". We say that the i32 is "wrapped" in an Option, which means that it's inside an Option.

```rust
fn main() {
    let new_vec = vec![1, 2];
    let bigger_vec = vec![1, 2, 3, 4, 5];
    println!("{:?}, {:?}", take_fifth(new_vec), take_fifth(bigger_vec)
    );
}

fn take_fifth(value: Vec<i32>) -> Option<i32> {
    if value.len() < 5 { // .len() gives the length of the vec.
                         // It must be at least 5.
        None
    } else {
        Some(value[4])
    }
}
```

This prints ```None, Some(5)```. This is good, because now we don't panic anymore. But how do we get the value 5?

We can get the value inside an option with ```.unwrap()```, but be careful with ```.unwrap()```. If you unwrap a value that is ```None```, the program will panic.

```rust
fn main() {
    let new_vec = vec![1, 2];
    let bigger_vec = vec![1, 2, 3, 4, 5];
    println!( // with .unwrap() the code is getting longer
              // so we will write on more than one line.
        "{:?}, {:?}",
        take_fifth(new_vec).unwrap(), // this one is None. .unwrap() will panic!
        take_fifth(bigger_vec).unwrap()
    );
}

fn take_fifth(value: Vec<i32>) -> Option<i32> {
    if value.len() < 4 {
        None
    } else {
        Some(value[4])
    }
}
```

But we don't need to use ```.unwrap()```. We can use a ```match```, and print when we have ```Some```, and not print if we have ```None```. For example:

```rust
fn main() {
    let new_vec = vec![1, 2];
    let bigger_vec = vec![1, 2, 3, 4, 5];
    let mut option_vec = Vec::new(); // Make a new vec to hold our options
                                     // The vec is type: Vec<Option<i32>>. That means a vec of Option<i32>.

    option_vec.push(take_fifth(new_vec)); // This pushes "None" into the vec
    option_vec.push(take_fifth(bigger_vec)); // This pushes "Some(5)" into the vec

    handle_option(option_vec); // handle_option looks at every option in the vec.
                               // It prints the value if it is Some. It doesn't print if it is None.
}

fn take_fifth(value: Vec<i32>) -> Option<i32> {
    if value.len() < 4 {
        None
    } else {
        Some(value[4])
    }
}

fn handle_option(my_option: Vec<Option<i32>>) { 
  for item in my_option {
    match item {
      Some(number) => println!("{}", number),
      None => {}, // do nothing
    }
  }
}
```

Because we know generics, we can understand Option. It looks like this:

```rust
enum Option<T> {
    None,
    Some(T),
}
```

The important point to remember: with ```Some```, you have a value of type ```T``` (any type). But with ```None```, you don't have anything. So in a ```match``` statement for Option you can't say:

```rust
Some(value) => println!("The value is {}", value), 
None(value) => println!("The value is {}", value), 
```

because ```None``` is just ```None```.

Of course, there are easier ways to use Option. In this easier way, we don't need ```handle_option()``` anymore. We also don't need a vec for the Options.

```rust
fn main() {
    let new_vec = vec![1, 2];
    let bigger_vec = vec![1, 2, 3, 4, 5];
    let vec_of_vecs = vec![new_vec, bigger_vec];
    for vec in vec_of_vecs {
        let inside_number = take_fifth(vec);
        if inside_number.is_some() { // .is_some() returns true if we get Some, false if we get None
            println!("{}", inside_number.unwrap()); // now it is safe to use .unwrap() because we already checked
                                                    // println! does not happen if we have a None
        }
    }
}

fn take_fifth(value: Vec<i32>) -> Option<i32> {
    if value.len() < 4 {
        None
    } else {
        Some(value[4])
    }
}
```

## Result 

Result is similar to Option, but here is the difference:

* Option is about Some or None (value or no value),
* Result is about Ok or Err (okay result, or error result).

To compare, here are the signatures for Option and Result.

```rust
enum Option<T> {
    None,
    Some(T),
}

enum Result<T, E> {
    Ok(T),
    Err(E),
}
```

So Result has a value inside of Ok, and a value inside of Err. That is because errors usually have information inside them.

```Result<T, E>``` means you need to think of what you want to return for Ok, and what you want to return for Err. Actually, you can decide anything. Even this is okay:

```rust
fn main() {
    check_error();
}

fn check_error() -> Result<(), ()> {
    Ok(()) 
}
```

```check_error``` says "return () if we get Ok, and return () if we get Err". Then we return Ok with a ().

Sometimes a function with Result will use a ```String``` for the Err value. This is not the best method to use, but sometimes it is okay.

```rust
fn main() {
    let mut result_vec = Vec::new(); // Create a new vec for the results

    for number in 2..7 {
        result_vec.push(check_if_five(number)); // push each result into the vec
    }

    println!("{:?}", result_vec);
}

fn check_if_five(number: i32) -> Result<i32, String> {
    match number {
        5 => Ok(number),
        _ => Err("Sorry, the number wasn't five.".to_string()), // This is our error message
    }
}
```

Our vec prints:

```
[Err("Sorry, the number wasn\'t five."), Err("Sorry, the number wasn\'t five."), Err("Sorry, the number wasn\'t five."), Ok(5), 
Err("Sorry, the number wasn\'t five.")]
```

Just like Option, .unwrap() on Err will panic.

```rust
fn main() {
    let error_value: Result<i32, &str> = Err("There was an error"); // Create a Result that is already an Err
    println!("{}", error_value.unwrap()); // Unwrap it
}
```

The program panics, and prints:

```
thread 'main' panicked at 'called `Result::unwrap()` on an `Err` value: "There was an error"', src\main.rs:30:20
```

This information helps you fix your code. src\main.rs:30:20 means "inside main.rs in directory src, on line 30 and column 20". So you can go there to look at your code and fix the problem.

You can also create your own error types. Result functions in the standard library usually have their own error types. For example:

```
pub fn from_utf8(vec: Vec<u8>) -> Result<String, FromUtf8Error>
```

This function take a vector of bytes (u8) and tries to make a ```String```. So the success case for the Result is a ```String``` and the error case is ```FromUtf8Error```. You can give your error type any name you want. We will create our own error types later, because first we need to learn other things.

Using a ```match``` with Option and Result sometimes requires a lot of code. For example, the ```.get()``` method returns an Option on a Vec.

```rust
fn main() {
    let my_vec = vec![2, 3, 4];
    let get_one = my_vec.get(0); // 0 to get the first number
    let get_two = my_vec.get(10); // Returns None
    println!("{:?}", get_one);
    println!("{:?}", get_two);
}
```

This prints 
```
Some(2)
None
```

So now we can match to get the values. Let's use a range from 0 to 10 to see if it matches the numbers in ```my_vec```.

```rust
fn main() {
    let my_vec = vec![2, 3, 4];

    for index in 0..10 {
      match my_vec.get(index) {
        Some(number) => println!("The number is: {}", number),
        None => {}
      }
    }
    
}
```

This is good, but we don't do anything for ```None```. Here we can make the code smaller by using ```if let```. ```if let``` means "do something if it matches, and don't do anything if it doesn't". ```if let``` is when you don't care about matching for everything.

```rust
fn main() {
    let my_vec = vec![2, 3, 4];

    for index in 0..10 {
      if let Some(number) = my_vec.get(index) {
        println!("The number is: {}", number);
      }
    }   
}
```

```if let Some(number) = my_vec.get(index)``` means "if you get Some(number) from my_vec.get(index)". Also note: it uses one ```=```. It is not a boolean.

```while let``` is like a while loop for ```if let```. Imagine that we have weather station data like this:

```
["Berlin", "cloudy", "5", "-7", "78"]
["Athens", "sunny", "not humid", "20", "10", "50"]
```

We want to get the numbers, but not the words. For the numbers, we can use a method called ```parse::<i32>()```. ```parse()``` is the method, and ```::<i32>``` is the type. It will try to turn the &str into an ```i32```, and give it to us if it can.

We will also use ```.pop()```. This takes the last item off of the vector.

```rust
fn main() {
    let mut weather_vec = vec!["Berlin", "cloudy", "5", "-7", "78"];
    while let Some(information) = weather_vec.pop() { // This means: keep going until you can't pop anymore
                                                      // When the vector reaches 0 items, it will return None
                                                      // and it will stop.
        if let Ok(number) = information.parse::<i32>() { // Try to parse the variable we called information
                                                         // This returns a result. If it's Ok(number), it will print it
            println!("The number is: {}", number);
        }
    }
}
```

# The ? operator

There is an even shorter way to deal with Result (and Option), shorter than ```match``` and even shorter than ```if let```. It is called the "question mark operator", and is just ```?```. After a function that returns a result, you can add ```?```. This will:

* return the result if it is Ok
* pass the error back if it is Err

In other words, it does almost everything for you.

We can try this with ```.parse()``` again. We will write a function called ```parse_str``` that tries to turn a ```&str``` into a ```i32```. It looks like this:

```rust
fn parse_str(input: &str) -> Result<i32, std::num::ParseIntError> {
    let parsed_number = input.parse::<i32>()?; // Here is the question mark
    Ok(parsed_number)
}
```

This function takes a ```&str```. If it is Ok, it gives an ```i32``` wrapped in ```Ok```. If it is an Err, it returns a std::num::ParseIntError. Then we try to parse the number, and add ```?```. That means "check if it is an error, and give the result if it is okay". If it is not okay, it will return the error and end. But if it is okay, it will go to the next line. On the next line is the number inside of ```Ok()```. We need to wrap it in Ok because the return is ```Result<i32, std::num::ParseIntError>```, not ```i32```.

Now, we can try out our function. Let's see what it does with a vec of ```&str```s.

```rust
fn main() {
    let str_vec = vec!["Seven", "8", "9.0", "nice", "6060"];
    for item in str_vec {
        let parsed = parse_str(item);
        println!("{:?}", parsed);
    }
}

fn parse_str(input: &str) -> Result<i32, std::num::ParseIntError> {
    let parsed_number = input.parse::<i32>()?;
    Ok(parsed_number)
}
```

This prints:

```
Err(ParseIntError { kind: InvalidDigit })
Ok(8)
Err(ParseIntError { kind: InvalidDigit })
Err(ParseIntError { kind: InvalidDigit })
Ok(6060)
```

How did we find std::num::ParseIntError? One easy way is to "ask" the compiler again. 

```rust
fn main() {
    let failure = "Not a number".parse::<i32>();
    failure.rbrbrb(); // Compiler: "What is rbrbrb()???"
}
```

The compiler doesn't understand, and says:

```
error[E0599]: no method named `rbrbrb` found for enum `std::result::Result<i32, std::num::ParseIntError>` in the current scope
 --> src\main.rs:3:13
  |
3 |     failure.rbrbrb();
  |             ^^^^^^ method not found in `std::result::Result<i32, std::num::ParseIntError>`
```

So ```std::result::Result<i32, std::num::ParseIntError>``` is the signature we need.

We don't need to write ```std::result::Result``` because ```Result``` is always "in scope" (in scope = ready to use). But std::num::ParseIntError is not in scope. We can bring it in scope if we want:

```use std::num::ParseIntError;```

Then we can write:

```rust

use std::num::ParseIntError;

fn parse_str(input: &str) -> Result<i32, ParseIntError> {
    let parsed_number = input.parse::<i32>()?;
    Ok(parsed_number)
}
```

## When panic and unwrap are good

Rust has a ```panic!``` macro that you can use to make it panic. It is easy to use:

```rust
fn main() {
    panic!("Time to panic!");
}
```

The message ```"Time to panic!"``` displays when you run the program: ```thread 'main' panicked at 'Time to panic!', src\main.rs:2:3```

You will remember that ```src\main.rs``` is the directory and file name, and ```2:3``` is the line and column name. With this information, you can find the code and fix it.

```panic!``` is a good macro to use when writing your code to make sure that you know when something changes. For example, our function ```prints_three_things``` always prints index [0], [1], and [2] from a vector. It is okay because we always give it a vector with three items:

```rust
fn main() {
    let my_vec = vec![8, 9, 10];
    prints_three_things(my_vec);
}

fn prints_three_things(vector: Vec<i32>) {
    println!("{}, {}, {}", vector[0], vector[1], vector[2]);
}
```

But later on we write more and more code, and maybe we forget that ```my_vec``` can only be three things. Now ```my_vec``` in this part has six things:

```rust
fn main() {
  let my_vec = vec![8, 9, 10, 10, 55, 99]; // Now my_vec has six things
  prints_three_things(my_vec);
}

fn prints_three_things(vector: Vec<i32>) {
  println!("{}, {}, {}", vector[0], vector[1], vector[2]);
}
```

No error happens, because [0] and [1] and [2] are all inside. But maybe it was important to only have three things. So we should have done this:

```
fn main() {
    let my_vec = vec![8, 9, 10];
    prints_three_things(my_vec);
}

fn prints_three_things(vector: Vec<i32>) {
    if vector.len() != 3 {
        panic!("my_vec must always have three items") // will panic if the length is not 3
    }
    println!("{}, {}, {}", vector[0], vector[1], vector[2]);
}
```

Now we will know if the vector has six items:

```rust
fn main() {
    let my_vec = vec![8, 9, 10, 10, 55, 99];
    prints_three_things(my_vec);
}

fn prints_three_things(vector: Vec<i32>) {
    if vector.len() != 3 {
        panic!("my_vec must always have three items")
    }
    println!("{}, {}, {}", vector[0], vector[1], vector[2]);
}
```

This gives us ```thread 'main' panicked at 'my_vec must always have three items', src\main.rs:8:9```. Now we remember that ```my_vec``` should only have three items. So ```panic!``` is a good macro to create reminders in your code.

There are three other macros that are similar to ```panic!``` that you use a lot in testing. They are: ```assert!```, ```assert_eq!```, and ```assert_ne!```.

They mean:

* ```assert!()```: if the part inside ```()``` is not true, the program will panic.
*```assert_eq!()```: the two items inside ```()``` must be equal.
*```assert_ne!()```: the two items inside ```()``` must not be equal.


Some examples:

```rust
fn main() {
    let my_name = "Loki Laufeyson";

    assert!(my_name == "Loki Laufeyson");
    assert_eq!(my_name, "Loki Laufeyson");
    assert_ne!(my_name, "Mithridates");
}
```

This will do nothing, because all three assert macros are okay.

You can also add a message if you want.

```rust
fn main() {
    fn main() {
        let my_name = "Loki Laufeyson";

        assert!(
            my_name == "Loki Laufeyson",
            "{} should be Loki Laufeyson",
            my_name
        );
        assert_eq!(
            my_name, "Loki Laufeyson",
            "{} and Loki Laufeyson should be equal",
            my_name
        );
        assert_ne!(
            my_name, "Mithridates",
            "{} must not equal Mithridates",
            my_name
        );
    }
}
```

These messages will only display if the program panics. So if you run this:

```rust
fn main() {
    let my_name = "Mithridates";

    assert_ne!(
        my_name, "Mithridates",
        "{} must not equal Mithridates",
        my_name
    );
}
```

It will display:

```
thread 'main' panicked at 'assertion failed: `(left != right)`
  left: `"Mithridates"`,
 right: `"Mithridates"`: Mithridates must not equal Mithridates', src\main.rs:4:5
```

So it is saying "you said that left != right, but left == right". And it displays our message that says ```Mithridates must not equal Mithridates```.



```unwrap``` is also good when you want the program to crash when there is a problem. Later, when your code is finished it is good to change ```unwrap``` to something else that won't crash. You can also use ```expect```, which is like ```unwrap``` but with your own message.

This will crash:

```rust
fn main() {
    let my_vec = vec![9, 0, 10];
    let fourth = get_fourth(&my_vec);
}

fn get_fourth(input: &Vec<i32>) -> i32 {
    let fourth = input.get(3).unwrap();
    *fourth
}
```

The error message is ```thread 'main' panicked at 'called `Option::unwrap()` on a `None` value', src\main.rs:7:18```.

Now we write our own message with ```expect```:

```rust
fn main() {
    let my_vec = vec![9, 0, 10];
    let fourth = get_fourth(&my_vec);
}

fn get_fourth(input: &Vec<i32>) -> i32 {
    let fourth = input.get(3).expect("Input vector needs at least 4 items");
    *fourth
}
```

So the error message is ```thread 'main' panicked at 'Input vector needs at least 4 items', src\main.rs:7:18```.

You can also use ```unwrap_or``` if you want to always have a value that you choose.

```rust
fn main() {
    let my_vec = vec![8, 9, 10];

    let fourth = my_vec.get(3).unwrap_or(&0); // If .get doesn't work, we will make the value &0.
                                              // .get returns a reference, so we need &0 and not 0
                                              // to keep the types the same.
                                              // You can write "let *fourth" with a * if you want fourth to be
                                              // a 0 and not a &0, but here we just print so it doesn't matter

    println!("{}", fourth);
}
```


# Traits

We have seen traits before: Debug, Copy, Clone are all traits. To give a type a trait, you have to implement it. Because Debug and the others are so common, it's easy to do:

```rust
#[derive(Debug)]
struct MyStruct {
    number: usize,
}
```

But other traits are more difficult, so you need to implement them manually with ```impl```. For example, std::ops::Add is used to add two things. But you can add in many ways.

```rust
struct ThingsToAdd {
    first_thing: u32,
    second_thing: f32,
}
```

We can add ```first_thing``` and ```second_thing```, but we need to give more information. Maybe we want an f32, so something like this:

```rust
let result = self.second_thing + self.first_thing as f32
```

But maybe we want an integer, so like this:

```rust
let result = self.second_thing as u32 + self.first_thing
```

Or maybe we want to just put ```self.first_thing``` next to ```self.second_thing``` and say that this is how we want to add. So if we add 55 to 33.4, we want to see 5533, not 88.

So first let's look at how to make a trait. To make a trait, write ```trait``` and then create some functions.

```rust
struct Animal { // A simple struct - an Animal only has a name
    name: String,
}

trait Dog { // The dog trait gives some functionality
    fn bark(&self) { // It can bark
        println!("Woof woof!");
    }
    fn run(&self) { // and it can run
        println!("The dog is running!");
    }
}

impl Dog for Animal {} // Now Animal has the trait Dog

fn main() {
    let rover = Animal {
        name: "Rover".to_string(),
    };

    rover.bark(); // Now Animal can use bark()
    rover.run();  // and it can use run()
}
```

This is okay, but we don't want to print "The dog is running". We can change the method .run(), but we have to follow the signature. The signature says:

```rust
    fn run(&self) { 
        println!("The dog is running!");
    }
```

The signature says "fn run() takes &self, and returns nothing". So you can't do this:

```rust
    fn run(&self) -> i32 { 
        5
    }
```

Rust will say:

```
   = note: expected fn pointer `fn(&Animal)`
              found fn pointer `fn(&Animal) -> i32`
```

But we can do this:

```rust
impl Dog for Animal {
    fn run(&self) {
        println!("{} is running!", self.name);
    }
}
```

Now it prints ```Rover is running!```. This is okay because we are returning (), or nothing, which is what the trait says.

Actually, a trait doesn't need to write out the whole function. Now we change bark() and run() to just say ```fn bark(&self)``` and ```fn run(&self);```. This is not a full function, so the user must write it.


```rust
struct Animal {
    name: String,
}

trait Dog {
    fn bark(&self); // bark() says it needs a &self and returns nothing
    fn run(&self); // run() says it needs a &self and returns nothing.
                   // So now we have to write them ourselves.
}

impl Dog for Animal {
    fn bark(&self) {
        println!("{}, stop barking!!", self.name);
    }
    fn run(&self) {
        println!("{} is running!", self.name);
    }
}

fn main() {
    let rover = Animal {
        name: "Rover".to_string(),
    };

    rover.bark();
    rover.run();
}
```

So when you create a trait, you must think: "Which functions should I write? And which functions should the user write?" If you think the user will use the function the same way every time, then write out the function. If you think the user will use it differently, then just write the function signature.

So let's try implementing the Display trait for our struct. First we will make a simple struct:

```rust
struct Cat {
    name: String,
    age: u8,
}

fn main() {
    let mr_mantle = Cat {
        name: "Reggie Mantle".to_string(),
        age: 4,
    };
}
```

Now we want to print ```mr_mantle```. Debug is easy to derive:

```rust
#[derive(Debug)]
struct Cat {
    name: String,
    age: u8,
}

fn main() {
    let mr_mantle = Cat {
        name: "Reggie Mantle".to_string(),
        age: 4,
    };

    println!("Mr. Mantle is a {:?}", mr_mantle);
}
```

but Debug print is not what we want.

```rust
Mr. Mantle is a Cat { name: "Reggie Mantle", age: 4 }
```

So we need to implement Display for Cat. On https://doc.rust-lang.org/std/fmt/trait.Display.html we can see the information for Display, and one example. It says:

```rust
use std::fmt;

struct Position {
    longitude: f32,
    latitude: f32,
}

impl fmt::Display for Position {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "({}, {})", self.longitude, self.latitude)
    }
}
```

Some parts of this we don't understand yet, like ```<'_>``` and what ```f``` is doing. But we understand the ```Position``` struct: it is just two ```f32```s. We also understand that ```self.longitude``` and ```self.latitude``` are the values in the struct. So maybe we can just use this for our struct, with ```self.name``` and ```self.age```. Also, ```write!``` looks a lot like ```println!```. So we write this:

```rust
use std::fmt;

struct Cat {
    name: String,
    age: u8,
}

impl fmt::Display for Cat {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{} is a cat who is {} years old.", self.name, self.age)
    }
}
```

Now our code looks like this:

```rust
use std::fmt;
struct Cat {
    name: String,
    age: u8,
}

impl fmt::Display for Cat {
  fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
      write!(f, "{} is a cat who is {} years old.", self.name, self.age)
  }
}

fn main() {
    let mr_mantle = Cat {
        name: "Reggie Mantle".to_string(),
        age: 4,
    };

    println!("{}", mr_mantle);
}
```

Success! Now when we use ```{}``` to print, we get ```Reggie Mantle is a cat who is 4 years old.```. This looks much better.

## Taking a String and a &str in a function

Sometimes you want a function that can take both a ```String``` and a ```&str```. You can do this with generics and the ```AsRef``` trait. ```AsRef``` is used to give a reference from one type to another type. If you look at the documentation for ```String```, you can see that it has ```AsRef``` for many types:

https://doc.rust-lang.org/std/string/struct.String.html

Here are some function signatures for them.

```AsRef<str>```:

```rust
impl AsRef<str> for String

fn as_ref(&self) -> &str
```

```AsRef<[u8]>```:

```rust
impl AsRef<[u8]> for String

fn as_ref(&self) -> &[u8]
```

```AsRef<OsStr>```:

```rust
impl AsRef<OsStr> for String

fn as_ref(&self) -> &OsStr
```

You can see that it takes ```&self``` and gives a reference to the other type. This means that if you have a generic type T, you can say that it needs ```AsRef<str>```. If you do that, it will be able to take a ```&str``` and a ```String```.

Let's start with the generic function. This doesn't work yet:

```rust
fn print_it<T>(input: T) {
    println!("{}", input)
}

fn main() {
    print_it("Please print me");
}
```

Rust says ```error[E0277]: `T` doesn't implement `std::fmt::Display```. So we will require T to implement Display.

```rust
use std::fmt::Display;

fn print_it<T: Display>(input: T) {
    println!("{}", input)
}

fn main() {
    print_it("Please print me");
}
```

Now it works and prints ```Please print me```. That is good, but T can still be too many things. It can be an ```i8```, an ```f32``` and anything else with just ```Display```. So we add ```AsRef<str>```, and now T needs both ```AsRef<str>``` and ```Display```.

```rust
use std::fmt::Display;

fn print_it<T: AsRef<str> + Display>(input: T) {
    println!("{}", input)
}

fn main() {
    print_it("Please print me");
    print_it("Also, please print me".to_string());
    // print_it(7); <- This will not print
}
```

Now it won't take types like ```i8```.

Don't forget that you can write the function differently when it gets long. If we add Debug then it becomes ```fn print_it<T: AsRef<str> + Display + Debug>(input: T)``` which is long for one line. So we can write it like this:

```rust
use std::fmt::{Debug, Display}; // add Debug

fn print_it<T>(input: T) // Now this line is easy to read
where
    T: AsRef<str> + Debug + Display, // and these traits are easy to read
{
    println!("{}", input)
}

fn main() {
    print_it("Please print me");
    print_it("Also, please print me".to_string());
}
```


# Chaining methods

Rust is a systems programming language, but it also has a functional style. Both styles are okay, but functional style is usually shorter. Here is an example of declarative style to make a Vec from 1 to 10:

```rust
fn main() {
    let mut new_vec = Vec::new();
    let mut counter = 1;

    while counter < 11 {
        new_vec.push(counter);
        counter += 1;
    }

    println!("{:?}", new_vec);
}
```

And here is an example of functional style:

```rust
fn main() {
    let new_vec = (1..=10).collect::<Vec<i32>>();
	// Or you can write it like this:
	// let new_vec: Vec<i32> = (1..=10).collect();
    println!("{:?}", new_vec);
}
```

```.collect()``` can make collections of many types, so we have to tell it the type.

With functional style you can chain methods. That means to put many methods together in a single statement. Here is an example of many methods chained together:

```rust
fn main() {
    let my_vec = vec![0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    let new_vec = my_vec.into_iter().skip(3).take(4).collect::<Vec<i32>>();

    println!("{:?}", new_vec);
}
```

This creates a Vec with ```[3, 4, 5, 6]```. It is a good idea to put each method on a new line if you have many chained methods. This helps you to read the code. Here is the same code with each method on a new line:

```rust
fn main() {
    let my_vec = vec![0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    let new_vec = my_vec
        .into_iter() // "iterate" over the items (iterate = work with each separately). into_iter() gives us owned values, not references
        .skip(3) // skip over three items: 0, 1, and 2
        .take(4) // take the next four: 3, 4, 5, and 6
        .collect::<Vec<i32>>(); // put them in a new Vec<i32>

    println!("{:?}", new_vec);
}
```

You can use this functional style best when you understand closures and iterators. So we will learn them next.

# Iterators

An iterator is a collection that can give you the items in the collection, one at a time. Actually, we have already used iterators: the ```for``` loop gives you an iterator. When you want to use an iterator other times, you have to choose what kind:

* ```.iter()``` for an iterator of references
* ```.iter_mut()``` for an iterator of mutable references
* ```.into_iter()``` for an iterator of values (not references)

We can use them like this:

```rust
fn main() {
    let vector1 = vec![1, 2, 3]; // for .iter() and .into_iter()
    let mut vector2 = vec![10, 20, 30]; // for .iter_mut()

    let vector1_a = vector1.iter().map(|x| x + 1).collect::<Vec<i32>>();
    vector2.iter_mut().for_each(|x| *x +=100);
    let vector1_b = vector1.into_iter().map(|x| x * 10).collect::<Vec<i32>>();

    println!("{:?}", vector1_a);
    println!("{:?}", vector2);
    println!("{:?}", vector1_b);

}
```

First we used ```.iter()``` on ```vector1``` to get references. We added 1 to each, and made it into a new Vec. ```vector1``` is still alive because we only used references: we didn't take by value. Now we have ```vector1```, and a new Vec called ```vector1_a```.

Then we used ```.iter_mut()``` for ```vector2```. It is mutable, so we don't need to use ```.collect()``` to create a new Vec. Instead, we change the values in the same Vec with mutable references. So ```vector2``` is still there. Because we don't need a new Vec, we use ```for_each```: it's just like a ```for``` loop.

Finally we used ```into_iter``` to get an iterator by value from ```vector1```. This destroys ```vector1```, so after we make ```vector1_b``` we can't use ```vector1``` again.

## How does an iterator work?

An iterator works by using a method called ```.next()```, which gives an ```Option```. When you use an iterator, Rust calls ```next()```. If it gets ```Some```, it keeps going. If it gets ```None```, it stops.

In documentation, you see examples like this to show how an iterator works.

```rust
fn main() {
    let my_vec = vec!['a', 'b', '거', '柳'];

    let mut my_vec_iter = my_vec.iter(); // This is an iterator type now, but we haven't called it yet

    assert_eq!(my_vec_iter.next(), Some(&'a')); // Call the first item with .next()
    assert_eq!(my_vec_iter.next(), Some(&'b')); // Call the next
    assert_eq!(my_vec_iter.next(), Some(&'거')); // Again
    assert_eq!(my_vec_iter.next(), Some(&'柳')); // Again
    assert_eq!(my_vec_iter.next(), None);        // Nothing is left: just None
    assert_eq!(my_vec_iter.next(), None); // You can keep calling .next() but it will always be None

}
```

Implementing Iterator for your own struct or enum is not too hard. First let's make a book library and think about it.

```rust
#[derive(Debug)] // we want to print it with {:?}
struct Library {
    library_type: LibraryType, // this is our enum
    books: Vec<String>, // list of books
}

#[derive(Debug)]
enum LibraryType { // libraries can be city libraries or country libraries
    City,
    Country,
}

impl Library {
    fn add_book(&mut self, book: &str) { // we use add_book to add new books
        self.books.push(book.to_string()); // we take a &str and turn it into a String, then add it to the Vec
    }

    fn new() -> Self { // this creates a new Library
        Self {
            library_type: LibraryType::City, // most are in the city so we'll choose City 
                                             // most of the time
            books: Vec::new(),
        }
    }
}

fn main() {
    let mut my_library = Library::new(); // make a new library
    my_library.add_book("The Doom of the Darksword"); // add some books
    my_library.add_book("Demian - die Geschichte einer Jugend");
    my_library.add_book("구운몽");
    my_library.add_book("吾輩は猫である");
    

    println!("{:?}", my_library.books); // we can print our list of books
}
```

That works well. Now we want to implement ```Iterator``` for the library so we can use it in a ```for``` loop. Right now if we try a ```for``` loop, it doesn't work:

```rust
   for item in my_library {
    println!("{}", item);
   }
```

It says: 

```
error[E0277]: `Library` is not an iterator
  --> src\main.rs:47:16
   |
47 |    for item in my_library {
   |                ^^^^^^^^^^ `Library` is not an iterator
   |
   = help: the trait `std::iter::Iterator` is not implemented for `Library`
   = note: required by `std::iter::IntoIterator::into_iter`
```

But we can make library into an iterator with ```impl Iterator for Library```. Information on the ```Iterator``` trait is here in the standard library: https://doc.rust-lang.org/std/iter/trait.Iterator.html

On the top left of the page it says: ```Associated Types: Item``` and ```Required Methods: next```. An "associated type" means "a type that goes together". Our associated type will be ```String```, because we want the iterator to give us Strings.

In the page it has an example that looks like this:

```rust
// an iterator which alternates between Some and None
struct Alternate {
    state: i32,
}

impl Iterator for Alternate {
    type Item = i32;

    fn next(&mut self) -> Option<i32> {
        let val = self.state;
        self.state = self.state + 1;

        // if it's even, Some(i32), else None
        if val % 2 == 0 {
            Some(val)
        } else {
            None
        }
    }
}
```

You can see that under ```impl Iterator for Alternate``` it says ```type Item = i32```. This is the associated type. Our iterator will be for our list of books, which is a ```Vec<String>>```. When we call next, it will give us a ```String```. So we will write ```type Item = String;```. That is the associated item.

To implement ```Iterator```, you need to write the ```fn next()``` function. This is where you decide what the iterator should do. For our ```Library```, we want it to give us the last books first. So we will ```match``` with ```.pop()``` which takes the last item off it it is ```Some```. We also want to print " is found!" for each item. Now it looks like this:

```rust
#[derive(Debug)]
struct Library {
    library_type: LibraryType,
    books: Vec<String>,
}

#[derive(Debug)]
enum LibraryType {
    City,
    Country,
}

impl Library {
    fn add_book(&mut self, book: &str) {
        self.books.push(book.to_string());
    }

    fn new() -> Self {
        Self {
            library_type: LibraryType::City,
            // most of the time
            books: Vec::new(),
        }
    }
}

impl Iterator for Library {
    type Item = String;

    fn next(&mut self) -> Option<String> {
        match self.books.pop() {
            Some(book) => Some(book + " is found!"), // Rust allows String + &str
            None => None,
        }
    }
}

fn main() {
    let mut my_library = Library::new();
    my_library.add_book("The Doom of the Darksword");
    my_library.add_book("Demian - die Geschichte einer Jugend");
    my_library.add_book("구운몽");
    my_library.add_book("吾輩は猫である");

    for item in my_library { // we can use a for loop now
        println!("{}", item);
    }
}
```

This prints:

```
吾輩は猫である is found!
구운몽 is found!
Demian - die Geschichte einer Jugend is found!
The Doom of the Darksword is found!
```

# Closures

Closures are like quick functions that don't need a name. Sometimes they are called lambdas. Closures are easy to find because they use ```||``` instead of ```()```.

You can bind a closure to a variable, and then it looks like a function:

```rust
fn main() {
    let my_closure = || println!("This is a closure");
    my_closure();
}
```

So this closure takes nothing: ```||``` and prints a message.

In between the ```||``` we can add input variables and types:

```rust
fn main() {
    let my_closure = |x: i32| println!("{}", x);

    my_closure(5);
}
```
When the closure becomes more complicated, you can add a code block. Then it can be as long as you want.

```rust
fn main() {
    let my_closure = || {
        let number = 7;
        let other_number = 10;
        println!("The two numbers are {} and {}.", number, other_number);
          // This closure can be as long as we want, just like a function.
    };

    my_closure();
}
```

But closures are special because they can take variables outside the closure. So you can do this:

```rust
fn main() {
    let number_one = 6;
    let number_two = 10;

    let my_closure = || println!("{}", number_one + number_two);
    my_closure();
}
```

So this prints ```16```. You didn't need to put anything inside ```||``` because the closure can just take them.

And you can do this:

```rust
fn main() {
    let number_one = 6;
    let number_two = 10;

    let my_closure = |x: i32| println!("{}", number_one + number_two + x);
    my_closure(5);
}
```

This closure takes ```number_one``` and ```number_two```. We also gave it a new variable ```x``` and said that ```x``` is 5. Then it adds all three together.

Usually you see closures in Rust inside of a method, because it is very convenient to have a closure inside. For example, there is the ```unwrap_or``` method that we know that you can use to give a value if ```unwrap``` doesn't work. Before, we wrote: ```let fourth = my_vec.get(3).unwrap_or_(&0);```. But there is also an ```unwrap_or_else``` method that has a closure inside. So you can do this:

```rust
fn main() {
    let my_vec = vec![8, 9, 10];

    let fourth = my_vec.get(3).unwrap_or_else(|| { // try to unwrap. If it doesn't work,
        if my_vec.get(0).is_some() { // see if my_vec has something at index [0]
            &my_vec[0] // Give the number at index 0 if there is something
        } else {
            &0 // otherwise give a &0
        }
    });

    println!("{}", fourth);
}
```

Of course, a closure can be very simple. You can just write ```let fourth = my_vec.get(3).unwrap_or_else(|| &0);``` for example. As long as you put the ```||``` in, the compiler knows that you have put in the closure that you need.

The most frequent closure method is maybe ```.map()```. This method does something to each item. Here is one way to use it:

```rust
fn main() {
    let num_vec = vec![2, 4, 6];

    let double_vec = num_vec  // take num_vec
        .iter() // iterate over it
        .map(|number| number * 2) // for each item, multiply by two
        .collect::<Vec<i32>>(); // then make a new Vec from this
    println!("{:?}", double_vec);
}
```

Another good example is with ```.enumerate()```. This gives an iterator with the index number, and the item. For example: ```[10, 9, 8]``` becomes ```(0, 10), (1, 9), (2, 8)```. So you can do this:

```rust
fn main() {
    let num_vec = vec![10, 9, 8];

    num_vec
        .iter() // iterate over num_vec
        .enumerate() // get (index, number)
        .for_each(|(index, number)| println!("Index number {} has number {}", index, number)); // do something for each one
}
```

This prints:

```
Index number 0 has number 10
Index number 1 has number 9
Index number 2 has number 8
```

In this case we use ```for_each``` instead of ```map```. ```map``` is for **doing something to** each item and passing it on, and ```for_each``` is **doing something when you see each item**. Also, ```map``` doesn't do anything unless you use a method like ```collect```.

Actually, this is the interesting thing about iterators. If you try to ```map``` without a method like ```collect```, the compiler will tell you that it doesn't do anything:

```rust
fn main() {
    let num_vec = vec![10, 9, 8];

    num_vec
        .iter()
        .enumerate()
        .map(|(index, number)| println!("Index number {} has number {}", index, number));

}
```

It says:

```
warning: unused `std::iter::Map` that must be used
 --> src\main.rs:4:5
  |
4 | /     num_vec
5 | |         .iter()
6 | |         .enumerate()
7 | |         .map(|(index, number)| println!("Index number {} has number {}", index, number));
  | |_________________________________________________________________________________________^
  |
  = note: `#[warn(unused_must_use)]` on by default
  = note: iterators are lazy and do nothing unless consumed
```

This is a **warning**, so it's not an error: the program runs fine. But why doesn't num_vec do anything? We can look at the types to see.

* ```let num_vec = vec![10, 9, 8];``` Right now it is a ```Vec<i32>```.
* ```.iter()``` Now it is an ```Iter<i32>```. So it is an iterator with items of ```i32```.
* ```.enumerate()``` Now it is an ```Enumerate<Iter<i32>>```. So it is a type ```Enumerate``` of type ```Item``` of ```i32```s.
* ```.map()``` Now it is a type ```Map<Enumerate<Iter<i32>>>```. So it is a type ```Map``` of type ```Enumerate``` of type ```Item``` of ```i32```s.

So this ```Map<Enumerate<Iter<i32>>>``` is a structure that is ready to go, when we tell it what to do. Rust does this because it needs to be fast. It doesn't want to do this:

* iterate over all the i32s in the Vec
* enumerate over all the i32s from the iterator
* map over all the enumerated i32s

Rust only wants to do one calculation, so it creates the structure and waits. Then if we say ```.collect::<Vec<i32>>()``` it knows what to do, and starts moving. This is what ```iterators are lazy and do nothing unless consumed``` means. The iterators don't do anything until you "consume" them (use them up).

## |_| in a closure

Sometimes you see ```|_|``` in a closure. This means that the closure needs an argument, but you don't need to use it. So ```|_|``` means "Okay, here is the argument but I won't give it a name because I don't care about it".

Here is an example of an error:

```rust
fn main() {
    let my_vec = vec![8, 9, 10];

    println!("{:?}", my_vec.iter().for_each(|| println!("We didn't use the variables at all")));
}
```

Rust says that 

```
error[E0593]: closure is expected to take 1 argument, but it takes 0 arguments
  --> src\main.rs:28:36
   |
28 |     println!("{:?}", my_vec.iter().for_each(|| println!("We didn't use the variables at all")));
   |                                    ^^^^^^^^ -- takes 0 arguments
   |                                    |
   |                                    expected closure that takes 1 argument
```

The compiler actually gives you some help:

```
help: consider changing the closure to take and ignore the expected argument
   |
28 |     println!("{:?}", my_vec.iter().for_each(|_| println!("We didn't use the variables at all")));
```

This is good advice. If you change ```||``` to ```|_|``` then it will work.




## The dbg! macro and .inspect
dbg!() is a very useful macro that prints quick information. Sometimes you use it instead of ```println!``` because it is faster to type:

```rust
fn main() {

    let my_number = 8;
    dbg!(my_number);

}
```

This prints ```[src\main.rs:4] my_number = 8```.

But actually, you can put ```dbg!``` in many other places. Look at this code for example:

```rust
fn main() {

    let mut my_number = 9;
    my_number += 10;

    let new_vec = vec![8, 9, 10];

    let double_vec = new_vec.iter().map(|x| x * 2).collect::<Vec<i32>>();

}
```

This code creates a new mutable number and changes it. Then it creates a vec, and uses ```iter``` and ```map``` and ```collect``` to create a new vec. We can put ```dbg!``` almost everywhere in this code. ```dbg!``` asks the compiler: "What are you doing here?"

```rust
fn main() {

    let mut my_number = dbg!(9);
    dbg!(my_number += 10);

    let new_vec = dbg!(vec![8, 9, 10]);

    let double_vec = dbg!(new_vec.iter().map(|x| x * 2).collect::<Vec<i32>>());

    dbg!(double_vec);

}
```

So this prints:

```rust
[src\main.rs:3] 9 = 9
```

and:

```rust
[src\main.rs:4] my_number += 10 = ()
```

and:

```rust
[src\main.rs:6] vec![8, 9, 10] = [
    8,
    9,
    10,
]
```

and:

```rust
[src\main.rs:8] new_vec.iter().map(|x| x * 2).collect::<Vec<i32>>() = [
    16,
    18,
    20,
]
```

and:

```rust
[src\main.rs:10] double_vec = [
    16,
    18,
    20,
]
```


```.inspect``` is a bit similar to ```dbg!``` but you use it like ```map```. For example, let's look at our ```double_vec``` again.

```rust
fn main() {

    let new_vec = vec![8, 9, 10];

    let double_vec = new_vec
        .iter()
        .map(|x| x * 2)
        .collect::<Vec<i32>>();

}
```

We want to know more information about what the code is doing. So we add ```inspect``` in two places:

```rust
fn main() {

    let new_vec = vec![8, 9, 10];

    let double_vec = new_vec
        .iter()
        .inspect(|first_item| println!("The item is: {}", first_item))
        .map(|x| x * 2)
        .inspect(|next_item| println!("Then it is: {}", next_item))
        .collect::<Vec<i32>>();

}
```

This prints:

```
The item is: 8
Then it is: 16
The item is: 9
Then it is: 18
The item is: 10
Then it is: 20
```

And because ```.inspect``` takes a closure, we can write as much as we want:

```rust
fn main() {
    let new_vec = vec![8, 9, 10];

    let double_vec = new_vec
        .iter()
        .inspect(|first_item| {
            println!("The item is: {}", first_item);
            match **first_item % 2 { // first item is a &&i32 so we use **
                0 => println!("It is even."),
                _ => println!("It is odd."),
            }
            println!("In binary it is {:b}.", first_item);
        })
        .map(|x| x * 2)
        .collect::<Vec<i32>>();
}
```

This prints:

```
The item is: 8
It is even.
In binary it is 1000.
The item is: 9
It is odd.
In binary it is 1001.
The item is: 10
It is even.
In binary it is 1010.
```

# Types of &str

There is more than one type of &str. We have:

* String literals: you make these when you write ```let my_str = "I am a &str"```. They last for the whole program, because they are written directly into the binary. They have the type ```&'static str```. ```'``` means its lifetime, and string literal have a lifetime called ```static```.
* Borrowed str: This is the regular ```&str``` form without a ```static``` lifetime. If you create a ```String``` and get a reference to it, Rust will convert it to a ```&str``` when you need it. For example:

```rust
fn main() {
    let my_string = String::from("I am a string");
    prints_str(&my_string); // we give prints_str a &String
}

fn prints_str(my_str: &str) { // it can use &String like a &str
    println!("{}", my_str);
}
```

So what is a lifetime?

# Lifetimes

A lifetime means "how long the variable lives". You only need to think about lifetimes with references. This is because references can't live longer than the object they come from. For example, this function does not work:

```rust
fn returns_reference() -> &str {
    let my_string = String::from("I am a string");
    &my_string
}
```

The problem is that ```my_string``` only lives inside ```returns_reference```. We try to return ```&my_string```, but ```&my_string``` can't exist without ```my_string```. So the compiler says no.

This code also doesn't work:

```rust
fn main() {
    let my_str = returns_str();
    println!("{}", my_str);
}

fn returns_str() -> &str {
    let my_string = String::from("I am a string");
    "I am a str"
}
```

But it almost works. The compiler says:

```
error[E0106]: missing lifetime specifier
 --> src\main.rs:6:21
  |
6 | fn returns_str() -> &str {
  |                     ^ expected named lifetime parameter
  |
  = help: this function's return type contains a borrowed value, but there is no value for it to be borrowed from
help: consider using the `'static` lifetime
  |
6 | fn returns_str() -> &'static str {
  |                     ^^^^^^^^
```


```missing lifetime specifier``` means that we need to add a ```'``` with the lifetime. Then it says that it ```contains a borrowed value, but there is no value for it to be borrowed from```. That means that ```I am a str``` isn't borrowed from anything. It says ```consider using the `'static` lifetime``` by writing ```&'static str```. So it thinks we should try saying that this is a string literal.

Now it works:

```rust
fn main() {
    let my_str = returns_str();
    println!("{}", my_str);
}

fn returns_str() -> &'static str {
    let my_string = String::from("I am a string");
    "I am a str"
}
```

So now ```fn returns_str() -> &'static str``` tells Rust: "don't worry, we will only return a string literal". String literals live for the whole program, so Rust is happy.

But ```'static``` is not the only lifetime. Actually, every variable has a lifetime, but usually we don't have to write it. We only have to write the lifetime when the compiler doesn't know.

Here is an example of another lifetime. Imagine we want to create a ```City``` struct and give it a ```&str``` for the name. Later we will have many more ```&str```s because we need faster performance than with ```String```. So we write it like this, but it won't work:

```rust
#[derive(Debug)]
struct City {
    name: &str,
    date_founded: u32,
}

fn main() {
    let my_city = City {
        name: "Ichinomiya",
        date_founded: 1921,
    };
}
```

The compiler says:

```
error[E0106]: missing lifetime specifier
 --> src\main.rs:3:11
  |
3 |     name: &str,
  |           ^ expected named lifetime parameter
  |
help: consider introducing a named lifetime parameter
  |
2 | struct City<'a> {
3 |     name: &'a str,
  |
```

Rust needs a lifetime for ```&str``` because ```&str``` is a reference. What happens when the value that ```name``` points to is dropped? That would be unsafe.

What about ```'static```, will that work? We used it before. Let's try:

```rust
#[derive(Debug)]
struct City {
    name: &'static str, // change &str to &'static str
    date_founded: u32,
}

fn main() {
    
    let my_city = City {
        name: "Ichinomiya",
        date_founded: 1921,
    };  

    println!("{} was founded in {}", my_city.name, my_city.date_founded);

}
```

Okay, that works. And maybe this is what you wanted for the struct. However, note that we can only take "string literals", so not references to something else. So this will not work:

```rust
#[derive(Debug)]
struct City {
    name: &'static str, // must live for the whole program
    date_founded: u32,
}

fn main() {
    
    let city_names = vec!["Ichinomiya".to_string(), "Kurume".to_string()]; // city_names does not live for the whole program

    let my_city = City {
        name: &city_names[0], // This is a &str, but not a &'static str. It is a reference to a value inside city_names
        date_founded: 1921,
    };  

    println!("{} was founded in {}", my_city.name, my_city.date_founded);

}
```

The compiler says:

```
error[E0597]: `city_names` does not live long enough
  --> src\main.rs:12:16
   |
12 |         name: &city_names[0],
   |                ^^^^^^^^^^
   |                |
   |                borrowed value does not live long enough
   |                requires that `city_names` is borrowed for `'static`
...
18 | }
   | - `city_names` dropped here while still borrowed
```

So now we will try what the compiler suggested before. It said to try writing ```struct City<'a>``` and ```name: &'a str```. This means that it will only take a reference for ```name``` if it lives as long as ```City```.

```rust
#[derive(Debug)]
struct City<'a> { // City has lifetime 'a
    name: &'a str, // and name also has lifetime 'a.
    date_founded: u32,
}

fn main() {
    
    let city_names = vec!["Ichinomiya".to_string(), "Kurume".to_string()];

    let my_city = City {
        name: &city_names[0],
        date_founded: 1921,
    };  

    println!("{} was founded in {}", my_city.name, my_city.date_founded);

}
```

Also remember that you can write anything instead of ```'a``` if you want:

```rust
#[derive(Debug)]
struct City<'city> { // The lifetime is now called 'city
    name: &'city str, // and name has the 'city lifetime
    date_founded: u32,
}
```

So usually you will write ```'a, 'b, 'c``` etc. because it is quick and the usual way to write. But you can always change it if you want.

Also remember this important fact: ```'a``` etc. don't change the actual lifetime of variables. They are like traits for generics. Remember when we wrote generics? For example:

```rust
fn prints<T: Display>(input: T) {
    println!("T is {}", input);
}
```

When you write ```T: Display```, it means "please only take T if it has Display".
It does not mean: "I am giving Display to T".

The same is true for lifetimes. When you write 'a here:

```rust
#[derive(Debug)]
struct City<'a> { 
    name: &'a str,
    date_founded: u32,
}
```

It means "please only take an input for ```name``` if it lives at least as long as ```City```". 
It does not mean: "I will make the input for ```name``` live as long as ```City```".



# Interior mutability
## Cell

**Interior mutability** means having a little bit of mutability on the inside. Rust has some ways to let you safely change values inside of a struct that is immutable. First, let's look at a simple example where we would want this. Imagine a ```struct``` called ```PhoneModel``` with many fields:

```rust
struct PhoneModel {
    company_name: String,
    model_name: String,
    screen_size: f32,
    memory: usize,
    date_issued: u32,
    on_sale: bool,
}

fn main() {
    let super_phone_3000 = PhoneModel {
        company_name: "YY Electronics".to_string(),
        model_name: "Super Phone 3000".to_string(),
        screen_size: 7.5,
        memory: 4_000_000,
        date_issued: 2020,
        on_sale: true,
    };

}
```

It is better for the fields in ```PhoneModel``` to be immutable, because we don't want the data to change. The ```date_issued``` and ```screen_size``` never change, for example.

But inside is one field called ```on_sale```. A phone model will first be on sale (```true```), but later the company will stop selling it. Can we make just this one field mutable? Because we don't want to write ```let mut super_phone_3000```. If we do, then every field will become mutable.

Rust has many ways to allow some safe mutability inside of something that is immutable. The most simple is called ```Cell```. First we use ```use std::cell::Cell``` so that we can just write ```Cell``` instead of ```std::cell::Cell``` every time.

Then we change ```on_sale: bool``` to ```on_sale: Cell<bool>```. Now it is a ```bool``` inside of the ```Cell```.

```Cell``` has a method called ```.set()``` where you can change the value. We use ```.set()``` to change ```on_sale: true``` to ```on_sale: Cell::new(true)```.

```rust
use std::cell::Cell;

struct PhoneModel {
    company_name: String,
    model_name: String,
    screen_size: f32,
    memory: usize,
    date_issued: u32,
    on_sale: Cell<bool>,
}

fn main() {
    let super_phone_3000 = PhoneModel {
        company_name: "YY Electronics".to_string(),
        model_name: "Super Phone 3000".to_string(),
        screen_size: 7.5,
        memory: 4_000_000,
        date_issued: 2020,
        on_sale: Cell::new(true),
    };

    // 10 years later, super_phone_3000 is not on sale anymore
    super_phone_3000.on_sale.set(false);    

}
```

```Cell``` works for all types, but works best for simple Copy types because it gives values, not references. ```Cell``` has a method called ```get()``` for example that only works on Copy types.

Another type you can use is ```RefCell```.

# RefCell

A ```RefCell``` is another way to change values without needing to declare ```mut```. It is like a ```Cell``` but uses references instead of copies.

We will create a ```User``` struct. So far you can see that it is similar to Cell:

```rust
use std::cell::RefCell;

#[derive(Debug)]
struct User {
    id: u32,
    year_registered: u32,
    username: String,
    active: RefCell<bool>,
    // Many other fields
}

fn main() {
    let user_1 = User {
        id: 1,
        year_registered: 2020,
        username: "User 1".to_string(),
        active: RefCell::new(true),
    };

    println!("{:?}", user_1.active);

}
```

This prints ```RefCell { value: true }```.

There are many methods for ```RefCell```. Two of them are ```.borrow()``` and ```.borrow_mut()```. With these methods, you can do the same thing you do with ```&``` and ```&mut```. The rules are the same: 

* Many borrows is fine, 
* one mutable borrow is fine, 
* but mutable and immutable together is not fine.

So changing the value in a ```RefCell``` is very easy:

```rust
    user_1.active.replace(false);
    println!("{:?}", user_1.active);
```

And there are many other methods like ```replace_with``` that uses a closure:

```rust
    let date = 2020;

    user_1
        .active
        .replace_with(|_| if date < 2000 { true } else { false });
    println!("{:?}", user_1.active);
```

But you have to be careful with a ```RefCell```, because it checks borrows at runtime, not compilation time. So this will compile:

```rust
use std::cell::RefCell;

#[derive(Debug)]
struct User {
    id: u32,
    year_registered: u32,
    username: String,
    active: RefCell<bool>,
    // Many other fields
}

fn main() {
    let user_1 = User {
        id: 1,
        year_registered: 2020,
        username: "User 1".to_string(),
        active: RefCell::new(true),
    };

    let borrow_one = user_1.active.borrow_mut(); // first mutable borrow - okay
    let borrow_two = user_1.active.borrow_mut(); // second mutable borrow - not okay
}
```

But if you run it, it will immediately panic.

```rust
thread 'main' panicked at 'already borrowed: BorrowMutError', C:\Users\mithr\.rustup\toolchains\stable-x86_64-pc-windows-msvc\lib/rustlib/src/rust\src\libcore\cell.rs:877:9
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
error: process didn't exit successfully: `target\debug\rust_book.exe` (exit code: 101)
```

```already borrowed: BorrowMutError``` is the important part. So when you use a ```RefCell```, it is good to compile **and** run to check.


# Mutex

```Mutex``` is another way to change values without declaring ```mut```. Mutex means ```mutual exclusion```, which means "only one at a time". This is why a ```Mutex``` is safe, because it only lets one process change it at a time. To do this, it uses ```.lock()```. ```Lock``` is like locking a door from the inside. You go into a room, lock the door, and now you can change things inside the room. Nobody else can come in and stop you, because you locked the door.

A ```Mutex``` is easier to understand through examples.

```rust
use std::sync::Mutex;

fn main() {
    let my_mutex = Mutex::new(5); // A new Mutex<i32>. We don't need to say mut
    let mut mutex_changer = my_mutex.lock().unwrap(); // mutex_changer is a MutexGuard
                                                     // It has to be mut because we will change it
                                                     // Now it has access to the Mutex
                                                     // Let's print my_mutex to see:
    
    println!("{:?}", my_mutex); // This prints "Mutex { data: <locked> }"
                                // So we can't access the data with my_mutex now,
                                // only with mutex_changer
    
    println!("{:?}", mutex_changer); // This prints 5. Let's change it to 6.

    *mutex_changer = 6; // mutex_changer is a MutexGuard<i32> so we use * to change the i32

    println!("{:?}", mutex_changer); // Now it says 6
    
}
```

But ```mutex_changer``` still has a lock. How do we stop it? A ```Mutex``` is unlocked when the ```MutexGuard``` goes out of scope. "Go out of scope" means the code block is finished. For example:

```rust
use std::sync::Mutex;

fn main() {
    let my_mutex = Mutex::new(5);
    {
        let mut mutex_changer = my_mutex.lock().unwrap();
        *mutex_changer = 6;
    } // mutex_changer goes out of scope - now it is gone

    println!("{:?}", my_mutex); // Now it says 6
}
```

If you don't want to use a different ```{}``` code block, you can use ```std::mem::drop(mutex_changer)```. ```std::mem::drop``` means "make this go out of scope".

use std::sync::Mutex;

```rust
fn main() {
    let my_mutex = Mutex::new(5);
    let mut mutex_changer = my_mutex.lock().unwrap();
    *mutex_changer = 6;
    std::mem::drop(mutex_changer); // drop mutex_changer - it is gone now
                                   // and my_mutex is unlocked

    println!("{:?}", my_mutex); // Now it says 6
}
```

You have to be careful with a ```Mutex``` because if another variable tries to ```lock``` it, it will wait:

```rust
use std::sync::Mutex;

fn main() {
    let my_mutex = Mutex::new(5);
    let mut mutex_changer = my_mutex.lock().unwrap(); // mutex_changer has the lock
    let mut other_mutex_changer = my_mutex.lock().unwrap(); // other_mutex_changer wants the lock
                                                            // the program is waiting
                                                            // and waiting
                                                            // and will wait forever.

    println!("This will never print...");

}
```

One other method is ```try_lock()```. Then it will try once, and if it doesn't get the lock it will give up. Don't do ```try_lock().unwrap()```, because it will panic if it doesn't work. ```if let``` or ```match``` is better:

```rust
use std::sync::Mutex;

fn main() {
    let my_mutex = Mutex::new(5);
    let mut mutex_changer = my_mutex.lock().unwrap();
    let mut other_mutex_changer = my_mutex.try_lock(); // try to get the lock

    if let Ok(value) = other_mutex_changer { // 
        println!("The MutexGuard has: {}", value)
    } else {
        println!("Didn't get the lock")
    }
}
}
```

Also, you don't need to make a variable to change the ```Mutex```. You can just do this:

```rust
use std::sync::Mutex;

fn main() {
    let my_mutex = Mutex::new(5);

    *my_mutex.lock().unwrap() = 6;

    println!("{:?}", my_mutex);
}
```

```*my_mutex.lock().unwrap() = 6;``` means "unlock my_mutex and make it 6". There is no variable that holds it so you don't need to call ```std::mem::drop```. You can do it 100 times if you want - it doesn't matter:

```rust
use std::sync::Mutex;

fn main() {
    let my_mutex = Mutex::new(5);

    for _ in 0..100 {
        *my_mutex.lock().unwrap() += 1; // locks and unlocks 100 times
    }

    println!("{:?}", my_mutex);
}
```

# RwLock

```RwLock``` means "read write lock". It is like a ```Mutex``` but also like a ```RefCell```. You use ```.write().unwrap()``` instead of ```.lock().unwrap()``` to change it. But you can also use ```.read().unwrap()``` to get read access. It is like ```RefCell``` because it follows the rules:

* many ```.read()``` variables is okay,
* one ```.write()```` variable is okay,
* but more than one ```.read()``` or ```.read()``` together with ```.write()``` is not okay.

The program will run forever if you try to ```.write()``` when you can't get access:

```rust
use std::sync::RwLock;

fn main() {
    let my_rwlock = RwLock::new(5);

    let read1 = my_rwlock.read().unwrap(); // one .read() is fine
    let read2 = my_rwlock.read().unwrap(); // two .read()s is also fine

    println!("{:?}, {:?}", read1, read2);

    let write1 = my_rwlock.write().unwrap(); // uh oh, now the program will wait forever
}
```

So we use ```std::mem::drop```, just like in a ```Mutex```.

```rust
use std::sync::RwLock;
use std::mem::drop; // We will use drop() many times

fn main() {
    let my_rwlock = RwLock::new(5);

    let read1 = my_rwlock.read().unwrap();
    let read2 = my_rwlock.read().unwrap();

    println!("{:?}, {:?}", read1, read2);

    drop(read1);
    drop(read2); // we dropped both, so we can use .write() now

    let mut write1 = my_rwlock.write().unwrap();
    *write1 = 6;
    drop(write1);
    println!("{:?}", my_rwlock);
}
```

And you can use ```try_read()``` and ```try_write()``` too.

```rust
use std::sync::RwLock;

fn main() {
    let my_rwlock = RwLock::new(5);

    let read1 = my_rwlock.read().unwrap();
    let read2 = my_rwlock.read().unwrap();

    if let Ok(mut number) = my_rwlock.try_write() {
        *number += 10;
        println!("Now the number is {}", number);
    } else {
        println!("Couldn't get write access, sorry!")
    };
    
}
```

# Cow

Cow is a very convenient enum. It means "clone on write" and lets you return a ```&str``` if you don't need a ```String```, and a ```String``` if you need it. (It can also do the same with arrays vs. Vecs, etc.)

To understand it, let's look at the signature. It says:

```rust
pub enum Cow<'a, B> 
where
    B: 'a + ToOwned + ?Sized, 
 {
    Borrowed(&'a B),
    Owned(<B as ToOwned>::Owned),
}
```

You know right away that ```'a``` means it works with references. The ```ToOwned``` trait means that it is a type that can be turned into an owned type. For example, ```str``` is usually a reference (```&str```) and you can turn it into an owned ```String```.

Next is ```?Sized```. This means "maybe Sized, but maybe not". Almost every type in Rust is Sized, but types like ```str``` are not. That is why we need a ```&``` for a ```str```, because the compiler doesn't know the size. So if you want a trait that can use something like a ```str```, you add ```?Sized.```

Next are enum variants. They are ```Borrowed``` and ```Owned```.

Imagine that you have a function that returns ```Cow<'static, str>```. If you tell the function to return ```"My message".into()```, it will look at the type: "My message" is a ```str```. This is a ```Borrowed``` type, so it chooses ```Borrowed(&'a B)```. So it becomes Cow::Borrowed(&'static str)```.

And if you give it a ```format!("{}", "My message".into()``` then it will look at the type. This time it is a ```String```, because ```format!``` makes a ```String```. So this time it will select "Owned".

Here is an example to test ```Cow```. We will put a number into a function that returns a ```Cow<'static, str>```. Depending on the number, it will create a ```&str``` or a ```String```. Then it uses ```.into()``` to turn it into a ```Cow```. When you do that, it will choose either ```Cow:::Borrowed``` or ```Cow::Owned```. Then we will match to see which one it chose.

```rust
use std::borrow::Cow;

fn modulo_3(input: u8) -> Cow<'static, str> {
    
    match input % 3 {
        0 => "Remainder is 0".into(),
        1 => "Remainder is 1".into(),
        remainder => format!("Remainder is {}", remainder).into(),
    }
}

fn main() {
    for number in 1..=6 {
        match modulo_3(number) {
            Cow::Borrowed(message) => println!("{} went in. The Cow is borrowed with this message: {}", number, message),
            Cow::Owned(message) => println!("{} went in. The Cow is owned with this message: {}", number, message),
        }
    }    
}
```

This prints:

```
1 went in. The Cow is borrowed with this message: Remainder is 1
2 went in. The Cow is owned with this message: Remainder is 2
3 went in. The Cow is borrowed with this message: Remainder is 0
4 went in. The Cow is borrowed with this message: Remainder is 1
5 went in. The Cow is owned with this message: Remainder is 2
6 went in. The Cow is borrowed with this message: Remainder is 0
```

```Cow``` has some other methods like ```into_owned``` or ```into_borrowed``` so you can change it if you need to.

# Type aliases

A type alias means "giving a new name to another type". Type aliases are very easy. Usually you use them when you have a very long type and don't want to write it every time. It is also good when you want to give a type a better name that is easy to remember. Here are two examples of type aliases.

The type is not difficult, but you want to make your code easier to understand for other people (or for you):

'''rust
type CharacterVec = Vec<char>;
```

The type is very difficult to read:

```rust
							// this return type is extremely long
fn returns<'a>(input: &'a Vec<char>) -> std::iter::Take<std::iter::Skip<std::slice::Iter<'a, char>>> {
    input.iter().skip(4).take(5)
}
```

So you can change it to this:

```rust
type SkipFourTakeFive<'a> = std::iter::Take<std::iter::Skip<std::slice::Iter<'a, char>>>;

fn returns<'a>(input: &'a Vec<char>) -> SkipFourTakeFive {
    input.iter().skip(4).take(5)
}
```

Of course, you can also import items to make the type shorter:

```rust
use std::iter::{Take, Skip};
use std::slice::Iter;

fn returns<'a>(input: &'a Vec<char>) -> Take<Skip<Iter<'a, char>>> {
    input.iter().skip(4).take(5)
}
```

So you can decide what looks best in your code depending on what you like.

Note that this doesn't create a new type. If you write ```type File = String;```, the compiler just sees a ```String```. So this will print ```true```:

```rust
type File = String;

fn main() {
    let my_file = File::from("I am file contents");
    let my_string = String::from("I am file contents");
    println!("{}", my_file == my_string);
}
```

If you want a new file type that the compiler sees as a ```File```, you can put it in a struct:

```rust
struct File(String); // File is a wrapper around String

fn main() {
    let my_file = File(String::from("I am file contents"));
    let my_string = String::from("I am file contents");
}
```

Now this will not work, because they are two different types:

```rust
println!("{}", my_file == my_string); // cannot compare File with String
```

If you want to compare the String inside, you can use my_file.0: 

```rust
struct File(String);

fn main() {
    let my_file = File(String::from("I am file contents"));
    let my_string = String::from("I am file contents");
    println!("{}", my_file.0 == my_string); // my_file.0 is a String, so this prints true
}
```

## Importing inside a function

Usually you write ```use``` at the top of the program, like this:

```rust
use std::cell::{Cell, RefCell};
```

But you can do this anywhere. Sometimes you see this in functions with enums with long names. Here is an example.

```rust
enum MapDirection {
    North,
    NorthEast,
    East,
    SouthEast,
    South,
    SouthWest,
    West,
    NorthWest,
}

fn main() {

}

fn give_direction(direction: &MapDirection) {
    match direction {
        MapDirection::North => println!("You are heading north."),
        MapDirection::NorthEast => println!("You are heading northeast."),
        // So much more left to type...
    }
}
```

So now we will import MapDirection inside the function. That means that inside the function you can just write ```North``` and so on.

```rust
enum MapDirection {
    North,
    NorthEast,
    East,
    SouthEast,
    South,
    SouthWest,
    West,
    NorthWest,
}

fn main() {

}

fn give_direction(direction: &MapDirection) {
    use MapDirection::*; // Import everything in MapDirection
    let m = "You are heading";
    
    match direction {
        North => println!("{} north.", m),
        NorthEast => println!("{} northeast.", m),
        // This is a bit better
    }
}
```

You can also use ```as``` to change the name. For example, maybe you are using someone else's code and you can't change the names in an enum:

```rust
enum FileState {
    CannotAccessFile,
    FileOpenedAndReady,
    NoSuchFileExists,
    SimilarFileNameInNextDirectory,
}
```

So then you can 1) import everything and 2) change the names:

```rust
enum FileState {
    CannotAccessFile,
    FileOpenedAndReady,
    NoSuchFileExists,
    SimilarFileNameInNextDirectory,
}

fn give_filestate(input: &FileState) {
    use FileState::{
        CannotAccessFile as NoAccess, 
        FileOpenedAndReady as Good, 
        NoSuchFileExists as NoFile, 
        SimilarFileNameInNextDirectory as OtherDirectory
    };
    match input {
        NoAccess => println!("Can't access file."),
        Good => println!("Here is your file"),
        NoFile => println!("Sorry, there is no file by that name."),
        OtherDirectory => println!("Please check the other directory."),
    }
}
```

So now you can write ```OtherDirectory``` instead of ```FileState::SimilarFileNameInNextDirectory```.


# The todo! macro

Sometimes you want to write code in general to help you imagine your project. For example, imagine a simple project to do something with books. Here's what you think as you write it:

```rust
struct Book {} // Okay, first I need a book struct.
               // Nothing in there yet - will add later

enum BookType { // A book can be hardcover or softcover, so add an enum
    HardCover,
    SoftCover,
}

fn get_book(book: &Book) -> Option<String> {} // get_book should take a &Book and return an Option<String>

fn delete_book(book: Book) -> Result<(), String> {} // delete_book should take a Book and return a Result...
                                                    // TODO: impl block and make these functions methods...
fn check_book_type(book_type: &BookType) { // Let's make sure the match statement works
    match book_type {
        BookType::HardCover => println!("It's hardcover"),
        BookType::SoftCover => println!("It's softcover"),
    }
}

fn main() {
    let book_type = BookType::HardCover;
    check_book_type(&book_type); // Okay, let's check this function!
}
```

But Rust is not happy with ```get_book``` and ```delete_book```. It says:

```
error[E0308]: mismatched types
  --> src\main.rs:32:29
   |
32 | fn get_book(book: &Book) -> Option<String> {}
   |    --------                 ^^^^^^^^^^^^^^ expected enum `std::option::Option`, found `()`
   |    |
   |    implicitly returns `()` as its body has no tail or `return` expression
   |
   = note:   expected enum `std::option::Option<std::string::String>`
           found unit type `()`

error[E0308]: mismatched types
  --> src\main.rs:34:31
   |
34 | fn delete_book(book: Book) -> Result<(), String> {}
   |    -----------                ^^^^^^^^^^^^^^^^^^ expected enum `std::result::Result`, found `()`
   |    |
   |    implicitly returns `()` as its body has no tail or `return` expression
   |
   = note:   expected enum `std::result::Result<(), std::string::String>`
           found unit type `()`
```

But you don't care about ```get_book``` and ```delete_book``` right now. This is where you can use ```todo!()```. If you add that to the function, Rust will not complain, and will compile.

```rust
fn get_book(book: &Book) -> Option<String> {
    todo!() // todo means "I will do it later, please be quiet"
}

fn delete_book(book: Book) -> Result<(), String> {
    todo!()
}
```

So now the code compiles and you can see the result of ```check_book_type```: ```It's hardcover```.

If you call a function with ```todo!()``` inside it, it will panic.

Also, ```todo!()``` functions still need real input and output types. If you just write this, it will not compile:

```rust
fn get_book(book: &Book) -> WorldsBestType {
    todo!()
}
```

It will say:

```
error[E0412]: cannot find type `WorldsBestType` in this scope
  --> src\main.rs:32:29
   |
32 | fn get_book(book: &Book) -> WorldsBestType {
   |                             ^^^^^^^^^^^^^^ not found in this scope
```

```todo!()``` is actually the same as another macro: ```unimplemented!()```. Programmers were using ```unimplemented()``` a lot but it was long to type, so they created ```todo!()``` which is shorter.

# Rc

Rc means "reference counter". You know that in Rust, every variable can only have one owner. That is why this doesn't work:

```rust
fn main() {
    let user_name = String::from("User MacUserson");

    takes_a_string(user_name);
    also_takes_a_string(user_name);
    
}

fn takes_a_string(input: String) {
    println!("It is: {}", input)
}

fn also_takes_a_string(input: String) {
    println!("It is: {}", input)
}
```

After ```takes_a_string``` takes ```user_name```, you can't use it anymore. Here that is no problem: you can just give it ```user_name.clone()```. But sometimes a variable is part of a struct, and maybe you can't clone the struct. Or maybe the String is really long and you don't want to clone it. These are some reasons for ```Rc```, which lets you have more than one owner. An ```Rc``` is like a good office worker: ```Rc``` writes down who has ownership, and how many. Then once the number of owners goes down to 0, the variable can disappear.

Here's how you use an ```Rc```. First imagine two structs: one called ```City```, and another called ```Cities```. ```City``` has information for one city, and ```Cities``` puts all the cities together in ```Vec```s.

```rust
#[derive(Debug)]
struct City {
    name: String,
    population: u32,
    city_history: String,
}

#[derive(Debug)]
struct Cities {
    names: Vec<String>,
    histories: Vec<String>,
}

fn main() {
    let calgary = City {
        name: "Seoul".to_string(),
        population: 1_200_000,
           // Pretend that this string is very very long
        city_history: "Calgary began as a fort called Fort Calgary that...".to_string(),
    };

    let canada_cities = CityData {
        names: vec![calgary.name], // This is using calgary.name, which is short
        histories: vec![calgary.city_history], // But this String is very long
    };

    println!("Calgary's history is: {}", calgary.city_history);
    
}
```

Of course, it doesn't work because ```canada_cities``` now owns the data and ```calgary``` doesn't. We can clone the name: ```names: vec![calgary.name.clone()]``` but we don't want to clone the ```city_history```, which is long. So we can use an ```Rc```.

Add the ```use``` declaration:

```rust
use std::rc::Rc;
```

Then put ```Rc``` around ```String```.

```rust
#[derive(Debug)]
struct City {
    name: String,
    population: u32,
    city_history: Rc<String>,
}

#[derive(Debug)]
struct Cities {
    names: Vec<String>,
    histories: <Vec<Rc<<String>>>,
}
```

To add a new reference, you have to ```clone``` the ```Rc```. You can clone an item with ```item.clone()``` or with ```Rc::clone(&item)```.

Now our code looks like this:

```rust
use std::rc::Rc;

#[derive(Debug)]
struct City {
    name: String,
    population: u32,
    city_history: Rc<String>, // String inside an Rc
}

#[derive(Debug)]
struct CityData {
    names: Vec<String>,
    histories: Vec<Rc<String>>, // A Vec of Strings inside Rcs
}

fn main() {
    let calgary = City {
        name: "Seoul".to_string(),
        population: 1_200_000,
           // Pretend that this string is very very long
        city_history: Rc::new("Calgary began as a fort called Fort Calgary that...".to_string()), // Rc::new() to make the Rc
    };

    let canada_cities = CityData {
        names: vec![calgary.name],
        histories: vec![calgary.city_history.clone()], // .clone() to increase the count
    };

    println!("Calgary's history is: {}", calgary.city_history);
    
}
```

So calgary.city_history has 2 owners. We can check the number of owners with ```Rc::strong_count(&item)```. Add this:

```rust
println!("{}", Rc::strong_count(&calgary.city_history));
```

This prints ```2```.

Let's add a new owner:

```rust
let new_owner = calgary.city_history.clone();
```

```new_owner``` is now an ```Rc<String>```. Now if we use ```println!("{}", Rc::strong_count(&calgary.city_history));```, we get ```3```.

So if there are strong pointers, are there weak pointers? Yes, there are. Weak pointers are useful because if two Rcs point at each other, they can't die. This is called a "reference cycle". If item 1 has an Rc to item 2, and item 2 has an Rc to item 1, they can't get to 0. In this case you want to use weak references. ```Rc``` will count the references, but if it only has weak references then it can die. You use ```Rc::downgrade(&item)``` instead of ```Rc::clone(&item)``` to make weak references. Also, you use ```Rc::weak_count(&item)``` to see the weak count.

# Multiple threads

If you use multiple threads, you can do many things at the same time. Rust uses threads that are called "OS threads". OS thread means the operating system creates the thread on a different core.

You create threads with ```std::thread::spawn``` and then a closure to tell it what to do. Threads are interesting because they run at the same time. Here is a simple example:

```rust
fn main() {
    std::thread::spawn(|| {
        println!("I am printing something");
    });
}
```

If you run this, it will be different every time. Sometimes it will print, and sometimes it won't print. That is because sometimes ```main()``` finishes before the thread finishes. And when ```main()``` finishes, the program is over. This is easier to see in a ```for``` loop:

```rust
fn main() {
    for _ in 0..10 { // set up ten threads
    std::thread::spawn(|| {
        println!("I am printing something");
    });
	// Now the threads start.
}
}       // How many can finish before main() ends here?
```

Usually about four threads will print before ```main``` ends, but it is always different. Also, sometimes the threads will panic:

```rust
thread 'thread 'I am printing something
thread '<unnamed><unnamed>thread '' panicked at '<unnamed>I am printing something
' panicked at 'thread '<unnamed>cannot access stdout during shutdown' panicked at '<unnamed>thread 'cannot access stdout during 
shutdown
```

This is the error when the thread tries to do something right when the program is shutting down.

You can give the computer something to do so it won't shut down right away:

```rust
fn main() {
    for _ in 0..10 {
    std::thread::spawn(|| {
        println!("I am printing something");
    });
    for i in 0..1_000_000 { // make the program declare "let x = 9" one million times
        let x = 9;
    }
}
```

But that is a silly way to give the threads time to finish. The better way is to bind the threads to a variable. If you add ```let```, then you will create a ```JoinHandle```.

```rust
fn main() {
    for _ in 0..10 {
        let handle = std::thread::spawn(|| {
            println!("I am printing something");
        });

    }
}
```

```handle``` is now a ```JoinHandle```, and it has the method ```.join()```. This method means "wait until all the threads are done" (it waits for the threads to join it). So now just write ```handle.join()``` and it will wait for all ten threads to finish.

```rust
fn main() {
    for _ in 0..10 {
        let handle = std::thread::spawn(|| {
            println!("I am printing something");
        });

        handle.join(); // Wait for the threads to finish
    }
}
```

Now we will learn about the three types of closures. The three types are:

* FnOnce: takes the whole value
* FnMut: takes a mutable reference
* Fn: takes a regular reference

A closure will try to use ```Fn``` if it can. But if it needs to mutate the value, it will use ```FnMut```. And if it needs to take the whole value, it will use ```FnOnce```. FnOnce is a good name because it explains what it does: it takes the value once, and then it can't take it again.

Here is an example:

```rust
fn main() {

    let my_string = String::from("I will go into the closure");
    let my_closure = || println!("{}", my_string);
    my_closure();
    my_closure();
}
```

String is not Copy, so my_closure() is Fn: it takes a reference.

If we change ```my_string```, it will be ```FnMut```.


```rust
fn main() {

    let mut my_string = String::from("I will go into the closure");
    let mut my_closure = || { 
        my_string.push_str(" now");
        println!("{}", my_string);
    };
    my_closure();
    my_closure();
```

This prints:

```
I will go into the closure now
I will go into the closure now now
```

And if you take by value, then it will be FnOnce.

```rust
fn main() {

    let my_vec: Vec<i32> = vec![8, 9, 10];
    let my_closure = || { 
        my_vec
            .into_iter() // into_iter takes ownership
            .map(|x| x as u8) // turn it into u8
            .map(|x| x * 2) // multiply by 2
            .collect::<Vec<u8>>() // collect into a Vec
    };
    let new_vec = my_closure();
    println!("{:?}", new_vec);
}
```

We took by value, so we can't run ```my_closure()``` more than once. That is where the name comes from.

So now back to threads. Let's try to use a value from outside:

```rust
fn main() {
    let mut my_string = String::from("Can I go inside the thread?");

    let handle = std::thread::spawn(|| {
        println!("{}", my_string);
    });

    handle.join();
}
```

The compiler says that this won't work.

```
error[E0373]: closure may outlive the current function, but it borrows `my_string`, which is owned by the current function      
  --> src\main.rs:28:37
   |
28 |     let handle = std::thread::spawn(|| {
   |                                     ^^ may outlive borrowed value `my_string`
29 |         println!("{}", my_string);
   |                        --------- `my_string` is borrowed here
   |
note: function requires argument type to outlive `'static`
  --> src\main.rs:28:18
   |
28 |       let handle = std::thread::spawn(|| {
   |  __________________^
29 | |         println!("{}", my_string);
30 | |     });
   | |______^
help: to force the closure to take ownership of `my_string` (and any other referenced variables), use the `move` keyword
   |
28 |     let handle = std::thread::spawn(move || {
   |                                     ^^^^^^^
```

It is a long message, but helpful: it says to ```use the `move` keyword```. The problem is that we can do anything to ```my_string``` while the thread is using it. That would be unsafe.

```rust
fn main() {
    let mut my_string = String::from("Can I go inside the thread?");

    let handle = std::thread::spawn(|| {
        println!("{}", my_string); // now my_string is being used as a reference
    });

    std::mem::drop(my_string); // Maybe we drop it. But the thread still needs it

    handle.join();
}
```

So you have to take the value with ```move```. Now it is safe:

```rust
fn main() {
    let mut my_string = String::from("Can I go inside the thread?");

    let handle = std::thread::spawn(move|| {
        println!("{}", my_string);
    });

    std::mem::drop(my_string); // we can't drop, because handle has it. So this won't work

    handle.join();
}
```

So we delete the ```std::mem::drop```, and now it is okay. ```handle``` takes ```my_string``` and our code is safe.

```rust
fn main() {
    let mut my_string = String::from("Can I go inside the thread?");

    let handle = std::thread::spawn(move|| {
        println!("{}", my_string);
    });

    handle.join();
}
```

So just remember: if you need a value in a thread from outside the thread, you need to use ```move```.

# Arc

You remember that we used an ```Rc``` to give a variable more than one owner. If we are doing the same thing in a thread, we need an ```Arc```. ```Arc``` means "atomic reference counter". Atomic means that it uses the computer's processor so that data only gets written once each time. This is important because if two threads write data at the same time, you will get the wrong result. For example, imagine if you could do this in Rust:

```rust
    let mut x = 10;

    for i in 0..10 { // Thread 1
        x += 1
    }
    for i in 0..10 { // Thread 2
        x += 1
    }
```

If Thread 1 and Thread 2 just start together, maybe this will happen:

* Thread 1 sees 10, writes 11. Then Thread 2 sees 11, writes 12. No problem so far.
* Thread 1 sees 12. At the same time, Thread 2 sees 12. Thread 1 writes 13. And Thread 2 writes 13. Now we have 13, but it should be 14.

An ```Arc``` uses the processor to make sure this doesn't happen, so it is the method you must use when you have threads. You don't want an ```Arc``` for just one thread though, because ```Rc``` is a bit faster.

You can't change data with just an ```Arc``` though. So you wrap the data in a ```Mutex```, and then you wrap the ```Mutex``` in an ```Arc```.

So let's use a ```Mutex``` inside an ```Arc``` to change the value of a number. First let's set up one thread:

```rust
fn main() {
    let my_number = 0;

    let handle = std::thread::spawn(|| {
        println!("The thread is working!") // Just testing the thread
    });

    handle.join().unwrap(); // Make the threads wait here until they are done
    println!("Exiting the program");
}
```

Good. Now let's put it in a ```for``` loop for 0..10:

```rust
fn main() {
    let my_number = 0;

    let handle = std::thread::spawn(|| {
        for _ in 0..10 {
            println!("The thread is working!")
        }
    });

    handle.join().unwrap();
    println!("Exiting the program");
}
```

Now let's make one more thread. Each thread 

```rust
fn main() {
    let my_number = 0;

    let thread1 = std::thread::spawn(|| {
        for _ in 0..10 {
            println!("Thread 1 is working!")
        }
    });

    let thread2 = std::thread::spawn(|| {
        for _ in 0..10 {
            println!("Thread 2 is working!")
        }
    });

    thread1.join().unwrap();
    thread2.join().unwrap();
    println!("Exiting the program");
}
```

Now we want to change the value of ```my_number```. Right now it is an ```i32```. We will change it to an ```Arc<Mutex<i32>>```: an ```i32``` that can be changed, protected by an ```Arc```.

```rust
let my_number = Arc::new(Mutex::new(0));
```

Now that we have this, we can clone it. Each clone can go into a different thread. We have two threads, so we will make two clones:

```rust
    let my_number = Arc::new(Mutex::new(0));

    let my_number1 = Arc::clone(&my_number); // This clone goes into Thread 1
    let my_number2 = Arc::clone(&my_number); // This clone goes into Thread 2
```

Now that we have safe clones attached to ```my_number```, we can ```move``` them into other threads with no problem.

```rust
use std::sync::{Arc, Mutex};

fn main() {
    let my_number = Arc::new(Mutex::new(0));

    let my_number1 = Arc::clone(&my_number);
    let my_number2 = Arc::clone(&my_number);

    let thread1 = std::thread::spawn(move || { // Only the clone goes into Thread 1
        for _ in 0..10 {
            *my_number1.lock().unwrap() +=1; // Lock the Mutex, change the value
        }
    });

    let thread2 = std::thread::spawn(move || { // Only the clone goes into Thread 2
        for _ in 0..10 {
            *my_number2.lock().unwrap() += 1;
        }
    });

    thread1.join().unwrap();
    thread2.join().unwrap();
    println!("Value is: {:?}", my_number);
    println!("Exiting the program");
}
```

The program prints:

```
Value is: Mutex { data: 20 }
Exiting the program
```

So it was a success.

Then we can join the two threads together in a single ```for``` loop, and make the code smaller.

```rust
use std::sync::{Arc, Mutex};

fn main() {
    let my_number = Arc::new(Mutex::new(0));

    for _ in 0..2 { // do this twice
        let my_number_clone = Arc::clone(&my_number); // Make the clone before starting the thread
        let handle = std::thread::spawn(move || {
            for _ in 0..10 {
                *my_number_clone.lock().unwrap() += 1;
            }
        });
        handle.join().unwrap(); // wait here
    }

    println!("{:?}", my_number);
}
```

This looks complicated but ```Arc<Mutex>>``` is used very often in Rust, so it becomes natural. Also, you can always write your code to make it cleaner. Here is the same code with one more ```use``` statement and two functions. The functions don't do anything new, but they move some code out of ```main()```. You can try rewriting code like this if it is hard to read.

```rust
use std::sync::{Arc, Mutex};
use std::thread::spawn; // Now we just write spawn

fn make_arc(number: i32) -> Arc<Mutex<i32>> { // Just a function to make a Mutex in an Arc
    Arc::new(Mutex::new(number))
}

fn new_clone(input: &Arc<Mutex<i32>>) -> Arc<Mutex<i32>> { // Just a function so we can write new_clone
    Arc::clone(&input)
}

// Now main() is easier to read

fn main() {
    let my_number = make_arc(0);

    for _ in 0..2 {
        let my_number_clone = new_clone(&my_number);
        let handle = spawn(move || {
            for _ in 0..10 {
                let mut value_inside = my_number_clone.lock().unwrap(); // Give the MutexGuard to a variable so it's clear
                *value_inside += 1;  // Now it is clear that the value inside is changing
            }
        });
        handle.join().unwrap();
    }

    println!("{:?}", my_number);
}
```

You can also make a vector of handles, and use ```.join().unwrap()``` on them. Then you can do what you want with each handle inside. Here is ```main()``` with the handles in a vector:

```rust
fn main() {
    let mut handle_vec = vec![]; // each handle will go in here
    let my_number = make_arc(0);

    for _ in 0..2 {
        let my_number_clone = new_clone(&my_number);
        let handle = spawn(move || {
            for _ in 0..10 {
                let mut value_inside = my_number_clone.lock().unwrap();
                *value_inside += 1;
            }
        });
        handle_vec.push(handle);    // the handle is done, so put it in the vector
    }

    handle_vec.into_iter().for_each(|handle| handle.join().unwrap()); // Make each one wait

    println!("{:?}", my_number);
}
```

# Channels

A channel is an easy way to use many threads that send to one place. You can create a channel in Rust with ```std::sync::mpsc```. ```mpsc``` means "multiple producer, single consumer", so "many threads sending to one place". To start a channel, you use ```channel()```. This creates a ```Sender``` and a ```Receiver``` that are tied together. You can see this in the function signature:

```rust
pub fn channel<T>() -> (Sender<T>, Receiver<T>)
```

So you have to choose one name for the sender and one for the receiver. Usually you see ```let (sender, receiver) = channel();``` to start. Because it's generic, Rust won't know the type if that is all you write:

```rust
use std::sync::mpsc::channel;

fn main() {
    let (sender, receiver) = channel();
}
```

The compiler says:

```
error[E0282]: type annotations needed for `(std::sync::mpsc::Sender<T>, std::sync::mpsc::Receiver<T>)`
  --> src\main.rs:30:30
   |
30 |     let (sender, receiver) = channel();
   |         ------------------   ^^^^^^^ cannot infer type for type parameter `T` declared on the function `channel`
   |         |
   |         consider giving this pattern the explicit type `(std::sync::mpsc::Sender<T>, std::sync::mpsc::Receiver<T>)`, where 
the type parameter `T` is specified
```

It suggests adding a type for the ```Sender``` and ```Receiver```. You can do that if you want:

```rust
use std::sync::mpsc::{channel, Sender, Receiver}; // Added Sender and Receiver here

fn main() {
    let (sender, receiver): (Sender<i32>, Receiver<i32>) = channel();
}
```

but you don't have to. Once you start using the ```Sender``` and ```Receiver```, Rust can guess the type.

So let's look at the simplest way to use a channel.

```rust
use std::sync::mpsc::channel;

fn main() {
    let (sender, receiver) = channel();

    sender.send(5);
    receiver.recv();

}
```

Now the compiler knows the type. ```sender``` is a ```Result<(), SendError<i32>>``` and ```receiver``` is a ```Result<i32, RecvError```. So you can use ```unwrap``` to see if the sending works, or use better error handling. Let's add ```.unwrap()``` and also ```println!``` to see what we get:

```rust
use std::sync::mpsc::channel;

fn main() {
    let (sender, receiver) = channel();

    sender.send(5).unwrap();
    println!("{}", receiver.recv().unwrap());

}
```

This prints ```5```.

A ```channel``` is like an ```Arc``` because you can clone it and send the clones into other threads. Let's make two threads and send values to ```receiver```. This code will work, but it is not exactly what we want.

```rust
use std::sync::mpsc::channel;

fn main() {
    let (sender, receiver) = channel();
    let sender_clone = sender.clone();
    
    std::thread::spawn(move|| { // move sender in
        sender.send("Send a &str this time").unwrap();
    });

    std::thread::spawn(move|| { // move sender_clone in
        sender_clone.send("And here is another &str");
    });

    println!("{}", receiver.recv().unwrap());

}
```

The two threads start sending, and then we ```println!```. Sometimes it will say ```Send a &str this time``` and sometimes it will say ```And here is another &str```. Let's make a join handle to make them wait.

```rust
use std::sync::mpsc::channel;

fn main() {
    let (sender, receiver) = channel();
    let sender_clone = sender.clone();
    let mut handle_vec = vec![]; // Put our handles in here
    
    handle_vec.push(std::thread::spawn(move|| {  // push this into the vec
        sender.send("Send a &str this time").unwrap();
    }));

    handle_vec.push(std::thread::spawn(move|| {  // and push this into the vec
        sender_clone.send("And here is another &str").unwrap();
    }));

    for _ in handle_vec { // now handle_vec has 2 items. Let's print them
        println!("{:?}", receiver.recv().unwrap());
    }
}
```

This prints:

```
"Send a &str this time"
"And here is another &str"
```

Now let's make a ```results_vec``` instead of printing.

```rust
use std::sync::mpsc::channel;

fn main() {
    let (sender, receiver) = channel();
    let sender_clone = sender.clone();
    let mut handle_vec = vec![];
    let mut results_vec = vec![];
    
    handle_vec.push(std::thread::spawn(move|| {
        sender.send("Send a &str this time").unwrap();
    }));

    handle_vec.push(std::thread::spawn(move|| {
        sender_clone.send("And here is another &str").unwrap();
    }));

    for _ in handle_vec { 
        results_vec.push(receiver.recv().unwrap());
    }

    println!("{:?}", results_vec);
}
```

Now the results are in our vec: ```["Send a &str this time", "And here is another &str"]```.

Now let's pretend that we have a lot of work to do, and want to use threads. We have a big vec with 10,000 items, all 0. We want to change each 0 to a 1. We will use ten threads, and each thread will do one tenth of the work. We will create a new vec and use ```.extend()``` to put the work in.

```rust
use std::sync::mpsc::channel;

fn main() {
    let (sender, receiver) = channel();
    let hugevec = vec![0; 1000];
    let mut newvec = vec![];

    for i in 0..10 {
        let sender_clone = sender.clone();
        let mut work: Vec<u8> = Vec::with_capacity(hugevec.len() / 10); // new vec to put the work in. 1/10th the size
        work.extend(&hugevec[i*100..(i+1)*100]); // first part gets 0..100, next gets 100..200, etc.
        let handle = std::thread::spawn(move || { // make a handle
            
            for number in work.iter_mut() { // do the actual work
                *number += 1;
            };
            sender_clone.send(work).unwrap(); // use the sender_clone to send the work to the receiver
        });

        handle.join().unwrap(); // stop the thread until it's done
        newvec.push(receiver.recv().unwrap()); // push the results from receiver.recv() into the vec
    }

	// Now we have a Vec<Vec<u8>>. To put it together we can use .flatten()
    let newvec = newvec.into_iter().flatten().collect::<Vec<u8>>(); // Now it's one vec of 1000 u8 numbers
}
```

If you print this you can see 1000 number 1s.

# Reading Rust documents

It is important to know how to read documentation in Rust so you can understand what other people wrote. Here are some things to know in Rust documentation:

## assert_eq!

You saw that ```assert_eq!``` is used when doing testing. You put two items inside the function and the program will panic if they are not equal. Here is a simple example where we need an even number.

```rust
fn main() {
    prints_number(56);
}

fn prints_number(input: i32) {
    assert_eq!(input % 2, 0); // number must be equal. 
                              // If number % 2 is not 0, it panics
    println!("The number is not odd. It is {}", input);
}
```

Maybe you don't have any plans to use ```assert_eq!``` in your code, but it is everywhere in Rust documentation. This is because in a document you would need a lot of room to ```println!``` everything. Also, you would require ```Display``` or ```Debug``` for the things you want to print. That's why documentation has ```assert_eq!``` everywhere. Here is an example from here https://doc.rust-lang.org/std/vec/struct.Vec.html showing how to use a Vec:


```rust
let mut vec = Vec::new();
vec.push(1);
vec.push(2);

assert_eq!(vec.len(), 2);
assert_eq!(vec[0], 1);

assert_eq!(vec.pop(), Some(2));
assert_eq!(vec.len(), 1);

vec[0] = 7;
assert_eq!(vec[0], 7);

vec.extend([1, 2, 3].iter().copied());

for x in &vec {
    println!("{}", x);
}
assert_eq!(vec, [7, 1, 2, 3]);
```

In these examples, you can just think of ```assert_eq!(a, b)``` as saying "a is b". Now look at the same example with comments on the right. The comments show what it actually means.

```rust
let mut vec = Vec::new();
vec.push(1);
vec.push(2);

assert_eq!(vec.len(), 2); // The vec length is 2
assert_eq!(vec[0], 1); // vec[0] is 1

assert_eq!(vec.pop(), Some(2)); // When you use .pop(), you get Some()
assert_eq!(vec.len(), 1); // The vec length is now 1

vec[0] = 7;
assert_eq!(vec[0], 7); // Vec[0] is 7

vec.extend([1, 2, 3].iter().copied());

for x in &vec {
    println!("{}", x);
}
assert_eq!(vec, [7, 1, 2, 3]); // The vec now has [7, 1, 2, 3]
```

## Searching

The top bar of a Rust document is the search bar. It shows you results as you type. When you go down a page you can't see the search bar anymore, but if you press ```s``` on the keyboard you can search again. So pressing ```s``` anywhere lets you search right away.

## [src] button

Usually the code for a method, struct, etc. will not be complete. This is because you don't usually need to see the full source to know how it works, and the full code can be confusing. But if you want to know more, you can click on [src] and see everything. For example, on the page for ```String``` you can see this signature:

```rust
pub fn with_capacity(capacity: usize) -> String
```

Okay, so you put a number in and it gives you a ```String```. That's easy, but maybe you are curious. If you click on [src] you can see this:

```rust
    pub fn with_capacity(capacity: usize) -> String {
        String { vec: Vec::with_capacity(capacity) }
    }
```

Interesting! Now you can see that a String is a kind of ```Vec```. And actually a ```String``` is a vector of ```u8``` bytes, which is interesting to know. But you don't need to know that to use the ```with_capacity``` method so you only see it if you click [src]. So clicking on [src] is a good idea if the document doesn't have much detail and you want to know more.
