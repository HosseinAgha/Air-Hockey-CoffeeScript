module.exports = class Node
  ###*
   * an Http DOM Element
   * @param  {HTTP Element} @_parent parent of the carrent element
   * @param  {String} @_style  CSS Style Class of node
  ###
  constructor: (@_parent, @_style, @_x, @_y) ->
    @_parent ?= document.body
    @_style ?= ""
    @_x ?= 50
    @_y ?= 50
    @_prepareNode()

  _prepareNode: () ->
    @_node = document.createElement "div"
    @setPosition @_x, @_y
    @addStyle @_style
    @_parent.appendChild @_node

  getX: () ->
    @_x

  getY: () ->
    @_y

  setStyle: (prop, val) ->
    @_node.style[prop] = val

    this

  addStyle: (styleClass) ->
    if @_node? and styleClass?
      @_node.classList.add styleClass

    this

  setPosition: (@_x, @_y) ->
    @setStyle("left", @_x + "px")
    @setStyle("top", @_y + "px")

    this

  setPosWithString: (x, y) ->
    @setStyle("left", x)
    @setStyle("top", y)
    @_x = @_node.offsetLeft + @_node.clientLeft
    @_y = @_node.offsetTop + @_node.clientTop
    this

  adjustPosition: (x, y) ->
    @setPosition @_x += x, @_y += y















