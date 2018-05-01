
#  Making Embedded Systems

## Chapter 1: Introduction

*An embedded system is a computerized system that is purpose built for its application.*

The hardware has contraints:
- CPU that runs more slowly to save battery power,
- system that uses less memory so it can be manufactured more cheaply,
- processors that come only in certain speeds or support a subset of peripherals.

In some systems, the software must act **deterministically** (exactly the same each time) or **real-time** (always reacting to an event fast enough). Some systems require that the software be fault- tolerant with graceful degradation in the face of errors (i.e. a satellite or a tracking tag on a whale). Other systems require that the software cease operation at the first sign of trouble, often providing clear error messages (a heart monitor should not fail quietly).
