STORE_ARWEAVE_KEY = 'STORE_ARWEAVE_KEY'
storeArweaveKey = (key) ->
  console.log 'STORE_ARWEAVE_KEY action called', key
  payload =
    type: STORE_ARWEAVE_KEY
    key: key
  return payload

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
  storeArweaveKey: storeArweaveKey
  STORE_ARWEAVE_KEY: STORE_ARWEAVE_KEY
