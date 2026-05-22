Overview:

This project implements an Adaptive Cruise Control (ACC) system using MATLAB. The objective is to automatically regulate the speed of an ego vehicle while maintaining a safe following distance from a lead vehicle under varying traffic conditions.
The controller combines PID-based speed regulation with distance-aware adaptive logic, allowing the ego vehicle to respond to changes in the lead vehicle's speed and maintain safe vehicle separation.

Objectives:

* Simulate vehicle-following behavior in a highway driving scenario.
* Maintain a desired cruising speed when the road ahead is clear.
* Automatically adjust speed when approaching a slower vehicle.
* Ensure safe following distance through adaptive control logic.
* Evaluate controller performance using simulation-based validation.

Adaptive Cruise Logic:

The controller dynamically modifies the target speed according to:
* Safe following distance
* Relative speed with respect to the lead vehicle
* Driver-set cruise speed
This prevents collisions and enables smooth speed adaptation.

Key Observations:

* Safe following distance was maintained throughout the simulation.
* No collision occurred between the ego and lead vehicles.
* The controller successfully adapted to changing traffic conditions.
* Vehicle speed smoothly adjusted when the lead vehicle slowed down.
* Stable speed tracking was achieved without excessive overshoot.

Validation Scenarios:

* Scenario 1 – Free Road Driving
 --Ego vehicle accelerates toward desired cruise speed.
 --No speed restriction from the lead vehicle.
* Scenario 2 – Lead Vehicle Deceleration
 --Lead vehicle speed decreases from 20 m/s to 10 m/s.
 --Ego vehicle automatically reduces speed.
* Scenario 3 – Lead Vehicle Re-acceleration
 --Lead vehicle accelerates to 22 m/s.
 --Ego vehicle adapts and resumes higher cruising speed.

Author:
Kaushik Das
Applied Electronics and Instrumentation Engineering
University of Burdwan
