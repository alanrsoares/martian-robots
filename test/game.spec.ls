require! {
  'chai': { expect }
  '../src/robot': { Robot }
  '../src/grid': { Grid }
}

grid = new Grid 5, 3

cases =
  * robot: new Robot 1, 1, \E
    instructions: \RFRFRFRF
    expected: '1 1 E'
  * robot: new Robot 3, 2, \N
    instructions: \FRRFLLFFRRFLL
    expected: '3 3 N LOST'
  * robot: new Robot 0, 3, \W
    instructions: \LLFFFLFLFL
    expected: '2 3 S'

directions = 'N': 'North' 'S': 'South' 'E': 'East' 'W': 'West'

describe 'Given a new Grid with length 5 and heigth 3' ->

  describe 'With 3 robots' ->
    cases.map (r) ->
      grid.add-robot r.robot, r.instructions

    cases.map (r, i) ->

      describe "A robot ##{i+1}, started at X: #{r.robot.x}, Y: #{r.robot.y}" ->
        props = r.expected.split ' '
        expected = x: props.0, y: props.1, facing: props.2

        specify "It should be positioned at X: #{expected.x}, Y: #{expected.y},
                 facing #{directions[expected.facing]}" ->
          expect grid.robots[i].get-coordinates! .to .equal r.expected
