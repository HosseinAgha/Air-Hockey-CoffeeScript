Node = require './Node'

module.exports = class Paddle extends Node
  ###*
   * @param  {[int]} @_place  paddle position in percentages
  ###
  constructor: (@_parent, @_pos, @_place, @_size) ->
    super @_parent, "paddle"
    @_speed = 1
    @_paddWidth = 17
    @_place ?= 50
    @setStyle "width", "#{@_paddWidth}px"
    @adjustSize @_size

  getPaddWidth: () ->
    @_paddWidth

  getPaddSize: () ->
    @_size

  getSpeed: () ->
    @_speed


  adjustSize: (@_size) ->
    @_size ?= 50
    @setStyle "height", "#{@_size}px"

  adjustSpeed: (@_speed) ->
    @_speed ?= 1

  moveUp: () ->
    if @getY() > 0
      @adjustPosition(0, -@_speed)

  moveDown: () ->
    # console.log "hh #{@_parent.clientHeight}"
    if @getY() + @_size < @_parent.clientHeight
      @adjustPosition(0, @_speed)



