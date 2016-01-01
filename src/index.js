require('./index.html')
require('./index.css')
var Elm = require('./Main.elm')

document.addEventListener("DOMContentLoaded", function() {
  var app =
  Elm.embed(
    Elm.Main,
    document.getElementById("root"),
    {
      userFromStorage: JSON.parse(
        localStorage.getItem("user")) || {username: "", token: ""},
        initialPath: window.location.hash
      }
    )


    app.ports.saveUser.subscribe(function(user) {
      localStorage.setItem("user", JSON.stringify(user))
    })
  })
