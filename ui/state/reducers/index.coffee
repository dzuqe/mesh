merge = require 'lodash/merge'
{ combineReducers } = require 'redux' 

nearAccount = (state = {}, action) ->
  if action.response?.account?
    return merge({}, state, action.response.account)
  return state

ceramic = (state = {}, action) ->
  if action.response?.ceramic
    return merge({}, state, action.response.account)
  return state

rootReducer = combineReducers({nearAccount, ceramic})

module.exports = rootReducer
