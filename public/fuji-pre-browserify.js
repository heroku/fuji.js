(function() {
  var Fuji,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Fuji = (function() {
    function Fuji(options) {
      this.options = options != null ? options : {};
      this.loginLink = __bind(this.loginLink, this);
      this.avatar = __bind(this.avatar, this);
      this.attachElement = __bind(this.attachElement, this);
      this.getUser = __bind(this.getUser, this);
      this.getUser();
      this.attachElement();
    }

    Fuji.prototype.getUser = function() {
      var dataEl;
      dataEl = document.querySelector("[data-fuji-email-hash]");
      if (dataEl) {
        return this.user = {
          emailHash: dataEl.dataset.fujiEmailHash
        };
      }
    };

    Fuji.prototype.attachElement = function() {
      this.el = document.createElement("div");
      this.el.className = "fuji";
      this.el.id = "fuji";
      this.el.innerHTML = "<div class=\"fuji-container\">\n\n  <h1 class=\"fuji-brand\">\n    <a class=\"fuji-logo\" href=\"/\">\n      heroku <span class=\"fuji-logo-subtext\">help</span>\n    </a>\n  </h1>\n\n  <ul class=\"fuji-links\">\n    <li><a href=\"https://dashboard.heroku.com\" class=\"apps\">Apps</a></li>\n    <li><a href=\"https://addons.heroku.com\" class=\"addons\">Add-ons</a></li>\n    <li><a href=\"https://devcenter.heroku.com\" class=\"documentation\">Documentation</a></li>\n    <li><a href=\"https://help.heroku.com\" class=\"support\">Support</a></li>\n    " + (this.loginLink()) + "\n  </ul>\n\n  " + (this.avatar()) + "\n\n</div>";
      return document.querySelector("body").appendChild(this.el);
    };

    Fuji.prototype.avatar = function() {
      var defaultAvatar, url;
      if (!this.user) {
        return "";
      }
      defaultAvatar = "https://s3.amazonaws.com/assets.heroku.com/addons.heroku.com/gravatar_default.png";
      url = "https://secure.gravatar.com/avatar/" + this.user.emailHash + "?default=" + defaultAvatar;
      return "<a class=\"fuji-avatar\" href=\"#\">\n  <img src=\"" + url + "\">\n</a>";
    };

    Fuji.prototype.loginLink = function() {
      if (this.user) {
        return "";
      }
      return "<li><a href=\"https://id.heroku.com\" class=\"login\">Log In</a></li>";
    };

    Fuji.init = function(options) {
      if (options == null) {
        options = {};
      }
      return window.fuji = new Fuji(options);
    };

    return Fuji;

  })();

  module.exports = Fuji;

  window.gravatar = require('gravatar');

  Fuji = (function() {
    function Fuji(options) {
      this.options = options != null ? options : {};
      this.loginLink = __bind(this.loginLink, this);
      this.avatarModal = __bind(this.avatarModal, this);
      this.avatar = __bind(this.avatar, this);
      this.attachElement = __bind(this.attachElement, this);
      this.getUser = __bind(this.getUser, this);
      this.getUser();
      this.attachElement();
      document.querySelector('.fuji-avatar').addEventListener('click', function(event) {
        document.querySelector('.fuji-avatar-modal').classList.toggle('active');
        return event.stopPropagation();
      });
      document.addEventListener('click', function(event) {
        return document.querySelector('.fuji-avatar-modal').classList.remove('active');
      });
    }

    Fuji.prototype.getUser = function() {
      var dataEl;
      dataEl = document.querySelector("[data-fuji-email]");
      if (dataEl && dataEl.dataset.fujiEmail.length > 0) {
        return this.user = {
          email: dataEl.dataset.fujiEmail
        };
      }
    };

    Fuji.prototype.attachElement = function() {
      this.el = document.createElement("div");
      this.el.classList.add("fuji");
      if (!this.user) {
        this.el.classList.add("anonymous");
      }
      this.el.id = "fuji";
      this.el.innerHTML = "\n<div class=\"fuji-container\">\n  <h1 class=\"fuji-brand\">\n    <a class=\"fuji-logo\" href=\"/\">\n      heroku <span class=\"fuji-logo-subtext\">help</span>\n    </a>\n  </h1>\n  <ul class=\"fuji-links\">\n    <li><a href=\"https://dashboard.heroku.com\" class=\"apps\">Apps</a></li>\n    <li><a href=\"https://addons.heroku.com\" class=\"addons\">Add-ons</a></li>\n    <li><a href=\"https://devcenter.heroku.com\" class=\"documentation\">Documentation</a></li>\n    <li><a href=\"https://help.heroku.com\" class=\"support\">Support</a></li>\n    <li><a href=\"https://dashboard.heroku.com\" id=\"notification-center-toggler\" class=\"notification-center\">&nbsp;</a></li>\n    " + (this.loginLink()) + "\n  </ul>\n\n  " + (this.avatar()) + "\n  " + (this.avatarModal()) + "\n</div>";
      return document.querySelector("body").appendChild(this.el);
    };

    Fuji.prototype.avatar = function() {
      var url;
      if (!this.user) {
        return "";
      }
      url = gravatar.url(this.user.email, {
        size: '100',
        "default": "https://s3.amazonaws.com/assets.heroku.com/addons.heroku.com/gravatar_default.png"
      }, true);
      return "<a class=\"fuji-avatar\" href=\"#\">\n  <img src=\"" + url + "\">\n</a>";
    };

    Fuji.prototype.avatarModal = function() {
      if (!this.user) {
        return "";
      }
      return "<ul class=\"fuji-avatar-modal\">\n  <li><a href=\"//dashboard.heroku.com/settings\">Settings</a></li>\n  <li><a href=\"//dashboard.heroku.com/logout\">Logout</a></li>\n</ul>";
    };

    Fuji.prototype.loginLink = function() {
      if (this.user) {
        return "";
      }
      return "<li><a href=\"https://id.heroku.com\" class=\"login\">Log In</a></li>";
    };

    Fuji.init = function(options) {
      if (options == null) {
        options = {};
      }
      return window.fuji = new Fuji(options);
    };

    return Fuji;

  })();

  if (document.readyState === "complete") {
    Fuji.init();
  } else {
    document.addEventListener("DOMContentLoaded", Fuji.init);
  }

}).call(this);
