{ createStore } = require 'redux'
rootReducer = require './reducers/index.coffee'

configureStore = (preloadedState) ->
  store = createStore(rootReducer, preloadedState)

  if module.hot
    module.hot.accept('./reducers/index.coffee', () -> store.replaceReducer(rootReducer))

  return store

module.exports = configureStore
