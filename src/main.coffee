Game = require './Game'

game1 = new Game()

game1.reInitialize(50, 5, 5, 100, 8)

isPlaying = false

document.addEventListener "keypress", (e) ->
  if e.keyCode == 13    # If the pressed key was Enter
    if not isPlaying
      isPlaying = true
      game1.start()

game1.eventListener.on "scored", (winner) ->
  game1.reInitialize(50, 5, 5, 100, 8)
  isPlaying = false









