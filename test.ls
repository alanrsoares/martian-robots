require! {
  './src/grid': { Grid }
  './src/robot': { Robot }
}

grid = new Grid 5, 3

robots =
  * robot: new Robot 1, 1, \E
    instructions: \RFRFRFRF
  * robot: new Robot 3, 2, \N
    instructions: \FRRFLLFFRRFLL
  * robot: new Robot 0, 3, \W
    instructions: \LLFFFLFLFL

console.log "
  INPUT:          \n
                  \n
  5 3             \n
                  \n
  1 1 E           \n
  RFRFRFRF        \n
                  \n
  3 2 N           \n
  FRRFLLFFRRFLL   \n
                  \n
  0 3 W           \n
  LLFFFLFLFL      \n
                  \n
  OUTPUT:         \n
"

robots.map (r) ->
  grid.add-robot r.robot, r.instructions

grid.robots.map (r) ->
  console.log r.get-coordinates!
