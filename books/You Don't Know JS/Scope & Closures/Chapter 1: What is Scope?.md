# Chapter 1: What is Scope?

The ability to store values and pull values out of variables is what gives a program _state_.

Well-defined set of rules for storing variables in some location, and for finding those variables at a later time is called _Scope_.

## Compiled Theory

In a traditional compiled-language process, a chunk of source code, your program, will undergo typically three steps _before_ it is executed, roughly called "compilation":

1. **Tokenizing/Lexing**: breaking up a string of characters into meaningful (to the language) chunks, called tokens. **Note**: The difference between tokenizing and lexing is subtle and academic, but it centers on whether or not these tokens are identified in a _stateless_ or _stateful_ way.
2. **Parsing**: taking a stream (array) of tokens and turning it into a tree of nested elements, which collectively represent the grammatical structure of the program. This tree is called an "AST" (Abstract Syntax Tree).
3. **Code-Generation**: the process of taking an AST and turning it into executable code. This part varies greatly depending on the language, the platform it's targeting etc.

The JavaScript engine is vastly more complex than _just_ those three steps, as are most other language compilers. JS engine uses all kinds of tricks to ensure the fastest performance, e.g. JIT which lazy compile and even hot re-compile etc. Any snipet of JavaScript has to be compiled before (usually _right_ before!) it's executed.

## Understanding Scope

