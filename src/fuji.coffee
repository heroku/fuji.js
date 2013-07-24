window.gravatar = require('gravatar')

class Fuji

  constructor: (@options={}) ->
    @getUser()
    @attachElement()

  getUser: =>
    dataEl = document.querySelector("[data-fuji-email]")
    if dataEl
      @user =
        email: dataEl.dataset.fujiEmail

  attachElement: =>
    @el = document.createElement("div")
    @el.className = "fuji"
    @el.id = "fuji"
    @el.innerHTML = """
      <div class="fuji-container">
        <h1 class="fuji-brand">
          <a class="fuji-logo" href="/">
            heroku <span class="fuji-logo-subtext">help</span>
          </a>
        </h1>
        <ul class="fuji-links">
          <li><a href="https://dashboard.heroku.com" class="apps">Apps</a></li>
          <li><a href="https://addons.heroku.com" class="addons">Add-ons</a></li>
          <li><a href="https://devcenter.heroku.com" class="documentation">Documentation</a></li>
          <li><a href="https://help.heroku.com" class="support">Support</a></li>
          <li><a href="https://dashboard.heroku.com" id="notification-center-toggler" class="notification-center">&nbsp;</a></li>
          #{@loginLink()}
        </ul>

        #{@avatar()}
      </div>
    """
    document.querySelector("body").appendChild(@el)

  avatar: =>
    return "" unless @user
    url = gravatar.url(@user.email, {size: '100', default: "https://s3.amazonaws.com/assets.heroku.com/addons.heroku.com/gravatar_default.png"}, true)
    """
      <a class="fuji-avatar" href="#">
        <img src="#{url}">
      </a>
    """

  loginLink: =>
    return "" if @user
    """
      <li><a href="https://id.heroku.com" class="login">Log In</a></li>
    """

  @init: (options={}) ->
    window.fuji = new Fuji(options)

if document.readyState is "complete"
  Fuji.init()
else
  document.addEventListener "DOMContentLoaded", Fuji.init


