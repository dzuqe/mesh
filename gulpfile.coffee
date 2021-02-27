gulp        = require 'gulp'
sass        = require 'gulp-sass'
uglify      = require 'gulp-uglify'
log         = require 'gulplog'
browserify  = require 'browserify'
reactify    = require 'reactify'
coffeeify   = require 'coffeeify'
source      = require 'vinyl-source-stream'
buffer      = require 'vinyl-buffer'
sourcemaps  = require 'gulp-sourcemaps'
server      = require('browser-sync').create()

sass.compiler = require 'node-sass'

customOpts =
  entries: ['./ui/index.coffee']
  debug: true
  transform: [reactify, coffeeify]

reload = (done) ->
  console.log 'file changed'
  server.reload()
  done()

serve = (done) ->
  server.init
    server:
      baseDir: './dist'
  done()

gulp.task 'sass', ->
  gulp.src './ui/main.sass'
    .pipe sass.sync().on 'error', sass.logError
    .pipe gulp.dest './dist/'

gulp.task 'coffee', ->
  b = browserify(customOpts)
  return b.bundle()
    .on('error', log.error.bind(log, 'Browserify error!'))
    .pipe source './bundle.js'
    .pipe buffer()
    .pipe gulp.dest './dist'

watch = (done) ->
  gulp.watch(
    [
      'ui/*.coffee', 
      'ui/components/*.coffee', 
      'ui/containers/*.coffee'
    ], 
    gulp.series 'sass', 'coffee', reload
  )
  done()

gulp.task 'default', gulp.series 'sass', 'coffee', serve, watch, ->
  console.log ''
