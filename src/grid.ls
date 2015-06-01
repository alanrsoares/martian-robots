MAX = 50
MIN = 1

export class Grid
  (@length = 0, @heigth = 0) ->
    throw 'Invalid dimensions'               if isNaN @length or isNaN @heigth
    throw 'Grid cannot be larger than 50x50' if @length > MAX or @heigth > MAX
    throw 'Grid cannot be smaller than 1x1'  if @length < MIN or @heigth < MIN

    @robots = []
    @lost-robot-coordinates = []

  add-robot: (robot, instructions) ->
    @robots.push robot
    if instructions then robot.execute instructions, @

  add-lost-robot-scent: (coordinates) ->
    @lost-robot-coordinates.push coordinates

  has-lost-robot-scent: (coordinates) ->
    @lost-robot-coordinates.length and
    @lost-robot-coordinates.index-of coordinates > -1
    
  is-robot-lost: (robot) ->
    robot.x > @length or
    robot.y > @heigth
