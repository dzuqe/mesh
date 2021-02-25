merge = require 'lodash/merge'
{ combineReducers } = require 'redux' 
ActionTypes = require '../actions/index.coffee'

saveNearAccount = (state = {}, action) ->
  console.log 'may have rcvd an action', action
  if action.type is ActionTypes.SAVE_NEAR_ACCOUNT
    console.log 'Saving NEAR Account!!'
    return merge({}, state, action.account)
  else
    console.log 'no match', action.type
  return state

rootReducer = combineReducers({saveNearAccount})

module.exports = rootReducer
