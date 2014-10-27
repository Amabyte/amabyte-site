class AB.App

  constructor: ->
    @fixWelcomeHeight()
    @fixBlockBodyHeight()
    @makeNavbarSticky()
    @makeTechnologyFly()
    @enableValidationOnContactUs()
    @makeContactUsSubmit()
    @setUpMenuNavigation()
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

  enableValidationOnContactUs: ->
    U.enableValidation($("form.contact-us"))

  makeContactUsSubmit: ->
    form = $("form.contact-us")
    @submitButton = Ladda.create($("button", form)[0])
    _this = @
    form.submit (event)->
      event.preventDefault()
      unless form.data('bootstrapValidator').isValid()
        return
      _this.submitButton.start()
      name = $("#contact-name", form).val()
      emailOrPhone = $("#contact-email", form).val()
      message = $("#contact-message", form).val()
      requestBody = {name: name, from: emailOrPhone, message: message}
      U.api
        url: "/contact_us.json"
        type: "POST"
        data: JSON.stringify(requestBody)
        success: (data) ->
          _this.showContactUsSuccess data.message
          form[0].reset()
          form.data('bootstrapValidator').resetForm()
        complete: ->
          _this.submitButton.stop()

  showContactUsSuccess: (msg) ->
    successNotice = $(".contact-column .notice")
    successNotice.text msg
    successNotice.slideDown ->
      setTimeout ->
        successNotice.slideUp()
      , 5000

  setUpMenuNavigation: ->
    _this = @
    $(window).scroll ->
      if _this.isViewVisible("#contact-us")
        _this.changeMenuActive "#contact-us-menu"
      else if _this.isViewVisible("#about")
        _this.changeMenuActive "#about-menu"
      else if _this.isViewVisible("#welcome")
        _this.changeMenuActive "#welcome-menu"

  isViewVisible: (elem) ->
    docViewTop = $(window).scrollTop()
    docViewBottom = docViewTop + $(window).height()
    elemTop = $(elem).offset().top
    elemBottom = elemTop + $(elem).height()
    (elemBottom <= docViewBottom) and (elemTop >= docViewTop)

  changeMenuActive: (elem) ->
    $(".navbar-nav li").removeClass("active")
    $(elem).addClass("active")