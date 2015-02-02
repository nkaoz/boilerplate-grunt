module.exports = (grunt)->
  grunt.initConfig
    pkg grunt.file.readJSON 'package.json',
    jade
      compile
        options
          data {},
          pretty false
        files:[
          expand: true,
          cwd 'src/jade/',
          src ['**/*.jade'],
          dest 'dist/',
          ext '.html'
        ]
    coffee
      build
        expand: true,
        cwd 'src/coffee',
        src ['**/*.coffee'],
        dest 'dist/js',
        ext '.js'
    sass: {
      dist {
        files [{
          expand: true,
          cwd 'src/scss',
          src ['*.scss'],
          dest '../public',
          ext '.css'
    watch
      scsswatch
        files ['src/scss/*.scss'],
        tasks ['stylesheets']
      coffeewatch
        files ['src/coffee/*.coffee'],
        tasks ['scripts']
      jadewatch
        files ['src/jade/**/*.jade'],
        tasks ['jade']
    connect
      server
        options
          port 4000,
          base './dist/',
          hostname '*'
