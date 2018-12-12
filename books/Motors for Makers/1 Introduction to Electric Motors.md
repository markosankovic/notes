# 1 Introduction to Electric Motors

When selecting a motor, there's a long list of questions that need to be addressed:

- Should the motor be direct current (DC) or alternating current (AC)?
- For a DC motor, should it be brushed or brushless?
- For a brushed DC motor, should it be a permanent magnet, series-wound, or shunt-wound motor?
- For a brushless DC motor, should it be an inrunner or an outrunner?
- Is the motor's Kv value sufficient for the system's speed and torque requirements?
- If the motor's torque is insufficient, what type of gears should be attached?

## 1.1 Brief History

There are two important historical developments:

1. moving needle in Denmark and
2. rotating wire in Hungary.

### 1.1.1 Oersted's Compass Needle

In 1820.: changing the current in a wire move the needle of a nearby compass.

This experiment demonstrates the interaction between the two basic elements of an electric motor: changing the current and a magnetic field. When these two components are in close proximity, the result is motion.

### 1.1.2 Jedlik's Self-Rotor

In France, Andre-Marie Ampere developed equations relating current in a wire to the magnetic field around the wire. I England, Michael Faraday devised a series of experiments that demonstrate how current-carrying wires move in the presence of a magnetic field.

Instead of placing the wires outside a compass, Anyos Jedlik wound it into coils and placed the coils inside a magnetic field. As current changes inside the coils, the coils rotate.

Today's rotary electric motors have essentially the same structure as Jedlik's self-rotor:

- The input electrical power is delivered through a current-carrying conductor.
- The current-carrying conductor is placed in the vicinity of a magnetic field.

The motion is produced by delivering current through a wire in the presence of a magnetic field.

## 1.2 Anatomy of a Motor

Motors can be thought of a electrical elements or as mechanical elements. Therefore, the same part may have different names depending on whether the motor is considered electrically or mechanically.

### 1.2.1 External Structure

- **Case or shell** - the external housing surrounding the motor
- **Shaft** - The metal cylinder extending from the motor's center
- **Wires or leads** - The conductors carrying electricity to the motor

The electrical input is delivered to the motor through its leads. As the motor operates, it rotates the shaft. This shaft is connected to a load such as the tire of an RC car.

NOTE: In certain types of motors, the shell rotates and the shaft remains fixed. One popular example is the outrunner brushless DC motor.

### 1.2.2 Internal Structure

As current enters the motor, the central element rotates inside the case.

From mechanical standpoint, the motor consists of two parts. The *rotor* is the part that moves, and the *stator* is the part that stays in place. The space separating the rotor and stator is called the *air gap*.

Viewed electrically, a motor's structure can be divided into another two parts. The *armature* is the part that receives current. The motor's central element (the rotor) is the armature because it receives incoming current.

The second electrical part is responsible for generating the magnetic field. If the field is produced by permanent magnets, the second part is called the *field magnet*. If the magnetic field is produced by an electromagnet, the second part is called the *field winding*.

### 1.3 Overview of Electric Motors

There is a wide range of categories and subcategories to choose from.

Universal motors can operate on AC and DC power. If any motor is connected to an encoder or position sensor, its angle can be measured and controlled.

A motor that turns about an axis is a *rotary motor*. If it moves in a straight line, it's a *linear motor*.

At high level, electric motors can be categorized according to the nature of the input power. A DC motor receives DC (direct current) power, such as from a battery or power regulator. An AC motor receives AC (alternating current) power, such as from a wall socket.

### 1.3.1 DC Motors

DC motors accept DC electrical power, such as that provided by a battery. Every motor in quadcopter or a remote-controlled car is a DC electric motor.

DC motors are divided into brushed and brushless motors. The primary distinction between them involves the need for a commutator. A commutator reverses voltage as the motor turns, therby ensuring that the motor continues to turn. Motors with a mechanical commutator are called brushed motors or commutated motors. These motors are simple and inexpensive, but periodic maintenance is needed to keep them working properly.

Brushless DC motors, commonly called BLDCs, don't require maintenance as brushed motors do, but their structure is more complex. This means that they cost more money and it takes significantly more effort to control them.

### 1.3.2 AC Motors

AC motors are common in industrial and household settings, and you'll find them in blenders, microwaves, and washing machines. AC motors come in two types: synchronous and asynchronous. The difference between them depends on how the motor's speed should be controlled. The speed of a synchronous motor is synchronized with the frequency of the incoming AC power.

The majority of AC motors are asynchronous, which means that their speed isn't synchronized with the frequency of the incoming power. These motors, frequently called induction motors, are popular, simple and reliable.

## 1.4 Goals and Structure

The nature of a motor control circuit depends on the type of motor. That is, a circuit intended to control a stepper motor can't provide proper control of a servomotor, and you can't control a DC motor with and AC motor control circuit.

## 1.5 Summary

When it comes to electric motors there are four levels of understanding:

1. **Hobbyist** - "When I apply voltage and current, the motor's shaft turns."
2. **Make** - "The motor's shaft turns because the electromagnets in the stator are energized in sequence. The rotor's speed is proportional to voltage and the torque is proportional to current."
3. **Engineer** - "The motor's impedance can be represented by the phasor Ra + jwLa. If the input voltage is Vm sin(wt + 90deg), the torque and speed can be computed as..."
4. **Scientist** - "The electromagentic tensor traveling through the conductor aligns the domains in the ferromagnetic material. This produces a magnetic vector field proportional to the material's permeability."

On the outside, a motor has leads that deliver current and voltage to the motor and a shaft that delivers torque and speed to the load.
