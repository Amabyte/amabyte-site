class AB.App

  constructor: ->
    @fixWelcomeHeight()

  fixWelcomeHeight: ->
    $(".welcome").css "min-height", $(window).outerHeight() - $(".ab-navbar").outerHeight()