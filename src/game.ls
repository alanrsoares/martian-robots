require! {
  'readline'
  'figlet'
  './grid': { Grid }
  './robot': { Robot }
}

rl = readline.create-interface input: process.stdin, output: process.stdout

add-robot = (grid) ->
  added = grid.robots.length + 1

  console.log "Robot ##{added}"

  position <- rl.question 'Enter robot position: '
  [ x, y, facing ] = position.split ' '
  robot = new Robot x, y, facing

  instructions <- rl.question 'Add movement instructions: '
  grid.add-robot robot, instructions

  answer <- rl.question 'Add new robot? (Y/n): '
  if answer.to-upper-case! is 'N' then
    console.log '\nRobots coordinates:'
    grid.robots.for-each (robot) -> console.log robot.get-coordinates!
    return rl.close!

  add-robot grid

show-help = ->
  console.log "
  ╔═══════════════════╦════════════════════════════════════╗\n
  ║ Mars surface size ║                                    ║\n
  ╠═══════════════════╝                                    ║\n
  ║ Format  : length heigth                                ║\n
  ║ Default : 50 50                                        ║\n
  ╠═══════════════════╦════════════════════════════════════╣\n
  ║ Robot position    ║                                    ║\n
  ╠═══════════════════╝                                    ║\n
  ║ Format  : x y orientation                              ║\n
  ║ Example : 1 1 E                                        ║\n
  ║ Note    : Orientation must be one of N, S, E or W      ║\n
  ║ corresponding to North, South, East or West            ║\n
  ╠═══════════════════╦════════════════════════════════════╣\n
  ║ Instructions      ║                                    ║\n
  ╠═══════════════════╝                                    ║\n
  ║ Example : RFRFRFLF                                     ║\n
  ║ Note    : A series of movement instructions consisting ║\n
  ║ of the characters R: Right, L: Left, and F: Forward    ║\n
  ╚════════════════════════════════════════════════════════╝\n
  "

init = ->
  figlet.text 'Martian\n Robots', { font: 'Delta Corps Priest 1' }, (err, data) ->
    console.log data
    console.log ''

    view-help <- rl.question 'View game help? (y/N): '
    if view-help.to-lower-case! is 'y' then
      show-help!

    play <- rl.question 'Hit [enter] to continue or ctrl+c to exit'
    console.log ''

    size <- rl.question 'Enter Mars surface size: (50 50) '
    [ length, heigth ] = (size or '50 50').split ' '
    grid = new Grid length, heigth
    add-robot grid

# init game
init!
