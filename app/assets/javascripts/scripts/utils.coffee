window.U = 
  resize: (callback) ->
    $(window).resize $.throttle(250, callback)

  isScreen: (type = "tab_or_mob") ->
    if type is "tab"
      U.isScreen("tab_or_mob") && !U.isScreen("mob")
    else if type is "mob"
      $(window).width() < 768
    else if type is "tab_or_mob"
      $(window).width() < 992
    else if type is "desk"
      $(window).width() >= 992
    else if type is "desk-small"
      $(window).width() < 1130 and U.isScreen("desk")
    else
      throw new Error("Unknown screen")