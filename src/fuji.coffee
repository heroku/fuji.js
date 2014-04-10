window.gravatar = require('gravatar')
window.domready = require('domready')

class Fuji

  constructor: (@options={}) ->
    @getUser()
    @getLogoutLink()
    @attachElement()

    avatar_element = document.querySelector('.fuji-avatar')
    
    if avatar_element?
      # Open avatar modal when user clicks avatar
      avatar_element.addEventListener 'click', (event) ->
        document.querySelector('.fuji-avatar-modal').classList.toggle('active')
        event.stopPropagation()

      # Close avatar modal when user clicks outside it
      document.addEventListener 'click', (event) ->
        document.querySelector('.fuji-avatar-modal').classList.remove('active')

  getUser: =>
    dataEl = document.querySelector("[data-fuji-email]")
    if dataEl && dataEl.dataset.fujiEmail.length > 0
      @user =
        email: dataEl.dataset.fujiEmail

  getLogoutLink: =>
    dataEl = document.querySelector("[data-fuji-logout]")
    if dataEl && dataEl.dataset.fujiLogout.length > 0
      @logoutLink = dataEl.dataset.fujiLogout
    else
      @logoutLink = "//dashboard.heroku.com/logout"

  attachElement: =>
    @el = document.createElement("div")
    @el.classList.add("fuji")
    @el.classList.add("anonymous") unless @user
    @el.id = "fuji"

    if document.querySelector("[data-fuji-no-links]")
      links = ""
    else
      links = """
        <li><a href="https://dashboard.heroku.com" class="apps">Apps</a></li>
        <li><a href="https://addons.heroku.com" class="addons">Add-ons</a></li>
        <li><a href="https://devcenter.heroku.com" class="documentation">Documentation</a></li>
        <li><a href="https://help.heroku.com" class="support">Support</a></li>
        <li><a href="https://dashboard.heroku.com" id="notification-center-toggler" class="notification-center">&nbsp;</a></li>
      """

    @el.innerHTML = """
      <div class="fuji-container">
        <h1 class="fuji-brand">
          <a class="fuji-logo" href="/">
            heroku <span class="fuji-logo-subtext">help</span>
          </a>
        </h1>
        <ul class="fuji-links">
          #{links}
          #{@loginLink()}
        </ul>

        #{@avatar()}
        #{@avatarModal()}
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

  avatarModal: =>
    return "" unless @user
    """
      <ul class="fuji-avatar-modal">
        <li><a href="//dashboard.heroku.com/account">Account</a></li>
        #{@logoutLink()}
      </ul>
    """

  logoutLink: =>
    return "" unless @user
    """
      <li><a href="{@logoutLink}">Logout</a></li>
    """

  loginLink: =>
    return "" if @user
    """
      <li><a href="https://id.heroku.com" class="login">Log In</a></li>
    """

  @init: (options={}) ->
    window.fuji = new Fuji(options)

domready(Fuji.init)
