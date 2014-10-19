class AB.App

  constructor: ->
    @fixWelcomeHeight()
    @fixBlockBodyHeight()
    @makeNavbarSticky()
    @makeTechnologyFly()
    U.resize @onResize

  onResize: =>
    @fixWelcomeHeight()
    @fixBlockBodyHeight()

  fixWelcomeHeight: ->
    diff = $(window).outerHeight() - ($(".welcome").outerHeight() + $(".ab-navbar").outerHeight())
    $(".col-welcome").css "min-height", $(".welcome").height()+diff

  fixBlockBodyHeight: ->
    blocks = $(".block .body")
    blocks.removeAttr "style"
    unless U.isScreen()
      maxHeight = Math.max.apply null, blocks.map(->
        $(this).outerHeight()
      ).get()
      blocks.css("min-height", maxHeight)

  makeNavbarSticky: ->
    $(".ab-navbar").affix offset:
      top: $(".welcome").outerHeight()

  makeTechnologyFly: ->
    $(".wheel-button + ul .remove-mob").remove() if U.isScreen "mob"
    wheelButton = $(".wheel-button")
    wheelButton.bind "click", (event)->
      event.preventDefault()
    wheelButton.wheelmenu
      trigger: if U.isScreen() then "click" else "hover"
      animation: "fly"
      animationSpeed: "fast"
      angle: "all"