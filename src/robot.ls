turn-map = do
  'N': <[ W E ]>
  'E': <[ N S ]>
  'S': <[ E W ]>
  'W': <[ S N ]>

is-valid-orientation = (orientation) ->
  Object.keys(turn-map).some (k) -> k is orientation

export class Robot
  (@x, @y, @facing = 'N') ->
    error-prefix = 'Invalid coordinates: one or more coordinates'
    throw new Error "#{error-prefix} are not valid numbers" if isNaN @x or isNaN @y
    throw new Error "#{error-prefix} are negative numbers"  if @x < 0 or @y < 0
    throw new Error "#{@facing} is not a valid orientation" if not is-valid-orientation @facing
    @is-lost = false

  get-coordinates: ->
    "#{@x} #{@y} #{@facing} #{if @is-lost then 'LOST' else ''}".trim!

  execute: (instructions, grid) ->
    throw 'Instructions length exceeded' if instructions.length > 100
    instructions.split ''
                .map (.to-upper-case!)
                .map (-> @move it, grid).bind @

  turn: (direction) ->
    @facing = turn-map[@facing][+(direction is 'R')]

  move: (instruction, grid) ->
    return if @is-lost

    if instruction is 'F' then
      @move-forward grid
    else
      @turn instruction

  move-forward: (grid) ->
    last-coordinates = @get-coordinates!

    return if grid.has-lost-robot-scent last-coordinates

    match @facing
    | 'N' => ++@y
    | 'E' => ++@x
    | 'S' => --@y
    | 'W' => --@x

    if grid.is-robot-lost @ then
      @is-lost = true
      grid.add-lost-robot-scent last-coordinates
      #reset to last coordinates
      coordinates = last-coordinates.split ' '
      @x = coordinates.0
      @y = coordinates.1
