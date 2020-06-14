# C++

<https://code.visualstudio.com/docs/cpp/config-linux>

## How C++ Works

<https://youtu.be/SfGuIVzE_Os>

Compiler from text to binary or executable program.

```c++
#include <iostream>

int main()
{
  std::cout << "Hello World!" << std::endl;
  std:: cin.get();
}
```

Everything that starts with `#` is a preprocessor statement. The first thing that compiler does it run preprocessor.

In the case of `#include` it finds a file take all of the contents and paste in the file. We include `iostream` because we need declarations for `cout` and `cin`.

`main` is the entry point. Program starts executing by calling this function. Return type is `int`. If you don't return anything for `main` it is assumed `0`.

Program gets executed line by line.

`<<` is an overloaded operator. Think of them as functions, operators are just functions.

Preprocessor statement gets evaluated before the file is compiled.

Each `.cpp` file gets compiled. Header files don't get compiled, they only get included into `.cpp`. Every `.cpp` gets compiled individually into object files `.obj` or `.o`. Linker takes all object files and links them together into one executable file.

Compiler doesn't resolve where the function is, it only needs a declaration that a certain function exists. Declaration parameters don't need a name. Once the files are compiled the linker will find the definition of a function and wired it up where it's called. If linker cannot find a definition that's a linker error. Definition is a body of a function.

```sh
g++ Main.cpp -o Main.o -c
g++ Log.cpp -o Log.o -c
g++ -o Main Main.o Log.o
```

Individually compile `.cpp` files with `g++` compiler use `-c` to compile without linking. The last line links individual object files into `Main`.

## How the C++ Compiler Works

From text form to an executable binary two operations need to happen: compiling and linking.

Compiler takes a text file as an input and converts it into an intermediate format called an object file. The object file is then passed to linker.

Compiler does several things when it produces the object files: preprocess files, tokenizing and parsing. This results in a AST (Abstract Syntax Tree) representation of the code as a tree structure. The compiler's job is to convert all of the code into either a constant data or instructions. Once compiler creates AST it then generates machine code that CPU will execute.

Cpp files are called translation units. Every `.cpp` file will resolve as an object file. C++ doesn't care about files. Files don't exist in C++.

It's common to iclude `.cpp` files into `.cpp` files and once compiled they resolve into one object file and that's why the term translation unit exists.

During the pre-processing phase compiler will go through all of the pre-processing statements and evaluate them. Commonly used: include, define, if, ifdef. `#include` copy and pastes content of a file where the statement is found.

Compiler optimization.

## How the C++ Linker Works

Once we compile files we need to link them. Primary focus of linking is to find where each symbol and function is and link them together. Compiled object files have no relation between them. The app needs to know where the entry point (main function) is.

If there is no entry point defined, compiling a file without main function will succeed, but linking will fail. Syntax error e.g. `C2143` means it comes from the compiler, `LNK1561` is the linker error occured. Entry point doesn't have to be the `main` function.

If a declared function is not called, then linker would not have to link it and so even if the definition doesn't exist the compilation and linking will be successful.

```c++
void Log(const char *message);

static int Multiply(int a, int b)
{
  Log("Multiply");
  return a * b;
}
```

When a function is static (only available for the current translation unit) the linker will succeed even in the case that `Log` function is not defined if `Multiply` is never called. If it was _public_ then the linker would error.

If declaration and definition signatures don't match(different types for example) linker will error.

Compiler will error if there are duplicate symbols in the same translation unit, e.g. two definitions of functions with the same signature. If the same functions exist in the different translation units, compilation will succeed, but linking will error.

Header file `#pragma once` non-standard and widely supported preprocessor directive designed to cause the current source file to be included only once in a single compilation.

If function is defined in a header file and it's included in two different `.cpp` files the linker will error: already defined, one or more multiply defined symbols. This is related to how the include statement works, it copies and pastes the content of a file. Way to fix is: 1. `static` function when it gets included is internal to a `.cpp` file, so two files will have a different versions of the same function; 2. `inline` means it takes the function body and replaces a call to function with its definition; 3. have one translation unit where the function is defined, e.g. `Log.cpp`.

Recap: linker takes all the object files generated during compilation and links them together and it will also pull the libraries.

There are two types of linking: static and dynamic.

## Using Libraries in C++ (Static Linking)

Can link against a binary or source code. Keep source code in a solutions directory. Having source code of a library allows debugging. 32 vs 64 bit precompiled binaries are not dependent on the running Windows OS but the target binary. Two parts to a library usually: includes and libraries (lib). Include directory is a bunch of header files and lib has prebuilt binaries. There are usually dynamic and static libraries. Choose to link statically or dynamically. Static linking means the library gets put into the executable. Dynamic libraries get linked at runtime. At the application launch it loads `.dll` or `.so` files.

## Using Dynamic Libraries in C++

Dynamic linking is linking that happens at runtime and static at compile time. With static a lot of optimization can be done. When you launch executable that's when your dynamic linked libary gets loaded. It requires a certain libraries to be present to even run the application. Two versions: "static" dynamic that application requires it to be present and it's already aware what functions exist, there's also arbitrarily load libraries.

## Variables in C++

Variable is stored in memory: stack or heap. In C++ we're given the primitive data types. The only difference between different data types is really the size. How much memory does a variable occupy. `int` is data type 4 bytes in sizetraditionally, depends on the compilerConditions . This is a signed int meaning it can store negative values between ~(-2) billion to ~(+2) billion. `int` is 2^32, 1 bit is for the sign. 31 bits for value 1 for sign. Unsigned `unsigned int` have values in range from 0 - 2^32-1. Other types: char (1 byte), short (2 bytes), int (4 bytes), long (4 bytes of data usually, depends on a compiler), long long (8 bytes of data), long int etc. Can add usigned to any of this. `char` is used for storing characters not just numbers. `char a = 50` or `char a = 'A'`. For decimal numbers there are two types: `float` (4 bytes) and `double` (8 bytes). `float n = 5.5` here 5.5 is double, with `5.5f` we have float. `bool` can be true or false. 0 is false, anything elese means true. Bool occupies 1 byte even though it needs only one bit. There is no way to address individual bits in memory. We can only access bytes. Trick is to store 8 bools in one byte. `sizeof(bool)` gives a size of data type in bytes. `bool*` is a pointer, `bool&` is a reference.

## Functions in C++

Functions are blocks of code that are designed to perform a specific task. Those blocks in classes are called methods. Functions avoid code duplication and simplify maintenance. Function have input and output (not neceserally). With certain parameters and can return values.

When a program calls a function it needs to create a stack for the call, push arguments to stack, return address and jump to a different part of the binary to start executing the instructions in a function. This is only if a compiler doesn't decide to inline a function.
Conditions 
Functions typically brake into declaration and definition. Declarations go to header files `.hpp`, definitions to `.cpp`.

## C++ Header Files

Java or C# don't have header files. Header files are used to declare a certain types of functions so that they can be used throughout program. Declarations need to exist to know what types and functions exist. Common place to declare only declarations, not definitions. When anoter translation unit has a function, the other translation unit needs to import a header file with the signature (declaration) of that function, otherwise the compiler will error, it doesn't know about the called function.

```c++
void Log(const char* message);
```

`#include` copies and pastes the contents of a header file and thus function declarations into a `.cpp` file that calls that function.

`#pragma once` preprocessor directive that includes a single header only once in a single translation unit.

Header guards via `#ifndef _LOG_H_` problems: more code, name clashes, slower compilation speed.

Angular brackets to search for include paths, e.g. `#include <iostream>`, with double quotes relative include `#include "../Log"`. Quotes work for everything, e.g. `#include "iostream"`. Quotes first search the current directory and only if a file is not found the include paths.

## How to DEBUG C++

## Conditions and Branches in C++

Evaluate a certain condition and then decide what code to execute as a result of that evaluation. Jump to one or another parts of source code, branch to one section of machine code or another section. All application gets loaded into memory. Condition jumps to a specific part of memory. Conditions have a bit of overhead in terms of perfomance. A lot of optimized code will avoid branching.

```c++
bool comparisonResult = x == 5;
```

`==` is overloaded operator, the function compares memory of x and the number 5. Check primitive types compare bytes of memory.

TRUE is any number other than 0, usually 1, FALSE is always 0. If statement really means: is it not zero: `if (comparisonResult) {...}`.

Learn Assembly! JMP (jump), JE (jump equal).

NULL pointer `nullptr` is 0.

```c++
if (ptr) {
} else if (ptr == "Hello") {
} else {
}
```

Two types of programming: mathematical and logical. Most fast code is math. code. Logical programming is all about logic, this then that.

## Loops in C++

`for` and `while` loops.

```c++
for (int i = 0; i < 5; i++)
{
  std::cout << i << " ";
}
```

`int i = 0` happens first only once, then it immediatlly checks if the expression `i < 5` is true, if it's true it executes the body of for loop, when block ends perform the code `i++` and then it checks `i < 5` again until that expression is false.

`for` loops are simple for running code multiple times and with arrays for going trough linearly.

```c++
while (running)
{

}

```

`while` loop as long as the expression is true `i < 5` the while loop body will execute.

There is no difference between the two loops. It's more of a convention when one is used intead of the other.

There is also:

```c++
do
{

} while (canJump);
```

Executes the body of loop at least once.

## Control Flow in C++

Control flow gives more control as to how the loops run: `continue`, `break` and `return`.

`continue` can only be used inside of a loop. It means go to the next iteration of the loop.

`break` is used loops but also in `switch` statement. It means get out of the loop.

`return` is the most powerful, it can be used anywhere, it gets out of the function entirely and it returns a value.

Basis of the flow: if statements and conditionals, loops and control flow statements.

## Pointers in C++

When you write an app that entire app gets loaded into memory. All instructions and data gets loaded into memory and that's how CPU gets access to you program and starts executing instructions. Pointers are important for managing and manipulating memory.

> Pointer is an integer that stores a memory address.

Memory is just one big block, one line. Pointer is just an address where a byte in memory is. Everything we do in a program will be reading or writing, from and to memory.

Types have nothing to do with pointers. It doesn't matter if its `int` or `Entity` type of pointer. Pointer is still just an integer that contains an address of memory.

`void*` is typeless pointer. If we give type to a pointer that means we presume the type of data at that memory address is of that type.

`void* ptr = 0` is invalid. We cannot read or write to memory address 0.

Use `NULL` that's really a macro `#define NULL 0` for pointers that do not point to anything or a keyword `nullptr` introduced in C++11.

`int var = 8` each variable we create has a memory address. It has to be stored somewhere in memory.

`&var` gives a memory address of a variable, e.g. `void* ptr = &var`

Pointer instead of holding a value, holds a memory address an integer. How big the integer is depends, it could be 16, 32 or 64 bits.

`int* ptr = &var` doesn't change anything.

In order to change a value that pointer points to or just access it we need to dereference a pointer.

`*ptr` stick an asteriks in front of a pointer to access it. We can now read or write a value to it.

If `void* ptr` then `ptr* = 10` is not going to work it doesn't know if address it points to is 2, 4, 8 bytes and that's why we add type to a pointer. We tell the compiler what type pointer points to and later we can assign a value when dereferencing that pointer.

```c++
int var = 8;
int *ptr = &var;
*ptr = 10;
```

this will assign 10 to an address of var effectively replacing 8 with 10.

```c++
char* buffer = new char[8]; // asking for 8 bytes of memory, this allocates 8 bytes of memory and returns a pointer to the beginning of that block of memory
memset(buffer, 0, 8); // fills the block of memory, takes a pointer, value and size (how many bytes to fill)
```

When using `new` keyword data is **heap** allocated and it needs to be released: `delete[] buffer`.

Pointer themselves are just variables and those variables are also stored in memory, so we can get double or triple pointers. Pointer that points to a pointer etc.

Heap objects can outlive the function that they are created in.

## References in C++

References are an extension of pointers. They are pretty much the same thing what computer will do with them. Semantically there are some differences. References are pointers in disguise, or syntax sugar on top of pointers to make it a little bit easier to read and follow.

References are a way to reference an existing variable. Unlike a pointer, where pointers can point to NULL, references MUST reference an already existing variable.

References don't take up a memory, everywhere where a reference is encountered it is replaced with the address of a variable it references, so the reference content address is resolved at compile time and there is no need to dereference is like a pointer at run time.

References to references, array of references and pointers to references are not allowed.

```c++
void incrPtr(int *val)
{
  // *val++; // this will increase the address instead of a value
  (*val)++; // dereferences the pointer first and then increase the value it points to
}
```

```c++
void incrRef(int &val)
{
  val++;
}
```

There is nothing you can do with references that you cannot do with pointers. Pointers are like references but even more powerful.

Using references makes code look cleaner.

Once a reference is declared what it references to cannot be changed.

```c++
int a = 5;
int b = 8;
int& ref = a;
ref = b; // this will not change what ref references, but instead change the value of a(5) to a value of b(8)
```

References cannot change what they reference once created. Pointers can change what they reference (point to).

## Classes in C++

Getting into object oriented programming OOP. Popular way of programming. It's just a style of programming. How you write your code. Java and C# are primarily OOP. C++ is a bit different as it doesn't enforce a style upon you. C for example doesn't support OOP.

Classes are just a way to group data and functionality together.

For example in a game we have a representation of a player. We need data such as position in the world, speed, 3d model that represents a player in 3d world.

```c++
class Player
{
  int x, y;
  int speed;
};

int main()
{
  Player player;
  // player.x; // innacessible due to visibility, it is private by default
```

Variables that are made from class types are called objects. And a new object variable is called an instance.

By default class makes everything private, meaning only the functions inside that class can access those variables.

```c++
class Player
{
public:
  int x, y;
  int speed;
};
```

makes variables below `public:` accessible from outside.

```c++
class Player
{
public:
  int x, y;
  int speed;

  void Move(int xa, int ya)
  {
    x += xa * speed;
    y += ya * speed;
  }
};
```

## Classes vs Structs in C++

`struct` or `class` they appear similar. Except visibility there are NONE other differences. Class is private by default. Structs are public by default.

C++ struct is not like a C struct. In C++ structs can have methods and inheritance, C structs can only have members.

The reason struct even exist in C++ is because of the backwards compatibility with C code.

```c++
#define struct class
```

that's going to replace all structs with classes.

If there's no difference when to you one over the other. It is a style of programming. Use structs when it only represents variables something like vector with x and y variables. It doesn't mean adding methods to structs e.g. adding two vectors. Never use inheritance with structs only with classes.

## How to write a C++ class

```c++
class Log
{
public:
  const int LogLevelError = 0;
  const int LogLevelWarning = 1;
  const int LogLevelInfo = 1;
private:
  int m_LogLevel;
public:
  void SetLevel(int level)
  {
    m_LogLevel = level;
  }

  void Warn(const char* message)
  {
    std::cout << "[WARNING]: " << message << std::endl;
  }
};
```

## Static in C++

The static keyword in C++ has two meanings depending in the context. One is outside a struct or a class and the other one is inside of a struct or class.

Static outside of a class means that the linkage of that static symbol is going to be internal and that means it's only going to be visible to the translation unit where it's defined.

If there is `static int s_Variable = 5` in one file (Static.cpp) there could be another `int s_Varible` defined in another file (Main.cpp) and when linking occurs it will succeed. If `s_Varible` is not static then there would be an error that the symbol is already defined. Non-static symbols can be referenced in other translation units using `extern` keyword.

```c++
// Static.cpp `g++ -o Static.o Static.cpp -c` compile and assemble
int s_Variable = 5;

// Main.cpp `g++ -o Main.o Main.cpp -c` compile and assemble
#include <iostream>

extern int s_Variable;

int main()
{
  std::cout << s_Variable << std::endl;
  return 0;
}

// Main `g++ -o Main Static.o Main.o` link
```

Static inside of a struct or a class means that variable is going to share memory with all of the instances of a class. There is only going to be one instance of that static variable. The same applies to the static methods of a class.

## Static for Classess and Structs in C++

Static variable in a struct or class means there is only one instance of that variable. If one instance changes the variable it's going to reflect that change to all variables.

Static methods can be called without class instance and they don't have access to a class instance (variable members).

```cpp
#include <iostream>

struct Entity
{
  static int x, y;

  static void Print()
  {
    std::cout << x << ", " << y << std::endl;
  }
};

int Entity::x;
int Entity::y;

int main()
{
  Entity e;
  e.x = 2;
  e.y = 3;

  Entity e1;
  Entity::x = 5;
  Entity::y = 8;
  Entity::Print();
  Entity::Print();
  std::cin.get();

  return 0;
}
```

Every non-static method you write in a class or struct gets an instance of the current class as a parameter. That's how classes work behind the scene. Classes are just a set of functions with a hidden parameter (a class instance). Static method doesn't get that hidden parameter. It is same as you write a function outside a class.

## Local Static in C++

Static local variable allows to declare a variable that have a lifetime of a program, however it's scope is limited in the function that defines it. It is not limited to be inside of a function but any scope.

```c++
#include <iostream>

void Function()
{
  static int i = 0; // the first time function is called it gets initialized, the next time it's just used
  i++;
  std::cout << i << std::endl;
}

int main()
{
  Function();
  // i++; // if it was global anyone can change it, with `static int` only the function that declared it
  Function();
  Function();
  Function();
  Function();
  std::cin.get();
}
```

## ENUMS in C++

ENUM is short for Enumeration. It is a set of values. A way to give a name to a value. Useful for representing states. It's just an integer.

```c++
#include <iostream>

enum Example : unsigned char // must be an integer
{
  A,
  B,
  C
};

int main()
{
  // Example value = 5; // error: invalid conversion from `int` to `Example`

  // Example value = 2; // a value of type int cannot be initialized an entity of type "Example"

  Example value = Example::B;

  if (value == 1)
  {
    // do something here
  }

  std::cin.get();

  return 0;
}
```

Enum isn't really a namespace, so you cannot have the same Enum entry name and class method.

Enum classes exist.

## Constructors in C++

Constructor is a special type of method that runs whenever we instantiates an object.

If we don't initialize member variables when constructing an object they will be assigned whatever was in memory at that time, e.g. some random numbers like 4.59149e-41.

If there is no constructor then an empty contructor is provided. It doesn't initialize anything. In Java and other languages primitive types are by default initialized and set to 0, but that is not the case in C++.

Constructor will not run if you don't instantiate an object, if for example you only use static methods from a class.

There is a way to remove constructor. Hiding constructor by making it private or `Entity() = delete` error with deleted function.

## Destructors in C++

Similarly how constructors run when you create an object, destructor run when you destroy an object. Everytime an object gets destroyed the desctructor method will be called.

Typically used for deinitializing and cleaning memory.

Destructor both applies to stack and heap allocated objects. If you allocate objects using new when you call `delete` the destructor will get called, if you just have a stack based objects then when the scope ends the object will get deleted and thus the destructor will be called.

```c++
~Entity()
{
  std::cout << "Destroyed Entity!" << std::endl;
}
```

Why to use: if there is some initialization code called in the constructor, you would like want to uninitialize or destroy that stuff in the destructor. If you don't you can get a memory leak. A good example of that is a heap allocated object, if you allocate any kind of memory on heap manually, you'll like want to deallocate in the destructor.

Destructor can be called manually, but that's rarely used.

## Inheritance in C++

Is one of the fundamental aspects of OOP. It allows us to have a hierarchy of classes that relate to each other. It allows us to have a base class that contains common functionality and then branch from that base and create subclasses from that initial parent class.

The primary why it is so useful is because it helps us avoid code duplication. Common functionality ends-up in the parent class and then simply make subclasses from that base class which either changes functionality in subtle ways or introduces a new functionality, but the idea is that inheritance gives us a way to put all of that common code between classes into a base class so that we don't have to repeat ourselves.

```c++
class Player : public Entity // Player **is** Entity
{
public:
  const char *Name;

  void PrintName()
  {
    std::cout << Name std::endl;
  }
};
```

Anything that is not private in Entity is accessible by Player.

Polymorpishm is an idea of having single type to represent multiple different types. In the example above that means we can use Player wherever Entity is used. Player has everything that Entity has and a bit more. Player is always going to be a superset of Entity.

Takeaway: Inheritance is a way to extend an existing class and provide additional functionality to a base class. When you create a subclass it will contain everything that a super class contains.

## Virtual Functions in C++

Virtual functions allow us to override methods in subclases.

B is derive from A. If we create a method in class A as virtual we can override it in B.

When to use `new`? You should use new when you wish an object to remain in existence until you delete it. If you do not use new then the object will be destroyed when it goes out of scope. Some people will say that the use of new decides whether your object is on the heap or the stack, but that is only true of variables declared within functions.

```c++
Entity e1 = Entity();
Entity *e2 = new Entity();
```

You MUST `delete` the `new`ed pointer, e.g. `delete e2`;

Member initialization list:

```c++
Player(const std::string &name) : m_Name(name) {}
```

When you initialize fields via Member initializer list the constructors will be called once and the object will be constructed and initialized in one operation.

If you use assignment then the fields will be first initialized with default constructors and then reassigned (via assignment operator) with actual values.

```txt
Cost of Member Initialization = Object Construction 
Cost of Member Assignment = Object Construction + Assignment
```

Class Member variables are always initialized in the order in which they are declared in the class.

When do you HAVE TO use Member Initializer list?

You will have(rather forced) to use a Member Initializer list if:

- Your class has a reference member
- Your class has a non static const member or
- Your class member doesn't have a default constructor or
- For initialization of base class members or
- When constructor’s parameter name is same as data member(this is not really a MUST)

```c++
void PrintName(Entity *entity)
{
  std::cout << entity->GetName() << std::endl;
}
```

The code above will call `GetName` on `Entity` type even if an Entity is a subclass such as `Player`.

Virtual functions introduce dynamic dispatch which compilers typically implement via vtable (virtual method table). Vtable is a mechanism used in a programming language to support run-time method binding (dynamic dispatch).

If you want to override a function you must mark as virtual in the base class.

```c++
// base class
virtual std::string GetName() { return "Entity"; }
// subclass
std::string GetName() override { return m_Name; } // override keyword is optional
```

Virtual functions are not free. There are two runtime costs associated with virtual functions:

1. the additional memory for storing vtable so that we can dispatch a call to the correct function that includes the member pointer that points to the vtable
2. everytime we call that function we go through the vtable to determine which function to map to

## Interfaces in C++ (Pure Virtual Functions)

Interfaces are a specific type of virtual functions - the pure virtual functions. It is essentially the same as interface or abstract in Java or C#. It allows us to define a function in a base class that doesn't have an implementation and then force subclasses to implement that function.

Overriding a virtual function with implementation in a subclass is optional. In some cases it doesn't make sense to provide a default implementation. We might force subclass to provide its own definition for a certain function. In OOP it's common to create a class that consists only of unimplemented methods and then force subclasses to actually implement them. That refered to as an interface. Because interface class doesn't contain an implementation it is impossible to intantiates such class.

```c++
class Entity
{
public:
  virtual std::string GetName() = 0; // equal zero makes it a pure virtual function, it has to be implemented in a subclass
};

int main()
{
  Entity *e = new Entity(); // object of abstract clas type "Entity" is not allowed, function "Entity::GetName" is a pure virtual function
}
```

You can only instantiates a class if it has all virtual functions implmented.

Use interfaces in order to guarantee that a class has a certain functions so that when an object is passed to a generic function its methods can be called.

## Visibility in C++

Refers to how visible certain members of a class are. Who can see them, call them, use them. 

Visibility has no effect on how program runs or its performance.

Three visibility modifiers: private, protected and public. In Java there's additional default visibility modifier and in C# internal.

```c++
class Entity
{
  int X, Y; // private by default
};

struct Sentity
{
  int X, Y; // public by default
}
```

**Private** means _only_ the owning class can access variables: read and write. A `friend` can access private members.

**Protected** means this class and all subclasses along the hierarchy can access this variable.

**Public** means access for all, anyone can access.

## Arrays in C++

