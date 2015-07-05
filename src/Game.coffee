Ball = require './Ball'
Paddle = require './Paddle'
Emitter = require './Emitter'

module.exports = class Game
  constructor: () ->
    @eventListener = new Emitter()
    @_ball = new Ball(document.body, 50)
    @_LPaddle = new Paddle(document.body, "left", 50, 70)
    @_RPaddle = new Paddle(document.body, "right", 50, 70)
    @scores = {left: 0, right: 0}
    @_rDirKeys = {up: false, down: false, left: false}
    @_lDirKeys = {up: false, down: false, right: false}

    # Hint Texts
    @_enterHint = document.getElementById("StartHint")
    @_enterHint.style.left = "calc(50% - #{@_enterHint.clientWidth / 2}px)"
    @_ballSpeedHint = document.createElement "label"
    document.body.appendChild @_ballSpeedHint
    @_ballSpeedHint.classList.add "hintText"
    @_ballSpeedHint.style.top = "8px"
    @_ballSpeedHint.style.left = "8px"
    # Create score boards
    @_LScoreBoard = document.createElement "label"
    document.body.appendChild @_LScoreBoard
    @_LScoreBoard.classList.add "scores"
    @_LScoreBoard.style.left = "calc(50% - 80px)"
    @_RScoreBoard = document.createElement "label"
    document.body.appendChild @_RScoreBoard
    @_RScoreBoard.classList.add "scores"
    @_RScoreBoard.style.left = "calc(50% + 60px)"
    @_LScoreBoard.innerHTML = @scores.left
    @_RScoreBoard.innerHTML = @scores.right

    # Add event listeners to move paddles
    document.addEventListener "keydown" , (e) =>
      if e.keyCode == 38  # up arrow
        @_rDirKeys.up = true
      if e.keyCode == 37 # left arrow
        @_rDirKeys.left = true
      if e.keyCode == 40  # down arrow
        @_rDirKeys.down = true
      if e.keyCode == 87  # w
        @_lDirKeys.up = true
      if e.keyCode == 68  # d
        @_lDirKeys.right = true
      if e.keyCode == 83  # s
        @_lDirKeys.down = true
    document.addEventListener "keyup" , (e) =>
      if e.keyCode == 38
        @_rDirKeys.up = false
      if e.keyCode == 37 # left arrow
        @_rDirKeys.left = false
      if e.keyCode == 40
        @_rDirKeys.down = false
      if e.keyCode == 87
        @_lDirKeys.up = false
      if e.keyCode == 68  # d
        @_lDirKeys.right = false
      if e.keyCode == 83
        @_lDirKeys.down = false

  reInitialize: (ballSize, ballVelx, ballVely, paddSize, paddSpeed) ->
    @_enterHint.style.display = "inline"
    @_ball.setSize(ballSize)
    @_ball.adjustVelocity(ballVelx, ballVely)
    @_ball.setPosWithString("calc(50% - #{@_ball.getRadius()}px)", "calc(50% - #{@_ball.getRadius()}px)")
    @_LPaddle.adjustPosition(10, -@_ball.getRadius() * 2)
    @_RPaddle.adjustPosition(-10, -@_ball.getRadius() * 2)
    @_LPaddle.setPosWithString "10px", "calc(#{@_LPaddle._place}% - #{@_ball.getRadius() * 2}px)"
    @_RPaddle.setPosWithString "calc(100% - #{@_RPaddle.getPaddWidth() + 10}px)", "calc(#{@_RPaddle._place}% - #{@_ball.getRadius() * 2}px)"
    @_LPaddle.adjustSize(paddSize)
    @_RPaddle.adjustSize(paddSize)
    @_LPaddle.adjustSpeed(paddSpeed)
    @_RPaddle.adjustSpeed(paddSpeed)

    return this

  getLeftScore: () ->
    return @scores["left"]

  getRightScore: () ->
    return @scores["right"]

  start: () ->
    @_ballSpeedHint.innerHTML = "Ball Speed is: #{(Math.sqrt(Math.pow(@_ball.getVelX(), 2), Math.pow(@_ball.getVelY(), 2))).toPrecision(3)}"
    @_ballSpeedHint.style.display = "inline"
    @_enterHint.style.display = "none"
    @winner = "none"
    @_ball.oneFrameMove()
    requestAnimationFrame @_gameLoop

  _gameLoop: () =>
    # console.log "ball's x is #{@_ball.getX()}"
    # console.log "ball's y is #{@_ball.getY()}"
    if @_rDirKeys.up
      @_RPaddle.moveUp()
    if @_rDirKeys.down
      @_RPaddle.moveDown()
      # console.log @_RPaddle.getY()
    if @_lDirKeys.up
      @_LPaddle.moveUp()
    if @_lDirKeys.down
      @_LPaddle.moveDown()

    if (@winner = @_checker()) == "none"
      @_ball.oneFrameMove()
      requestAnimationFrame @_gameLoop
    else
      @scores[@winner]++
      @_LScoreBoard.innerHTML = @scores.left
      @_RScoreBoard.innerHTML = @scores.right
      @eventListener.emit "scored", @winner
      @_ballSpeedHint.style.display = "none"


  ###*
   * Checks if any player has won the game
   * and reflects the ball on collision
   * @return {string} [the winner side]
  ###
  _checker: () ->
    # console.log "cheking"
    if @_ball.getX() <= 0
      # We have a winner!!!!!! :)
      return @winner = "right"
    if @_ball.getX() + @_ball.getRadius() * 2 >= document.body.clientWidth
      # We have a winner!!!!!! :)
      return @winner = "left"

    # Check if ball has a collision with top or bottom
    if @_ball.getY() <= 0 or @_ball.getY() + @_ball.getRadius() * 2 >= document.body.clientHeight
      @_ball.adjustVelocity @_ball.getVelX(), @_ball.getVelY() * (-1)

    # Check if it is a goal or the ball has a collision with paddles
    if ((@_ball.getX() + @_ball.getRadius() * 2 > @_RPaddle.getX()) and
    @_ball.getVelX() > 0 and
    @hasPaddCollision("right"))
      @collisionHandler()
    if (@_ball.getX() < @_LPaddle.getX() + @_LPaddle.getPaddWidth() and
    @_ball.getVelX() < 0 and
    @hasPaddCollision("left"))
      # Paddle collision!!!
      @collisionHandler()
    "none"

  collisionHandler: () ->
    @_LPaddle.adjustSpeed(@_LPaddle.getSpeed() + @_LPaddle.getSpeed()*0.03)
    @_RPaddle.adjustSpeed(@_RPaddle.getSpeed() + @_RPaddle.getSpeed()*0.03)
    @_ball.adjustVelocity(@_ball.getVelX() + (@_ball.getVelX()*0.05), @_ball.getVelY() + (@_ball.getVelY()*0.05))
    @_ball.adjustVelocity @_ball.getVelX() * -1, @_ball.getVelY()
    @_ballSpeedHint.innerHTML = "Ball Speed is: #{(Math.sqrt(Math.pow(@_ball.getVelX(), 2), Math.pow(@_ball.getVelY(), 2))).toPrecision(3)}"


  hasPaddCollision: (side) ->
    rad = @_ball.getRadius()
    ballVelx = @_ball.getVelX()
    ballVely = @_ball.getVelY()
    if side == "left"
      if (@_ball.getY() + rad >= @_LPaddle.getY()) and
      (@_ball.getY() + rad <= @_LPaddle.getY() + @_LPaddle.getPaddSize())
        if @_lDirKeys.right
          @_ball.adjustVelocity(ballVelx, ballVely + (ballVely * 0.05) * -1)
          console.log "adjusted"
        if @_lDirKeys.up
          @_ball.adjustVelocity(ballVelx, Math.abs(ballVely) * -1)
        else if @_lDirKeys.down
          @_ball.adjustVelocity(ballVelx, Math.abs(ballVely))
        return true
    else if side == "right"
      if @_ball.getY() + rad >= @_RPaddle.getY() and
      @_ball.getY() + rad <= @_RPaddle.getY() + @_RPaddle.getPaddSize()
        if @_rDirKeys.left
          @_ball.adjustVelocity(ballVelx, ballVely + (ballVely * 0.05) * -1)
          console.log "adjusted"
        if @_rDirKeys.up
          @_ball.adjustVelocity(ballVelx, (Math.abs(ballVely) * -1))
        else if @_rDirKeys.down
          @_ball.adjustVelocity(ballVelx, Math.abs(ballVely))
        return true
    false








