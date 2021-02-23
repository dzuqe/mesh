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
  entries: ['./ui/app.coffee']
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

gulp.task 'css', ->
  gulp.src './ui/main.sass'
    .pipe sass.sync().on 'error', sass.logError
    .pipe gulp.dest './dist/'

gulp.task 'js', ->
  b = browserify(customOpts)
  return b.bundle()
    .on('error', log.error.bind(log, 'Browserify error!'))
    .pipe source './bundle.js'
    .pipe buffer()
    .pipe gulp.dest './dist'

watch = (done) ->
  gulp.watch('./ui/app.coffee', gulp.series 'css', 'js', reload)
  done()

gulp.task 'default', gulp.series 'css', 'js', serve, watch, ->
  console.log ''
