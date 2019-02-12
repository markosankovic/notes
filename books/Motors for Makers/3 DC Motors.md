# 3 DC Motors

## 3.1 DC Motor Fundamentals

Brushed and brushless DC motors have different internal structures and different methods of control, but they have four characteristics in common:

- Torque is approximately proportional to current.
- Speed is approximately proportional to voltage.
- Control circuitry employs electrical switches to deliver power to the motor.
- A controller can govern the motor's operation using PWM (pulse width modulation) signals.

### 3.1.1 Torque, Current, and Kt

Ampere's Force Law tells us how much force a magentic field exerts on a current-carrying wire. This is a complex equation that involves vectors and calculus, to summarize: As the current entering the armature of a motor increases, the motor's torque increases.

For DC motors, the relationship between torque and current can be approximated with a straight line. This means that the ratio between torque and current is generally constant. This constant is referred to as Kt, and many datasheets provide this value in ouce-inches/ampere (oz-in/amp), pound-inches/ampere (lb-in/amp), Newton-meters/ampere (N-m/A), or Newton-centimeters/ampere (N-cm/A).

When motor's shaft rotates but exerts no torque, it's in the no-load condition. The current drawn by a motor in its no-load condition is called the *no-load current*, denoted as I0. In Figure 3.1, I0 equals 0.24A.

I0 is the minimum amount of current needed to put the motor in motion. Therefore, if the motor's armature receives a current of I, the torque produced by the motor equals Kt(I-I0).

### 3.1.2 Rotation Speed, Voltage, and Kv

Motor's rotational speed increases with voltage. This angular speed, denoted as ω, is given in rotations per minute, or RPM.

The constant that specifies a motor's speed/voltage ratio is called Kv, and this is usually given in units of RPM/V (revolutions per minute per volt).

Every motor's armature has resistance Ra. Some of the voltage entering the motor will drop across Ra, and we refer to this voltage loss as Va. In Figure 3.2, Va equals 0.26V.

If V is the total voltage applied, the motor's speed equals Kv(V-Va). Denoting the motor's current as I-I0, it's clear that Va=(I-I0)*Ra.

### 3.1.3 The Kt-Kv Tradeoff

Motor's convert input voltage (V-Va) and input current (I-I0) to torque (τ) and speed (ω). This relationship can be expressed by equating the input electrical power to the output mechanical power, which leads to the folowing equation:

    (V-Va)(I-I0)=τω

Three conclusions about electric motors:

- If you know one constant, it's easy to compute the other. For this reason, most datasheets only provide Kv.
- No motor excels at converting current to torque (high Kt) and convering voltage to speed (high Kv). If one value is relatively high, the other must be relatively low.
- If a motor's purpose is to run quickly, select a motor with high Kv and low Kt. If its purpose is to provide torque, select a motor with high Kt and low Kv.

For most applications, the average motor provides too much speed and too little torque. For this reason, many systems insert gears between the motor and the load. Gears make it possible to increase torque and reduce speed.

### 3.1.4 Switching Circuitry

The main disadvantage of using electromagnets is power consumption. This is why even small motors may need tens of amps to function properly.

The circuitry that governs a motor's operation is called the *controller*. In modern systems, this is an integrated circuit. In most maker-focues devices, this is a microcontroller or a low-power processor. These devices run on milliamps, so they can't directly provide a motor with the power it needs. For this reason, motor circuits need electrical switches.

#### Electrical Switches

In an electrical circuit, a mechanical switch creates a conductive path when a button is pressed. An electric switch works in essentially the same way. When the controller applies a small voltage to one terminal, the switch creates a conductive path that allows current to flow through the other terminals.

Suppose a 3.3 V microcontroller is employed to control a brushed DC motor. This chip can't deliver power directly to the motor, but if power is connected through an electric switch, the controller can govern the motor's current by turning the switch on and off.

#### Transistors as Electrical Switches

Ideal electrical switches don't exist in reality, but we can approximate such a switch with a device called a *transistor*. To be specific, most modern motor circuits rely on metal-oxide-semiconductor field-effect transistor (MOSFETs) or insulated-gate bipolar transistors (IGBTs) to serve as a switch.

The input terminal of a MOSFET or IGBT is referred to as the gate. For a MOSFET, the terminals that deliver current are the drain and source. For an IGBT, the current-carrying terminals are the collector and emitter.

The properties of an ideal electric switch: When the input voltage is less than or equal to zero, the resistance between the other two terminals is infinite. When the input voltage is greater than zero, the resistance between the two terminals is zero.

MOSFETs and IGBTs come close to this ideal, but there are three non-ideal aspects of their behavior to be aware of:

- To close the switch, the voltage between the gate and lower terminal must be greater than a threshold voltage, denoted as Vth. For a MOSFET, Vth is typically between 0.5 and 1 V. For an IGBT, Vth is commonly between 3 and 8 V.
- When the gate voltage is less than Vth, the current allowed to pass through the other two terminals is so small as to be considered practically zero.
- When the gate voltage is greater than or equal to Vth, the resistance between the other terminals is low, but it's not zero. For a MOSFET, the resistance between the drain and source, Rds(on) is a low as 0.03Ω. For an IGBT, the voltage-current relationship isn't linear, but the voltage drop between the two terminals is less than that between the terminals of a comparable MOSFET.

The MOSFETs and IGBTs have similar purposes, terminals, and operating characteristics, but MOSFETs can switch current on/off more quickly and are generally less expensive. In contrast, IGBTs can switch greater amounts of current, and the voltage drop from collector to emitter is less than the drain-source voltage drop a similarly capable MOSFETs.

As a rule of thumb, MOSFETs are better suited for circuits with small- to medium-sized motors. IGBTs are better suited for circuits with large motors.

#### 3.1.5 Pulse Width Modulation (PWM)

With an electrical switch, the controller can turn a motor's current fully on or fully off. But what if you want the motor to rotate at 75% of its full speed? What if you want the motor's speed to ramp up gradually? Increasing the controller's voltage won't help - once the gate voltage exceeds the transistor's threshold voltage, increasing the gate voltage further won't substantially increase the current.

Instead, controllers govern the motor's behaviour by delivering pulses that open and close the switch for precise amount of time. This pulse delivery is reffered to as pulse width modulation, or PWM.

The concept underlying PWM is simple. The controller delivers a series of pulses of current to the motor. The controller generates pulses at equal intervals, so the wider the pulse, the more current reaches the motor and the faster is runs.

T is the time between the rising edges of two adjacent pulses. This interval is referred to as the *frame* or the *period*. The controller sets T by configuring the PWM frequency, which equals 1/T.

t is the length of time that the controller's signal is high (greater than the threshold voltage). This tme is referred to as the *pulse width*. The *duty cycle* is the ratio of the pusle width to the frame:

    duty cycle = t/T
    PWM frequency 500 Hz
    T=1/500=2ms
    duty cycle is 0.4, each pulse occupies 40% of the frame
    t=(2ms)(0.4)=0.8ms

Choosing the right PWM frequency is critical. Two important factors to consider:

- If the frequency is too low, the rise/fall of the power reaching the motor will cause it to rotate in a rough, jerky fashion.
- If the frequency is too high, the pulses will be too narrow to open and close the switches poperly. In addition, the electromagnets will generate heat, decreasing the motor's efficiency.

There are no clear rules regarding PWM frequency, but many servomotor circuits directed at hobbyists expect a frequency of 50 Hz. This corresponds to a frame of 20 ms.

Frequencies between 30 Hz and 20 kHz produce noise withing the human range of hearing. If this is a concern, you may want to set the PWM frequency higher than 20 kHz.

## 3.2 Brushed Motors

They are simple and easy to control. Despite their simplicity, brushed DC motors have fetures that may make them unsuitable for certain applications.

### 3.2.1 Mechanical Commutation

Every electric motor contains two parts: current in a conductor and a magnetic field. It's important to note that the current must change over time. If the current in the conductor is constant, the motor won't make a complete rotation.

By attaching the metal contacts to the armature that reverse the current's direction every time the armature makes half a revolution ensures that the force will always be greater than zero and that the armature will continue rotating.

This current reversal is called *commutation*. The metal contacts form a mechanical commutator, which is more commonly referred to as a *brush*. Until the 1960s, brushed motors were the only DC motors available.

NOTE: It's safe to assume that every DC motor with a brush also uses a commutator to reverse current.

### 3.2.2 Types of Brushed Motors

Brushed motors come in three varieties, and the differences between them depend on how the motor generates its magnetic field. If the field is generated by a permanent magnet, the motor is called a permanent magnet DC (PMDC) motor.

The other two types of brushed motors generate magnetic fields using electromagnets. An electromagnet consists of a coil wire wrapped around an iron core. These coils of wire are called *field windings* or *field coils*. The magnetic field produced by a field winding is proportional to the current flowing through it.

#### Permanent Magnet DC (PMDC) Motors

PMDC motors are the most popular brushed motors. Because of their permanent magnets, the magnetic field is reliably constant. This means that Kv, the ratio of speed to voltage, is constant.

One disadvantage of these motors is that permanent magnet lose their magnetization over time. This means the motor gradually produces less torque and speed. This demagnetization accelerates when the armature is driven with large startup currents.

#### Series-Wound DC (SWDC) Motors

In an SWDC motor, the field winding is connected in series with the rotor winding, which means the current entering the field winding is the same as that entering the armature.

To understand why SWDC motors are useful, it's important to see what happens when the current increases. An increase in current producrs an increase in torque. But for an SWDC motor, the increased current also produces an increase in the magnetic field, which further increases the motor's torque. This is why the torque produced by an SWDC motor is much greater than that produced by a PMDC motor.

The disadvantage of using SWDC motors involves speed control. The magnetic field strength changes with current, so the value of Kv, changes with current. This makes it hard to reliably set the motor's speed.

#### Shunt-Wound DC (SHWDC) Motors

In an SHWDC motor, the field winding is placed in parallel with armature. This means the voltage across the field winding equals the voltage across the armature.

This doesn't produce as much torque as a series-wound motor, but the torque-speed curve is generally level. That is, the motor can maintain its speed for different amounts of load. For this reason, shunt-wound motors are commonly used in systems that need to govern the motor's speed reliably.

### 3.2.3 Advantages and Disadvantages

Brushed motors have improved in performance and reliability since the nineteenth century, but a significant drawback remains: The brush makes contact with the rotor at high speed. As a result, friction erodes the brush over time. It may take months, or years, but eventually, every brushed motor will require maintenance to continue functioning.

A second disadvantage is that a brushed motors has to rotate the commutator along with the rotor. This places an additional load on the motor that reduces its efficiency.

Brushed motors are less complex than brushless motors, so they're less expensive to make. Also, controlling a brushed motor is simpler than controlling a brushless motor, so the circuitry is more cost effective.

### 3.2.4 Control Circuitry

Controlling a brushed motor is straightforward because the motor's operation is so easy to understand.

- Single-direction control - If the motor only needs to turn in one direction, the circuit can be easily constructed with transistor.
- Dual-direction control - If the motor's direction needs to be changed, an H bridge should be added to the circuit.

#### Single-Direction Control

If a brushed motor only needs to turn in one direction, designing the circuit is easy. The main goal is to enable the controller to turn the motor's current on and off. This is accomplished with MOSFET and PWM.

The circuit has an important problem. A turning motor generates a voltage called back-EMF. If the MOSFET shuts off current after the motor has been running, the motor's back-EMF may damage the transistor. For this reason, control circuits connect a diode in parallel with the motor to provide a path for the back-EMF current. This is called a *flyback diode*.

Some control circuits also insert a potentiometer. This allows a user to directly control the current passing through the motor and thereby increase or reduce the motor's torque and speed.

#### Dual-Direction Control

The preceding circuit can turn a motor on and off, but it can't reverse the motor's direction. To make this possible, the circuit needs to be able to reverse the direction of the current flowing through the motor. That is, the circuit needs one path that carries current through the motor in one direction and another path that carries current in the opposite direction. In addition, the circuit needs a way to turn the motor's current on and off.

These requirements can be met by adding an H bridge to the circuit. This component has four electrical switches (S0-S3) that can be controlled independently. There are many possible states for the switches of an H bridge, but three are particularly imporant:

- S0 and S3 closed, S2 and S1 open - Current flows through the motor from left to right.
- S2 and S1 closed, S0 and S3 open - Current flows through the motor  from right to left.
- S0 and S2 open - The motor's position is held in place.

It's common to encounter H bridges constructed out of MOSFETs.

If you'd rather not design/construct your own control circuit, you can buy an electric speed control (ESC). These systems receive battery power and produce the pulses needed to power a brushed motor.

ESCs are convenient for brushed motor systems, but they're essential for systems containing brushless motors.

## 3.3 Brushless Motors
