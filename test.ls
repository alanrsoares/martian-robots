require! {
  './src/grid': { Grid }
  './src/robot': { Robot }
}

grid = new Grid 5, 3

robots =
  * robot: new Robot 1, 1, \E
    instructions: \RFRFRFRF
    expected: '1 1 E'
  * robot: new Robot 3, 2, \N
    instructions: \FRRFLLFFRRFLL
    expected: '3 3 N LOST'
  * robot: new Robot 0, 3, \W
    instructions: \LLFFFLFLFL
    expected: '2 3 S'

console.log "
  Sample input:   \n
  5 3             \n
  1 1 E           \n
  RFRFRFRF        \n
                  \n
  3 2 N           \n
  FRRFLLFFRRFLL   \n
                  \n
  0 3 W           \n
  LLFFFLFLFL      \n
                  \n
  Sample Output:
"

robots.map (r) ->
  grid.add-robot r.robot, r.instructions

grid.robots.map (r, i) ->
  console.log r.get-coordinates! + ' -> ' + robots[i].expected

#console.log grid
