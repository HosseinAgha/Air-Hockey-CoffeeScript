module.exports = class Emitter
  constructor: () ->
    @events = {}

  on: (event, callback) ->
    unless @events[event]?
      @events[event] = []

    @events[event].push callback

    return

  emit: (event, payload) ->
    if @events[event]?
      for callback in @events[event]
        callback payload

    return

