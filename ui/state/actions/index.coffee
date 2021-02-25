{ dispatch } = require 'redux'
SAVE_NEAR_ACCOUNT = 'SAVE_NEAR_ACCOUNT'
saveNearAccount = (account) ->
  console.log 'SAVE_NEAR_ACCOUNT action called', account
  payload =
    type: SAVE_NEAR_ACCOUNT
    account: account
  return payload

module.exports =
  saveNearAccount: saveNearAccount
  SAVE_NEAR_ACCOUNT: SAVE_NEAR_ACCOUNT
