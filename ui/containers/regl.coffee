React = require 'react'
R = React.createElement
createREGL = require 'regl'

env = require '../env/default.coffee'

class Regl extends React.Component
  regl = null
  canvas = null

  constructor: (props) ->
    super props
    @canvas = React.createRef()

  componentWillUnmount: ->
    @regl.destroy()

  componentDidMount: ->
    gl = @canvas.current.getContext('webgl', {
      alpha: false,
      antialias: false,
      stencil: false,
      preserveDrawingBuffer: false
    })

    @regl = createREGL({gl: gl})
    console.log 'Loading regl: ', @regl

    drawTriangle = @regl({
      frag: """
      void main() {
        gl_FragColor = vec4(1,0,0,1);
      }""",
      vert: """
      attribute vec2 position;
      void main() {
        gl_Position = vec4(position, 0, 1);
      }""",
      attributes: {
        position: [[0,-1],[-1,0],[1,1]]
      },
      count: 3
    })

    drawTriangle()

  componentDidUpdate: ->
    @regl.clear({
      color: @props.color || [0,0,0,1],
      depth: @props.depth || 1
    })

  render: ->
    R 'canvas', {ref: @canvas}, null

module.exports = Regl
