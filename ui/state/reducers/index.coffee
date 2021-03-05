merge = require 'lodash/merge'
{ combineReducers } = require 'redux' 
ActionTypes = require '../actions/index.coffee'

arweaveKey = (state = {}, action) ->
  if action.type is ActionTypes.STORE_ARWEAVE_KEY
    console.log 'Storing arweave key'
    state = action.key
  return state

nearAccount = (state = {}, action) ->
  console.log 'may have rcvd an action', action
  if action.type is ActionTypes.SAVE_NEAR_ACCOUNT
    console.log 'Saving NEAR Account!!'
    return merge({}, state, action.account)
  else
    console.log 'no match', action.type
  return state

rootReducer = combineReducers({nearAccount, arweaveKey})

module.exports = rootReducer
