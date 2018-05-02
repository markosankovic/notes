
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

##### More Challenges

An embedded system is designed to perform a specific task, cutting out the resources it doesn't need to accomplish its mission: Memory (RAM), Code space (ROM), Processor cycles or speed, Battery life (or power savings), Processor peripherals.

The uncertainty of whether a bug is in the hardware or software can make issues difficult to solve. Unlike your computer, the software you write may be able to do actual damage to the hard- ware.

Creating a system that can be manufactured for a reasonable cost is a goal that both embedded software en- gineers and hardware engineers have to keep in mind.

After manufacture, the units go into the field. Bugs may be catastrophic.

Engineering embedded systems is not just about strict constraints and the eventual life of the system. The challenge is figuring out which of those constraints will be a problem later in product development. You will need to predict the likely course of changes and try to design software flexible enough accommodate whichever path the application takes.

## Chapter2: Creating a System Architecture

Embedded systems depend heavily on their hardware. Unstable hardware leaves the software looking buggy and unreliable.

### Creating System Diagrams

- Architecture block diagram
- Hierarchy of control organization chart
- Software layering view

#### The Block Diagram

Model your software around the physical components. Each chip attached to the processor is an object. Think of the wires that connect the chip to the processor (the communication methods) as another set of objects.

#### Hierarchy of Control

#### Layered View

### From Diagram to Architecture

The boxes in the diagram should represent the Platonic ideals of each thing instead of a specific implementation.

#### Encapsulate Modules

Make interfaces between the modules that don't depend specifically on what is in them (this is encapsulation!). Use the three different architecture drawings to figure out the best places for those interfaces. Each box will probably have its own interface.

#### Delegation of Tasks

Which parts of the system can be broken off into separate, describable pieces that someone else can implement?

#### Driver Interface: Open, Close, Read, Write, IOCTL

Many drivers in embedded systems are based on API used call devices in Unix systems:
- **open**: Opens the driver for use. Similar to (and sometimes replaced by) init.
- **close**: Cleans up the driver, often so another subsystem can call open.
- **read**: Reads data from the device.
- **write**: Sends data to the device.
- **ioctl**: (Pronunciation: eye-octal.) Stands for input/output (I/O) control and handles the features not covered by the other parts of the interface.

#### Adapter Pattern

It converts the interface of an object into one that is easier for a client (a higher level module). Often times, adapters are written over software APIs to hide ugly interfaces or libraries that change.

The hardware interface can change without your upper-level software changing. Ideally, you can switch platforms altogether and need only to rework the underpinnings.

If the interface to each level is consistent, the higher level code is pretty impervious to change. For example, if SPI flash changes to an I2C EEPROM (a different communication bus and a different type of memory), the display driver may not need to change, or may only need to replace flash functions with EEPROM ones.

#### Getting Started With Other Interfaces

#### Example: A Logging Interface

## Chapter 3: Getting the Code Working

- Reading a datasheet
- Getting to know a new processor
- Unraveling a schematic
- Having a debugging toolbox
- Testing the hardware (and software)

### Hardware/Software Integration

The product starts out as an idea or a need to be filled.

#### Ideal Project Flow

The hardware team goes through datasheets and reference designs to choose components. They find what they need for the product, at the right price, in the correct physical dimensions, with a good temperature range, etc.

The hardware team creates schematics, while the software team works on the development kit. They build a tool chain with compiler and debugger, creating a debugging subsystem, trying out a few peripherals, and possibly building a sandbox for testing algorithms.

Schematics are entered using a schematic capture program. Once the schematic is complete the board can be laid out.

After layout, the board goes to fabrication (fab) where the printed circuit boards (PCBs) are built.

After the schematic is done and layout started, the primary task for the embedded software team is to define the hardware tests and get them written while the boards being are created.

When the boards come back, the hardware engineer will power them on to verify there aren't power issues, possibly verifying other purely hardware subsystems.

#### Board Bring Up

Make each component individually testable.

When you get the PCBA, start on the lowest level pieces, at the smallest steps possible. For example, don't try out your fancy motor controller software. Instead, set an I/O device to go on for a short time and make sure the motor moves at all.

### Reading a Datasheet

As a software engineer, consider each chip as a separate software library. All the effort you'd need to put into learning a software package (Qt, Gtk, Boost, STL, etc.), you are going to need to put into learning your chip and peripherals.

Datasheets are the API manuals for peripherals. Hardware components are described by their datasheets. Datasheets can be intimidating, as they are packed densely with information. The first thing to know about datasheets is that they aren't really written for you. They are written for an electrical engineer.

The description is not the place to read a few words and skip to the next paragraph. The text is dense and probably less than a page long. Read this section thoroughly. Read it aloud or underline the important information (which could be most of the information).

#### Datasheet Sections You Need When Things Go Wrong

- Pin out for each type of package available
- Pin descriptions
- Performance characteristics
- Sample schematics

#### Important Text for Software Developers

The Application Information or the Theory of Operation.

Timing diagrams show the relationship between transitions. Some transitions may be on the same signal, or the timing diagram may show the relationship between transi- tions on different signals.

#### Evaluating Components Using the Datasheet

Datasheets don't usually have prices because those depend on many factors, especially how many you plan to order. And datasheets don't have lead times (so be careful about designing the perfect part, it may only be available if you wait six months). Unless you are ordering online, you'll need to talk to your vendor or distributor.

If they don't match (or exceed) your criteria, set the datasheet aside. The present goal is to wade through the pile of datasheets quickly; if a part doesn't meet your basic criteria, note what it fails and go on.

Once the basic electrical and mechanical needs are met, the next step is to consider the typical characteristics, determining whether the part is what you need. Some common questions at this level your functional parameters: Does the component go fast enough? Does the output meet or exceed that required by your system? In a sensor or an ADC, is the noise acceptable?
