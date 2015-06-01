require! {
  'readline'
  'figlet'
  './grid': { Grid }
  './robot': { Robot }
}

rl = readline.create-interface input: process.stdin, output: process.stdout

add-robot = (grid) ->
  added = grid.robots.length + 1
  rl.question "Enter robot position ##{added}: ", (position) ->
    coordinates = position.split ' '
    x = coordinates.0
    y = coordinates.1
    facing = coordinates.2

    robot = new Robot x, y, facing

    rl.question 'Add movement instructions: ', (instructions) ->
      throw 'Instructions length exceeded' if instructions.length > 100
      grid.add-robot robot, instructions
      rl.question 'Add new robot? (Y/n): ' (answer) ->
        if answer.to-upper-case! is 'N' then
          grid.robots.for-each (robot) -> console.log robot.get-coordinates!
          rl.close!
        else return add-robot grid

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
