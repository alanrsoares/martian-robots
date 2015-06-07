# martian-robots

#### Install dependencies

```bash
npm i
```

#### Run demo
```bash
npm start
```
#### Run tests
```bash
npm test
```

## The Problem

The surface of Mars can be modelled by a rectangular grid around which robots are able
to move according to instructions provided from Earth. You are to write a program that
determines each sequence of robot positions and reports the final position of the robot.
A robot position consists of a grid coordinate (a pair of integers: x-coordinate followed by
y-coordinate) and an orientation (N, S, E, W for north, south, east, and west).
A robot instruction is a string of the letters “L”, “R”, and “F” which represent, respectively,
the instructions:

* Left : the robot turns left 90 degrees and remains on the current grid point.
* Right : the robot turns right 90 degrees and remains on the current grid point.
* Forward : the robot moves forward one grid point in the direction of the current orientation and maintains the same orientation.

The direction North corresponds to the direction from grid point (x, y) to grid point (x, y+1).
There is also a possibility that additional command types may be required in the future and
provision should be made for this.

Since the grid is rectangular and bounded (...yes Mars is a strange planet), a robot that
moves “off” an edge of the grid is lost forever. However, lost robots leave a robot “scent”
that prohibits future robots from dropping off the world at the same grid point. The scent is
left at the last grid position the robot occupied before disappearing over the edge. An
instruction to move “off” the world from a grid point from which a robot has been previously
lost is simply ignored by the current robot.
