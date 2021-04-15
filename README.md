# Matlab Single-Track Model

Modeling and simulating a single-track model in Matlab.

Thereby different maneuvers can be simulated. 

## Simulate

SingleTrack.m

- Select how the rear wheel should behave 
- Simulate

## Plot

- Vehicle frame with four wheels on each side (real wheels)
- Single-track model with two wheels in center of vehicle (theoretical)
- blue lines marking radius from a real wheel to center of rotation
- green lines marking radius from single-track wheels to center of rotation

## Examples

- Example where front and rear wheel set perform inverse steering

![Example where front and rear wheel set perform inverse steering](https://raw.githubusercontent.com/SKenb/Matlab_SingleTrackModel/master/Examples/Example1.PNG)

- Example where rear wheel set is fixed - like a normal car

![Example where rear wheel set is fixed - normal car](https://raw.githubusercontent.com/SKenb/Matlab_SingleTrackModel/master/Examples/Example_RearFixed.PNG)

- Example where front and rear wheel set perform same steering

![Example where front and rear wheel set perform same steering](https://raw.githubusercontent.com/SKenb/Matlab_SingleTrackModel/master/Examples/Example_Equal.PNG)

## TODO

- Adjust C_f/C_r (cornering stiffness) curve in Simulink model

## Requirements

- Matlab (>=) 2016b