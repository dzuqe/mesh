React = require 'react'
R = React.createElement
{ createDevTools } = require 'redux-devtools'
LogMonitor = require('redux-devtools-log-monitor').default
DockMonitor = require('redux-devtools-dock-monitor').default

tools = createDevTools(
  R DockMonitor, {toggleVisibilityKey:'ctrl-y', changePositionKey:'ctrl-m'},
    R LogMonitor, null, null
)

module.exports = tools
