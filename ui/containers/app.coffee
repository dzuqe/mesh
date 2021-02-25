React = require 'react'
R = React.createElement
env = require '../env/default.coffee'

CeramicClient = require('@ceramicnetwork/http-client').default
{
  Near, Account, Contract, KeyPair, WalletAccount,
  keyStores: { BrowserLocalStorageKeyStore }
} = require 'near-api-js'

class App extends React.Component
  constructor: (props) ->
    super props
    @state =
      data: ""

  componentDidMount: ->
    console.log 'load ceramic'
    ceramic = new CeramicClient env.CERAMIC_API_URL
    console.log ceramic

  loadContract: ->
    console.log 'load contract'
    contract = new Contract(Account, contractName, contractMethods) 
    contract.get_balance null, 
      env.NEAR_TESTNET_GAS
      near.utils.format.parseNearAmount '12'

  loadWallet: ->
    console.log 'load wallet'
    contractName = env.METH_CONTRACT_NAME
    config =
      networkId: env.NEAR_TESTNET_NETWORK_ID
      nodeUrl: env.NEAR_TESTNET_NODE_URL
      walletUrl: env.NEAR_TESTNET_WALLET_URL
      helperUrl: env.NEAR_TESTNET_HELPER_URL
      contractName: contractName 

    contractMethods =
      viewMethods: ['get_num']
      changeMethods: ['increment']
      changeMethods: ['decrement']

    { networkId, nodeUrl, walletUrl } = config
    near = new Near({
      networkId, nodeUrl, walletUrl, 
      deps:
        keyStore: new BrowserLocalStorageKeyStore()
    })

    wallet = new WalletAccount(near)   
    account = if wallet.isSignedIn() \
              then wallet.account() \
              else wallet.requestSignIn(contractName)

    console.log "Done retrieving wallet info"
    console.log wallet
    console.log account

  render: ->
    R 'div', className: 'home', 
      R 'h3', null, "W3lcome to the store, #{@props.name}"
      R 'div', {className: 'button', onClick: @loadWallet}, 'Connect Wallet'

module.exports = App
