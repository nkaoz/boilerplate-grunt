
pngquant = require 'imagemin-pngquant'
mozjpeg = require 'imagemin-mozjpeg'
gifsicle = require 'imagemin-gifsicle'
svgo = require 'imagemin-svgo'


module.exports = (grunt)->
  require('time-grunt')(grunt)
  grunt.initConfig
    pkg: 
      grunt.file.readJSON "package.json"
    coffee:
      build:
        expand: true,
        cwd: 'src/coffee',
        src: ['**/*.coffee'],
        dest: 'dist/js',
        ext: '.js'
    jade:
      compile:
        options:
          data: {},
          pretty: false
        files:[
          expand: true,
          cwd: 'src/jade/',
          src: ['**/*.jade', '!/layout/layout.jade','!includes/*.jade'],
          dest: 'dist/',
          ext: '.html'
        ]
    sass:
      dist:
        files:[ 
          expand: true,
          cwd: 'src/scss',
          src: ['*.scss'],
          dest: 'dist/css',
          ext: '.css'
        ]
    watch:
      options:
        livereload: true,
      sasswatch:
        files: ['src/scss/*.scss'],
        tasks: ['sass','notify:notifysass']
      coffeewatch: 
        files: ['src/coffee/*.coffee'],
        tasks: ['coffee','notify:notifycoffee']
      jadewatch: 
        files: ['src/jade/**/*.jade','!src/jade/layout/layout.jade','!src/jade/includes/*.jade'],
        tasks: ['jade','notify:notifyjade']
    connect:
      server:
        options:
          port: 4000,
          base: './dist/',
          hostname: '*'
    notify: 
      notifysass:
        options:
          title: 'Task Complete',
          message: 'SASS and Uglify finished running'
      notifycoffee:
        options:
          title: 'Task Complete',
          message: 'coffee finished running'
      notifyjade:
         options:
          title: 'Task Complete',
          message: 'jade finished running'       
      notifyserver:
        options:
          title: 'Task Complete',
          message: 'Server is ready!'
    imagemin:
      options:
        optimizationLevel: 3
        use: [mozjpeg(),
              pngquant({ quality: '65-80', speed: 4 }),
              gifsicle({ interlaced: true }),
              svgo()]
      files:
        expand: true,                  
        cwd: 'src/images',                   
        src: ['*.{png,jpg,gif,svg}'],   
        dest: 'dist/images'
  

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-imagemin'
  grunt.loadNpmTasks 'grunt-notify'



  grunt.registerTask 'image', ['imagemin']  
  grunt.registerTask 'build', ['coffee','jade','sass']  
  grunt.registerTask 'default', ['connect','watch','notify:notifyserver'] 

