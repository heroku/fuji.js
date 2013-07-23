class Fuji

  constructor: (@options={}) ->
    @getUser()
    @attachElement()

  getUser: =>
    dataEl = document.querySelector("[data-fuji-email-hash]")
    if dataEl
      @user =
        emailHash: dataEl.dataset.fujiEmailHash

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
          #{@loginLink()}
        </ul>

        #{@avatar()}

      </div>
    """
    document.querySelector("body").appendChild(@el)

  avatar: =>
    return "" unless @user
    defaultAvatar = "https://s3.amazonaws.com/assets.heroku.com/addons.heroku.com/gravatar_default.png"
    url = "https://secure.gravatar.com/avatar/#{@user.emailHash}?default=#{defaultAvatar}"
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

module.exports = Fuji