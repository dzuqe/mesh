React = require 'react'
PropTypes = require 'prop-types'
R = React.createElement
{ Provider } = require 'react-redux'
{ Route, Link, Switch } = require 'react-router-dom'
App = require './app.coffee'
Faq = require './faq.coffee'

Root = ({store}) ->
  R Provider, {store:store},
    R 'div', null,
      R 'nav', null,
        R 'ul', null,
          R 'li', null,
            R Link, {to:'/'}, 'Home'
          R 'li', null,
            R Link, {to:'/faq'}, 'FAQ page'
    R Switch, null,
      R Route, {exact:true,path:'/'}, R(App,null,null)
      R Route, {path:'/faq'}, R(Faq,null,null)

Root.propTypes =
  store: PropTypes.object.isRequired

module.exports = Root
