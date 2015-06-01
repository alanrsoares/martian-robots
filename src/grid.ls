MAX_BOUND = 50
MIN_BOUND = 1

export class Grid
  (l = 0, h = 0) ->
    throw 'Invalid dimensions'               if isNaN l       or isNaN h
    throw 'Grid cannot be larger than 50x50' if l > MAX_BOUND or h > MAX_BOUND
    throw 'Grid cannot be smaller than 1x1'  if l < MIN_BOUND or h < MIN_BOUND

    @length = l
    @heigth = h
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
