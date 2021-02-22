import React from 'react'
import ReactDOM from 'react-dom'

class HomePage extends React.Component
  render: ->
    <div className="home">
      <h1>Home page</h1>
      <h3>Welcome to the store, {this.props.name}</h3>
    </div>
    
ReactDOM.render(
  React.createElement(HomePage, {name: "Poppa"}, "Lorem ipsum"),
  document.getElementById("root")
)
