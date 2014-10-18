class AB.App

  constructor: ->
    @fixWelcomeHeight()
    @fixBlockBodyHeight()
    @makeNavbarSticky()
    U.resize @onResize

  onResize: =>
    @fixWelcomeHeight()
    @fixBlockBodyHeight()

  fixWelcomeHeight: ->
    diff = $(window).outerHeight() - ($(".welcome").outerHeight() + $(".ab-navbar").outerHeight())
    $(".col-welcome").css "min-height", $(".welcome").height()+diff

  fixBlockBodyHeight: ->
    blocks = $(".blocks .body")
    blocks.removeAttr "style"
    unless U.isScreen()
      maxHeight = Math.max.apply null, blocks.map(->
        $(this).outerHeight()
      ).get()
      blocks.css("min-height", maxHeight)

  makeNavbarSticky: ->
    $(".ab-navbar").affix offset:
      top: $(".welcome").outerHeight()
