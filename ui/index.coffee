React = require 'react'
R = React.createElement
App = require './components/app.coffee'
{ render } = require 'react-dom'

render(
  R App, name: "Poppa", "Lorem ipsum"
  document.getElementById "root"
)
