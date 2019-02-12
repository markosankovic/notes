# 2 Preliminary Concepts

Viewed from high level, all motors perform the same operation: they convert voltage and current into torque and angular speed.

## 2.1 Torque and Angular Speed

Force is one of the most fundamental quantities in physics and engineering.

Torque isn't well understood. Some know that it's a kind of rotational force, yet torque and force have different units of measurement.

### 2.1.1 Force

If an object undergoes any change in speed, whether it's acceleration (increase) or deceleration (decrease), the change is caused by a force. The amount of force can be obtained mathematically by multiplying the object's mass by it's acceleration or deceleration.

    F=ma

Force is measured in Newton (N)
mass is measured in kilogram (kg)
acceleration is measured in meter per second squared (m/s^2)

One Newton is the force needed to accelerate a mass of 1kg at a rate of 1m/s^2.

A force's direction may change over time, but at any specific time, a force always acts in a straight line. When an object falls to the ground, it moves in the straight-line direction determined by the gravitational force.

### 2.1.2 Torque

Like force, torque is proportional to the object's mass and relates to an object's acceleration or deceleration. Unlike force, torque acts in a *circular arc*, not a straight line.

A motor exerts torque through a shaft that connects to a load. If the motor can exert sufficient torque, the shaft will turn the load. If it can't exert enough torque, the shaft won't turn.

An important difference between torque and force is that the torque depends on the arc's radius. More precisely, if the force is perpendicular to the arc's radius, the torque equals the force multiplied by the radius. Denoting torque as τ (tau), force as F, and the radius as r, the equation for torque is given as follows:

    τ=rF

The direction of the force changes over time, but it's always perpendicular to the radius.

Scientists and engineers measure torque in Newton-meters, abbreviated N-m, or milliNewton-meters, abbreviated mN-m. Occasionally, torque will be given in Newton-centimeters, abbreviated N-cm.

The torque exerted by a motor depends in large part on the nature of its load.

*No-load condition* means that there's no load - the shaft rotates quickly and exerts minimal torque.

*Stall condition* means that motor exerts a great deal of torque, but the rotational speed is zero because the load is too great.

### 2.1.3 Angular Speed

Speed measures how quickly an object moves. In other words, speed tells you how far an object travels in a given amount of time.

For electric motors, angle is measured in degrees (°) and angular speed is measured in revolutions per minute, or RPM. A motor's rotational speed is denoted as ω (omega). If an object rotates with a speed of 12°/sec, the speed in RPM can be computed as follows:

    ω=(12deg/sec)(60sec/1min)(1rev/360deg)
    ω=620rev/360min
    ω=2rev/min
    ω=2RPM

It's important to clearly understand the difference between torque and angular speed. Angular speed tells you how many revolutions an object completes per minute. Torque tells you how much force the object can exert as it rotates. An object can rotate at high speed with low torque, or with high torque at low speed.

### 2.1.4 The Torque-Speed Curve

If a motor's shaft isn't connected to a load, the motor's speed is referred to as its *no-load speed*, denoted ωn. For most motors, this is the maxium speed.

If the motor's load is so large that its shaft can't turn, the motor's torque is called its *stall torque*, denoted τs. This is the maxium amount of torque that the motor is capable of exerting.

When selecting a motor for a project, it's a good idea to know what these values are. For example:

- ωn equals 17,000 RPM for an input voltage of 3 V.
- τs quals 0.75 oz-in for a stall current of 3.85 A.

The relationship between a motor's torque and speed can be illustrated graphically with a line called the *torque-speed curve*. This curve can be obtained with *dynamometer*. As the input electrical power is increased or decreased so do ωn and τs change.

## 2.2 Magnets

- Every magnet has two poles: north (N) and south (S).
- Opposite poles attract and like poles repel. In other words, when magnets come close to one another, they orient themselves to bring opposite poles closer and similar poles further apart.
- Different magnets have different strenghts. The stronger the magnet, the more its poles attract/repel the poles of other magnets.

There are two types of magnets, and both types are common in the world of electric motors:

- **Permanent magnets** - When certain materials are brought near high electric current, such as lighthing, they acquire permanent magnetic behaviour.
- **Electromagnets** - When a current-carrying wire is wrapped into a coil, it behaves like a magnet. This behaviour is temporary, and stops when current is removed. If the coil is wrapped around an iron core, the magnetic behavior grows stronger.

Permanent magnets don't need power to operate and they're generally strong. Unfortunatelly, their poles are always fixed in the same positions and they tend to be expensive.

The main advantage of electromagnets is that their magnetic behavior can be controller by changing the current. That is, altering the power can alter an electromagnet's strength and the location of its poles. The main disadvantage is power consumption - it takes a lot of current to make an electromagnet as 
strong as a permanent magnet.

The ability to control the magnetic behavior of electromagnets is central to the operation of electric motors.

Current can flow in a clockwise or counterclockwise orientation. This orientation determines the electromagnet's pole locations, or its *polarity*. This is set by two rules:

- If current flows in a counterclockwise direction, the top is the north pole and the bottom is the south pole.
- If current flows in a clockwise direction, the bottom is the north pole and the top is the south pole.

If the direction of current is reversed, the north and south poles switch positions. Put another way, reversing the current reverses the electromagnet's polarity.

Now let's consider an experiment involving four electromagnets, named A, A', B and B'. The A and A' electromagnets are connected to the same wire, and so are B and B'. In the center, a permanent magnet, called a *bar magnet*, is free to rotate.

When current is applied to one pair of electromagnets, the bar magnet rotates to align itself with the electromagnets' poles. There are four possibilities:

- Current flows from A to A'.
- Current flows from B to B'.
- Current flows from A' to A.
- Current flows from A to A'.

If current is delivered to the electromagnets in this sequence, the bar will rotate 360° in the counterclockwise direction. If current is delivered in the reverse sequence the bar will rotate 360° in the clockwise direction.

## 2.3 Equivalent Circuit Element

It's important to know how the motor behaves electrically. Does it act like a resistor, a capacitor, an inductor, or a diode? Or does it resemble a combination of these?

### 2.3.1 Electrical Losses

When a motor rotates with no load, it still draws current. This is called the motor's *no-load current*, denoted Io. This is needed to magnetize the iron cores of the electromagnets, so the electrical loss is called *iron loss*. When you're analyzing a circuit, this loss is accounted for by substracting Io from the current entering the motor.

Another source of electrical loss in a motor is called *copper loss*. This relates to the resistance of the armature, which is the portion of the motor that receives electrical power. An armature's resistance is denoted Ra, and if I is the current entering the motor, Ohm's law tells us that the voltage loss across the armature is (I-Io)Ra. Therefore, if V is the motor's input voltage, the voltage that contributes to the motor's operation equals `V-(I-Io)Ra`.

In addition to resistance, a motor's armature adds inductance. This inductance, denoted La, is usually so small that it doesn't need to be considered. But the aramture's inductance is proportional to the frequency of the current flowing through it. Therefore, if the motor is part of a high-frequency circuit, La can have a significat effect.

Most electromagnets have iron cores, but not all do. Motors without iron cores are called *coreless* or *air-core* motors. Coreless motors are weaker than motors with iron cores, but they are lighter and have lower electrical losses.

### 2.3.2 Back-EMF

As motor rotates, the interaction of its conductors and magnets generates a voltage proportional to the speed of rotation. If this rotation is caused by an external force, such as the flowing of a waterfall, this voltage can be used to provide power. In this case, the motor behaves as a generator.

But if the motor rotates in response to electrical power, the generated voltage opposes the incoming current. In this case the voltage is referred to as back-EMF, where EMF stands for electromotive force, which is a synonym for voltage. This phenomenon may also be referred to as counter-EMF, or *cemf*. Back-EMF increases as the voltage across the motor increases, but it's always less than the motor's input voltage.

The shape of the back-EMF depends on the type of the motor and the power delivered to it. But in all cases, the back-EMF can be modeled as a voltage source that opposes the direction of the incoming current.

Back-EMF is particularly important to understand when you're designing circuits for brushless DC motors. To control these motors, the controller needs to know the motor's shaft angle, and it fitures out this angle by determining the motor's back-EMF.

## 2.4 Power and Efficiency

An electric motor may be able to operate over a range of speed and torque, but every motor has an operating point at which it's particularly productive. At this *peak efficiency point*, the motor converts electrical power to rotational power with an absolute minimum of wasted power.

### 2.4.1 Work

Work is performed whenever a force acts on an object and moves it over a distance. If the force and distance are parallel, the work is proportional to both the force and the distance. That is, if a force, F, moves an object by a distance of d in the force's direction, the work exerted is Fd.

For example, if an object weighing 20 N falls a distance of 2 meters, the work performed by the gravitational force is 40 N-m. If the object doesn't move or moves in a direction perpendicular to the force, the work performed by the force is zero.

Rotational work is similar, but involves torque and angle. If a torque, τ, turns an object through an angle, θ, the work performed equals τθ. As an example, if you exert a constant torque of τ as you twist the lid off a jar, and the lid turns an angle of θ, the amount of work you've performed is τθ.

### 2.4.2 Rotational Power

Power is the rate at which work is performed. If work is constant over an interval of time, the power is computed by dividing work by the time interval. Denoting power as P, work as W, and the time as t, this relationship can be expressed mathematically:

    P=W/t

Power is measured in watts, abbreviated W, and 1 W equals 1 N-m/s. Another common unit is *horsepower*, or hp; 1 hp equals 745.7 W, and 1 W equals 0.00134 hp. For DC motors, power is commonly expressed in watts. For AC motors, power is generally expressed in horsepower.

Rotational work equals torque multiplied by the angle through which the torque is exerted. Rotational power equals torque times the angle divided by time. This is the same thing as torque times angular speed. Therefore, if torque given in N-m and angular speed is given in RPM, the mechanical power in watts can be computed with the following equation:

    Pmechanical = 0.1047τω

### 2.4.3 Electrical Power

Electrical power is even easier to understand than rotational power: Power equals voltage times current. Denoting voltage as V, current as I, and the power as P, the equation is given as follows:

    Pelectrical=VI

This assumes that voltage is measured in volts, current in measured in amperes, and power is measured in watts. If 2 A of current flows at 5 V, the electrical power equals 10 W.

Taking the losses into account, the power reaching the motor can be given as follows:

    Pmotor=(V-IRm)(I-Io) where Rm is armature's resistance and Io is the current loss due to iron loss

This expression identified the electrical power that the motor successfully converts to mechanical power. The mechanical power equals torque, τ, multiplied by speed, ω. Equating electrical and mechanical power, we obtain an important equation:

    (V-IRm)(I-Io)=τω=Pmechanical

### 2.4.4 Efficiency

No electric motor converts all of its incoming electrical power to mechanical power. The ratio between the motor's input power and output power is called *efficiency*, denoted as η. This value can be obtained with the following equation:

    η=Poutput/Pinput

An ideal electric motor has an efficiency of 1, but real-world motors generally have efficiencies between 0.5 and 0.9. For example, if a motor produces 1.5 watts of mechanical power for every 2.0 watts of input electric power, its efficiency is 1.5/2.0=0.75.

For an electric motor, efficiency can be computed in the following way:

    η=Poutput/Pinput=Pmechanical/Pelectrical=τω/VI

Using a relationship derived earlier, the numerator can be expressed in terms of voltage, current, and losses;

    η=Pmechanical/Pelectrical=(V-IRm)(I-Io)/VI=(V-IRm/V)(I-Io/I)

Efficiency increases as V increases and as Rm decreases. Therefore, so long as the voltage is kept within the motor's limits, efficiency can be increased by increasing voltage. This explains why high-power motors running at their rated speed are more efficient than lower-power motors running at their rated speed.

The relationship between efficiency and current is more complex. On one hand, an increase in current increases the copper loss (IRm), so this reduces efficiency. On the other hand, an increase in current decreases the effect of the iron loss (Io), so this increases efficiency.

Many vendors specify a motor's peak efficiency parameters. You should always choose a motor whose peak efficiency characteristics closely match those of the desired workload. That is, the motor's torque and speed at peak efficiency should be close to the torque and speed that it's intended to provide.

The penalty for motor efficiency is more than just wasted power. The copper loss in the armature produces heat equal to I²Rm. If this heat grows too large, it can damage the motor and the surrounding circuitry.

## 2.5 Summary

When you're selecting a motor, it's important to clearly understand the specifications provided by the manufacturer. These specifications center on four physical quantities: current, voltage, speed and torque.

We concern ourselves with two extreme conditions: the no-load condition (rotates quickly without load) and the stall condition (motor fully exerts itself but fails to move the load). These conditions play a central role in determining a motor's torque-speed curve.

Two important electrical characteristics are iron loss and copper loss. Iron loss is the current needed to energize the motor's electromagnets. Copper loss is the resistive heating (I^2R) within the armature.

To keep wasted power to a minimum, the motor's peak efficiency should be reached during normal operation. Efficiency is the ratio of mechanical power to electrical power.