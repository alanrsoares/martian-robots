turn-map = do
  'R': do
    'N': 'E'
    'E': 'S'
    'S': 'W'
    'W': 'N'
  'L': do
    'N': 'W'
    'W': 'S'
    'S': 'E'
    'E': 'N'

export class Robot
  (@x, @y, @facing) ->
    @is-lost = false

  get-coordinates: ->
    "#{@x} #{@y} #{@facing} #{if @is-lost then 'LOST' else ''}"

  execute: (instructions, grid) ->
    move = (instruction) -> @move instruction, grid
    instructions.split('').for-each move.bind @

  move: (instruction, grid) ->
    return false if @is-lost

    if instruction is not 'F' then
      @facing = turn-map[instruction][@facing]
    else if !grid.has-lost-robot-scent @get-coordinates! then
        @move-forward grid

  move-forward: (grid) ->
    last-coordinates = @get-coordinates!

    match @facing
    | 'N' => @y++
    | 'S' => @y--
    | 'E' => @x++
    | 'W' => @x--

    if grid.is-robot-lost @ then
      @is-lost = true
      grid.add-lost-robot-scent last-coordinates
      #reset to last coordinates
      coordinates = last-coordinates.split ' '
      @x = coordinates.0
      @y = coordinates.1
