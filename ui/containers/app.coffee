React = require 'react'
R = React.createElement
env = require '../env/default.coffee'
{ withRouter } = require 'react-router-dom'
{ connect } = require 'react-redux'
{ storeArweaveKey, saveNearAccount } = require '../state/actions/index.coffee'
PropTypes = require 'prop-types'
Arweave = require('arweave').default

{ThreeIdConnect} = require '3id-connect'
CeramicClient = require('@ceramicnetwork/http-client').default
{ NearAuthProvider } = require '@ceramicnetwork/blockchain-utils-linking'

{
  Near, Account, Contract, KeyPair, WalletAccount,
  keyStores: { BrowserLocalStorageKeyStore }
} = require 'near-api-js'

Viewport = require './viewport.coffee'

class App extends React.Component
  @propTypes =
    account: PropTypes.object
    arweaveKey: PropTypes.object

  ceramic = null
  arweave = null
  near = null
  account = null

  constructor: (props) ->
    super props
    @state =
      account: undefined
      near: undefined
    @loadWallet = @loadWallet.bind @
    @uploadFile = @uploadFile.bind @
    @getFiles = @getFiles.bind @
    @getKey = @getKey.bind @

  componentDidMount: ->
    ceramic = new CeramicClient env.CERAMIC_API_URL
    console.log 'loaded ceramic', ceramic

    console.log 'load arweave'
    arweave = Arweave.init({
      host: 'arweave.net',
      port: 443,
      protocol: 'https'
    })

    console.log 'loaded arweave', arweave

  getFiles: (e) ->
    e.preventDefault()
    console.log 'get files', e.target.files

  loadContract: ->
    console.log 'load contract'
    contract = new Contract(Account, contractName, contractMethods) 
    console.log contract.get_balance null, 
      env.NEAR_TESTNET_GAS
      near.utils.format.parseNearAmount '12'
    return contract

  getKey: (e) ->
    e.preventDefault()
    console.log 'loading arweave key'
    data = await e.target.files[0].text()
    @props.storeArweaveKey(JSON.parse(data))

  uploadFile: (e) ->
    e.preventDefault()
    console.log 'submit data to arweave', @props.arweaveKey
    data = await e.target.files[0].text()
    tx = await arweave.createTransaction({data: data}, @props.arweaveKey)
    console.log 'tx created: ', tx
    await arweave.transactions.sign(tx, @props.arweaveKey)

    # authenticate ceramic
    console.log 'authenticate ceramic', near, account.accountId
    threeIdConnect = new ThreeIdConnect()
    authProvider = new NearAuthProvider(near, account.accountId)
    console.log threeIdConnect, authProvider

    await threeIdConnect.connect(authProvider)

    provider = await threeIdConnect.getDidProvider()
    console.log 'provider', provider
    await ceramic.setDIDProvider(provider.provider)

    # save tx id to ceramic
    console.log 'create the document'
    doc = await ceramic.createDocument('tile', {
      content: {
        foo: tx.id
      }
    })

    console.log 'document created in ceramic net', doc

    # send the doc to near contract    
    contract = @loadContract()
    console.log 'loaded contract', contract

    #uploader = await arweave.transactions.getUploader(tx)
    #while (!uploader.isComplete)
    #  await uploader.uploadChunk()
    #  console.log "#{uploader.pctComplete}% complete"

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
    console.log near
    console.log wallet
    #@props.saveNearAccount(account)

  render: ->
    R 'div', className: 'home',
      R 'header', null,
        R 'h3', null, "meth"
        R 'div', {className: 'button', onClick: @loadWallet}, 'Connect NEAR Wallet'
        R 'input', {type: 'file', onChange: @getKey, placeholder: 'Connect Arweave Wallet'}, null
      R 'div', {className: 'container'},
        R 'h1', null, 'regl test'
        R 'input', {
          onChange: @uploadFile
          id: 'files'
          type: 'file'
          multiple: true
        }, null

        R Viewport, null, null

mapStateToProps = (state) ->
  payload =
    account: state.nearAccount
    arweaveKey: state.arweaveKey
  return payload

module.exports = withRouter(connect(mapStateToProps, {
  saveNearAccount,
  storeArweaveKey
})(App))
