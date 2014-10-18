class AB.App

  constructor: ->
    @fixWelcomeHeight()

  fixWelcomeHeight: ->
    diff = $(window).outerHeight() - ($(".welcome").outerHeight() + $(".ab-navbar").outerHeight())
    $(".col-welcome").css "min-height", $(".welcome").height()+diff
