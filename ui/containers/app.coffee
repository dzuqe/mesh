React = require 'react'
{h1,div,h3} = require 'react-dom'
R = React.createElement
env = require '../env/default.coffee'
{ withRouter } = require 'react-router-dom'
{ connect } = require 'react-redux'
{ saveNearAccount } = require '../state/actions/index.coffee'
PropTypes = require 'prop-types'

CeramicClient = require('@ceramicnetwork/http-client').default
{
  Near, Account, Contract, KeyPair, WalletAccount,
  keyStores: { BrowserLocalStorageKeyStore }
} = require 'near-api-js'

class App extends React.Component
  @propTypes =
    account: PropTypes.object

  constructor: (props) ->
    super props
    @state =
      account: undefined
    @loadWallet = @loadWallet.bind @

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
    console.log account

    if typeof @ isnt undefined
      @setState({
        account: account
      })

      @props.saveNearAccount(account)
    else
      console.log 'this object is not in context'

  render: ->
    R 'div', className: 'home', 
      R 'h3', null, "W3lcome to the store, #{@props.name}"
      R 'div', {className: 'button', onClick: @loadWallet}, 'Connect Wallet'

mapStateToProps = (state) ->
  account: state.account

module.exports = withRouter(connect(mapStateToProps, {
  saveNearAccount
})(App))
