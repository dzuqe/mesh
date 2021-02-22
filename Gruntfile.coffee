debug = false
debug = true if process.env.NODE_ENV == 'development'

module.exports = (grunt) ->
  grunt.initConfig
#    uglify:
#      app:
#        options:
#          mangle: true
#          compress: true
#          sourceMap: !debug
#          sourceMapIncludeSources: !debug
#        src: 'dist/bundle.js'
#        dest: 'dist/bundle.min.js'
    browserify:
      client:
        options:
          browserifyOptions:
            extensions: [ '.coffee' ]
            debug: debug
          transform: [ 'reactify', 'coffeeify' ]
        src: [ 'ui/app.coffee' ]
        dest: 'dist/bundle.js'

  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-browserify'

  grunt.registerTask 'default', ['browserify']
