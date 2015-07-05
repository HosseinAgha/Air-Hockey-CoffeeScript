Node = require './Node'
module.exports = class Ball extends Node
  constructor: (@_parent, @_radius) ->
    super @_parent, "ball"
    @setSize @_radius
    @setPosWithString("calc(50% - #{@_radius}px)", "calc(50% - #{@_radius}px)")

  getVelX: () ->
    @_velx

  getVelY: () ->
    @_vely

  getRadius: () ->
    @_radius

  adjustVelocity: (@_velx, @_vely) ->
    @_velx ?= 0
    @_vely ?= 0
    this

  setSize: (width) ->
    @_radius = width / 2
    @setStyle "width", "#{width}px"
    @setStyle "height", "#{width}px"

  oneFrameMove: () ->
    @adjustPosition(@_velx, @_vely)
