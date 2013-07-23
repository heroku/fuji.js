![http://cl.ly/image/052j0n0G3v2H](http://cl.ly/image/052j0n0G3v2H/content#.png)

# Fuji.js

A javascript implementation of Fuji, and potential successor to the [ruby implementation](https://github.com/heroku/fuji).

## Usage

Download the javascript file and drop it in your app, or include it in your asset pipeline:

```
curl https://raw.github.com/heroku/fuji.js/master/public/fuji.js
```

Fuji initializes itself when the DOM is ready. In the absence of a cookie containing identifying information, Fuji will look for a
data attribute containing the email address of a logged-in user:

```html
<script src="fuji.js"></script>
<body data-fuji-user-email="user@example.com"></body>
```

## Development

Install [Node.js](http://nodejs.org/).

```
brew install casperjs       # integration tests with phantom
npm install -g grunt-cli    # build automation tool
grunt watch                 # build and test automatically
```