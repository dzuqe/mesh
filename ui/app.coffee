React = require 'react'
ReactDOM = require 'react-dom'
CeramicClient = require '@ceramicnetwork/http-client'
NearAPI = require 'near-api-js'

# wrappers
R = React.createElement

# constants
API_URL = "https://ceramic-clay.3boxlabs.com"

class HomePage extends React.Component
  constructor: (props) ->
    super(props)
    @state = {
      data: ""
    }

  componentDidMount: ->
    console.log 'component did mount'
    #ceramic = new CeramicClient API_URL
    #near.loginAccount
    #addresses = await window.near.enable()
    #authProvider = new NearAuthProvider(Near, addresses[0])
    #await threeIdConnect.connect(authProvider)
    #provider = await threeIdConnect.getDidProvider()
    #await ceramic.setDIDProvider(provider)
    #console.log provider

  render: ->
    R 'div', className: 'home', 
      R 'h3', null, "Welcome to the store, #{@props.name}"
      R 'a', href:'foo', 'bar'
    
ReactDOM.render(
  R(HomePage, {name: "Poppa"}, "Lorem ipsum"),
  document.getElementById("root")
)
