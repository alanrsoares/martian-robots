turn-map = do
  'N': <[ W E ]>
  'E': <[ N S ]>
  'S': <[ E W ]>
  'W': <[ S N ]>

export class Robot
  (@x, @y, @facing) ->
    error-prefix = 'Invalid coordinates: one or more coordinates'
    throw "#{error-prefix} are not valid numbers" if isNaN @x or isNaN @y
    throw "#{error-prefix} are negative numbers" if @x < 0 or @y < 0
    @is-lost = false

  get-coordinates: ->
    "#{@x} #{@y} #{@facing} #{if @is-lost then 'LOST' else ''}".trim!

  execute: (instructions, grid) ->
    throw 'Instructions length exceeded' if instructions.length > 100
    instructions.split ''
                .map (.to-upper-case!)
                .for-each (-> @move it, grid).bind @

  turn: (instruction) ->
    @facing = turn-map[@facing][+(instruction is 'R')]

  move: (instruction, grid) ->
    return false if @is-lost or grid.has-lost-robot-scent @get-coordinates!

    if instruction is not 'F' then
      @turn instruction
    else
      @move-forward grid

  move-forward: (grid) ->
    last-coordinates = @get-coordinates!

    match @facing
    | 'N' => @y++
    | 'E' => @x++
    | 'S' => @y--
    | 'W' => @x--

    if grid.is-robot-lost @ then
      @is-lost = true
      grid.add-lost-robot-scent last-coordinates
      #reset to last coordinates
      coordinates = last-coordinates.split ' '
      @x = coordinates.0
      @y = coordinates.1
