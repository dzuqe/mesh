React = require 'react'
R = React.createElement
{ render } = require 'react-dom'
{ BrowserRouter } = require 'react-router-dom'
configureStore = require './state/index.coffee'
Root = require './containers/root.coffee'

store = configureStore()

class ErrorBoundary extends React.Component
  constructor: (props) ->
    super props
    @state =
      hasError: false

  @getDerivedStateFromError: (error) ->
    return { hasError: true }

  componentDidCatch: (error, errorInfo) ->
    console.log error, errorInfo

  render: ->
    if this.state.hasError
      return R('h1', null, 'Something went wrong.')
    return @props.children
   
render(
  R BrowserRouter, null,
    R Root, {store:store}, null
  document.getElementById "root"
)
