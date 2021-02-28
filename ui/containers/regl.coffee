React = require 'react'
R = React.createElement
Babylon = require 'babylonjs'

env = require '../env/default.coffee'

class Regl extends React.Component
  canvas = null

  constructor: (props) ->
    super props
    @canvas = React.createRef()
    @getFiles = @getFiles.bind @

  componentWillUnmount: ->

  getFiles: (e) ->
    e.preventDefault()
    console.log 'get files', e.target.files

  createScene: (engine) ->
    scene = new Babylon.Scene engine

    camera = new Babylon.FreeCamera 'cam1',
      new Babylon.Vector3 0, 5, -10 
      scene

    camera.setTarget Babylon.Vector3.Zero()
    camera.attachControl @canvas.current, false

    light = new Babylon.HemisphericLight 'light1', # name
      new Babylon.Vector3 0, 1, 0   # position
      scene

    sphere = Babylon.Mesh.CreateSphere 'sphere1', # name
      16                      # segment
      2                       # diameter
      scene
      false                   # updatable
      Babylon.Mesh.FRONTSIDE  # side orientation

    sphere.position.y = 1

    ground = Babylon.Mesh.CreateGround 'ground1', # name
      6                       # width 
      6                       # height
      2                       # subdivision 
      scene
      false                   # updatable

    return scene

  componentDidMount: ->
    engine = new Babylon.Engine(@canvas.current, true, {
      preserveDrawingBuffer: true,
      stencil: true
    })

    scene = @createScene(engine)
    engine.runRenderLoop(() ->
      scene.render()
    )

  render: ->
    R 'div', null, null,
      R 'input', {
        onChange: @getFiles
        id: 'files'
        type: 'file'
        multiple: true
      }, null
      R 'canvas', {ref: @canvas}, null

module.exports = Regl
