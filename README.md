# Introduction

Rust is a new language, but already has many textbooks. Many textbooks for Rust have a friendly feel, but Rust needs a textbook written in simple English. A textbook for Rust in simple English will make it easier for more people to learn Rust.

# Rust Playground

If you don't want to install yet, https://play.rust-lang.org/ is the best place to start writing Rust. You can write your code and click Run to see the results fast.

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

## # Chars

A ```char``` is one character. For a ```char```, use ```''``` instead of ```""```.

All chars are 4 bytes. They are 4 bytes because some characters in a string are more than one byte. For example:

```rust
fn main() {
    let slice = "Hello!";
    println!("Slice is {:?} bytes.", std::mem::size_of_val(slice));
    let slice2 = "안녕!"; // Korean for "hi"
    println!("Slice2 is {:?} bytes.", std::mem::size_of_val(slice2));
}
```

```slice``` is six characters in length and six bytes, but ```slice2``` is three characters in length and seven bytes. ```char``` needs to fit any character in any language, so it is 4 bytes long.


 
# Type inference

Type inference means that if you don't tell the compiler the type, but it can decide by itself, it will decide. The compiler always needs to know the type of the variables, but you don’t always need to tell it. For example, for ```let my_number = 8```, ```my_number``` will be an ```i32``` (the compiler chooses i32 for integers if you don't tell it). But if you say ```let my_number: u8 = 8```, it will make ```my_number``` a ```u8```, because you told it ```u8```.

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

But the types are not called ```float```, they are called ```f32``` and ```f64```. It is the same as integers: the number after ```f``` shows the number of bits. If you don't write the type, Rust will choose ```f64```.

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

A pointer in Rust is usually called a **reference**. A reference means you *borrow* the value, but you don't own it. In Rust, references have a ```&```. So ```let my_variable = 8``` makes a regular variable, but ```let my_reference = &my_variable``` makes a reference. This means that ```my_reference``` is only looking at the data of ```my_variable```. ```my_variable``` still owns its data.

## More about printing

We know that ```println!``` can print with ```{}``` (for Display) and ```{:?}``` (for Debug), plus ```{:#?}``` for pretty printing. But there are many other ways to print.

For example, if you have a reference, you can use {:p} to print the pointer address.

```ref
fn main() {
    let number = 9;
    let number_ref = &number;
    println!("{:p}", number_ref);
}
```
This prints ```0xe2bc0ffcfc``` or some other address (it can be different every time).

Or you can print binary, hexadecimal and octal:

```ref
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

```ref
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

```ref
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

```ref
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

* 1) fn function_name(variable: String) takes a ```String``` and owns it. If it doesn't return anything, then the variable dies after the function is done.
* 2) fn function_name(variable: &String) borrows a ```String``` and can look at it
* 3) fn function_name(variable: &mut String) borrows a ```String``` and can change it

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


# Collection types

Here are some types for making a collection.

## Arrays

An array is data inside square brackets: ```[]```. Arrays:

* must not change their size,
* must only contain the same type.

They are very fast, however.

The type of an array is: ```[type; number]```. For example, the type of ["One", "Two"] is [&std; 2]. This means that even these two arrays have different types:

```rust
let array1 = ["One", "Two"];
let array["One", "Two", "Five"];
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

The type is ```Vec<i32>```.
