{ compose, applyMiddleware, createStore } = require 'redux'
rootReducer = require './reducers/index.coffee'
{ createLogger } = require 'redux-logger'

configureStore = (preloadedState) ->
  store = createStore(rootReducer, ###preloadedState,### compose(applyMiddleware(createLogger()), window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__()))

  if module.hot
    module.hot.accept('./reducers/index.coffee', () -> store.replaceReducer(rootReducer))

  return store

module.exports = configureStore
