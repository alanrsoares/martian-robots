require! {
  'readline'
  'figlet'
  './grid': { Grid }
  './robot': { Robot }
}

rl = readline.create-interface input: process.stdin, output: process.stdout

add-robot = (grid) ->
  added = grid.robots.length + 1

  position <- rl.question "Enter robot position ##{added}: "
  coordinates = position.split ' '
  robot = new Robot coordinates.0, coordinates.1, coordinates.2

  instructions <- rl.question 'Add movement instructions: '
  grid.add-robot robot, instructions

  answer <- rl.question 'Add new robot? (Y/n): '
  if answer.to-upper-case! is 'N' then
    console.log '\nRobots coordinates:'
    grid.robots.for-each (robot) -> console.log robot.get-coordinates!
    return rl.close!

  add-robot grid

init = ->
  figlet.text 'Martian\n Robots', { font: 'Delta Corps Priest 1' }, (err, data) ->
    console.log data
    console.log ''

    rl.question 'Enter Mars surface size: (50 50) ', (size) ->
      dimensions = (size or '50 50').split ' '
      grid = new Grid dimensions.0, dimensions.1
      add-robot grid

# init game
init!
