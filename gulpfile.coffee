
gulp = require 'gulp'

project = 'Memkits/pudica/index.html'

gulp.task 'folder', (cb) ->
  filetree = require 'make-filetree'
  filetree.make '.',
    'index.cirru': ''
    source:
      'main.cirru': ''
      'main.css': ''
    'README.md': ''
    build: {}
  cb

gulp.task 'watch', ->
  plumber = require 'gulp-plumber'
  script = require 'gulp-cirru-script'
  watch = require 'gulp-watch'
  html = require 'gulp-cirru-html'
  sourcemaps = require 'gulp-sourcemaps'
  rename = require 'gulp-rename'
  reloader = require 'gulp-reloader'
  reloader.listen()

  gulp
  .src 'index.cirru'
  .pipe watch()
  .pipe plumber()
  .pipe html(data: {})
  .pipe gulp.dest('./')
  .pipe reloader(project)

  gulp
  .src('source/**/*.cirru', base: './')
  .pipe watch()
  .pipe plumber()
  .pipe sourcemaps.init()
  .pipe script()
  .pipe rename(extname: '.js')
  .pipe sourcemaps.write('./')
  .pipe (gulp.dest 'build/')
  .pipe reloader(project)

gulp.task 'script', ->
  script = require 'gulp-cirru-script'
  sourcemaps = require 'gulp-sourcemaps'
  rename = require 'gulp-rename'

  gulp
  .src 'source/**/*.cirru', base: 'source/'
  .pipe sourcemaps.init(debug: yes)
  .pipe script()
  .pipe rename(extname: '.js')
  .pipe sourcemaps.write('./')
  .pipe (gulp.dest 'build/')

gulp.task 'html', ->
  html = require 'gulp-cirru-html'
  gulp
  .src 'index.cirru'
  .pipe html(data: {})
  .pipe gulp.dest('.')

gulp.task 'clean', (cb) ->
  del = require 'del'
  del ['build/'], cb

gulp.task 'start', (cb) ->
  sequence = require 'run-sequence'
  sequence 'clean', 'dev', cb

gulp.task 'dev', ->
  sequence = require 'run-sequence'
  sequence ['html', 'script']
