# Generics

## Introduction

With generics it is possible to create a component that can work over a variety of types rather than a single one. This allows users to consume these components and use their own types.

## Hello World of Generics

Without generics, we would either have to give the identity function a specific type:

    function identity(arg: number): number {
      return arg;
    }

Or, we could describe the identity function using the *any* type:

    function identity(arg: any): any {
      return arg;
    }
