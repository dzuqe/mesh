React = require 'react'
ReactDOM = require 'react-dom'
CeramicClient = require('@ceramicnetwork/http-client').default
{
  Near, Account, Contract, KeyPair, WalletAccount,
  keyStores: { BrowserLocalStorageKeyStore }
} = require 'near-api-js'

# wrappers
R = React.createElement

# constants
API_URL = "https://ceramic-clay.3boxlabs.com"

class HomePage extends React.Component
  constructor: (props) ->
    super props
    @state = {
      data: ""
    }

  componentDidMount: ->
    console.log 'component did mount'
    ceramic = new CeramicClient API_URL
    console.log ceramic

    contractName = "YOUR DEV ACCOUNT ID"
    config =
      networkId: 'default'
      nodeUrl: 'https://rpc.testnet.near.org'
      walletUrl: 'https://wallet.testnet.near.org'
      helperUrl: 'https://helper.testnet.near.org'
      contractName: "YOUR DEV ACCOUNT ID"


    { networkId, nodeUrl, walletUrl } = config
    near = new Near({
      networkId, nodeUrl, walletUrl, 
      deps:
        keyStore: new BrowserLocalStorageKeyStore()
    })



    wallet = new WalletAccount(near)
    #account = if wallet.isSignedIn() then wallet.account() else wallet.requestSignIn(contractName)

   
    contractMethods =
      viewMethods: ['get_balance'],
      changeMethods: ['transfer']

    #contract = new Contract(Account, contractName, contractMethods) 
    #contract.get_balance(null, 300000000000000, near.utils.format.parseNearAmount('12')),

  render: ->
    R 'div', className: 'home', 
      R 'h3', null, "Welcome to the store, #{@props.name}"
      R 'a', href:'foo', 'bar'
    
ReactDOM.render(
  R(HomePage, {name: "Poppa"}, "Lorem ipsum"),
  document.getElementById("root")
)
