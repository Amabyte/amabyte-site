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
      
  enableValidation: (view, options = {}) ->
    default_opt = 
      feedbackIcons:
        valid: "glyphicon glyphicon-ok"
        invalid: "glyphicon glyphicon-remove"
        validating: "glyphicon glyphicon-refresh"
    view.bootstrapValidator $.extend({}, default_opt, options)

  api: (options = {}) ->
    defaultError = options.error
    delete options.error
    unless defaultError
      defaultError = (data) ->
        U.showMsgPop()
    default_opt =
      type: "GET"
      contentType: "application/json"
      accept: "application/json"
      dataType: "json"
      error: (data) ->
        defaultError data
    $.ajax $.extend({}, default_opt, options)

  showMsgPop: (msg="Request could not be processed.\nPlease try again") ->
    alert msg