
#  Making Embedded Systems

## Chapter 1: Introduction

*An embedded system is a computerized system that is purpose built for its application.*

The hardware has contraints:
- CPU that runs more slowly to save battery power,
- system that uses less memory so it can be manufactured more cheaply,
- processors that come only in certain speeds or support a subset of peripherals.

In some systems, the software must act **deterministically** (exactly the same each time) or **real-time** (always reacting to an event fast enough). Some systems require that the software be fault tolerant with graceful degradation in the face of errors (i.e. a satellite or a tracking tag on a whale). Other systems require that the software cease operation at the first sign of trouble, often providing clear error messages (a heart monitor should not fail quietly).

### Compilers, Languages, and Object-Oriented Programming

Embedded systems use cross compilers. Cross compilers run on desktop or laptop computers, but create code that does not. The cross compiled image runs on a target embedded system.

#### Embedded System Development

##### Debugging

In addition to a cross compiler, you'll need a cross debugger. The debugger sits on your computer and communicates with the target processor through the special processor interface (see Figure 1-1). The interface is dedicated to letting someone else eavesdrop on the processor as it works. This interface is often called JTAG (pronounced "jay-tag"), whether it actually implements that widespread standard or not.

The device that communicates between your PC and the processor is generally called an emulator, an in-circuit emulator (ICE), or a JTAG adapter.

Many embedded systems are designed to have their debugging primarily done via `printf` or some sort of lighter weight logging to an otherwise unused communication port. While incredibly useful, this can also change the timing of the system, possibly leaving some bugs to be revealed only after debugging output is turned off.
