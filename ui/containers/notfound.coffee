React = require 'react'
R = React.createElement

env = require '../env/default.coffee'

class Faq extends React.Component
  constructor: (props) ->
    super props

  componentDidMount: ->
    console.log "Loading FAQ page"

  render: ->
    R 'div', className: 'home', 
      R 'h3', null, "FAQ"

module.exports = Faq
