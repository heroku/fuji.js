module.exports = (grunt) ->

  grunt.initConfig

    coffee:
      app:
        options:
          bare: false
          join: true
        files:
          'public/fuji-pre-browserify.js': ['src/**/*.coffee']

    browserify:
      basic:
        src: ['public/fuji-pre-browserify.js']
        dest: 'public/fuji.js'

    watch:
      coffee:
        files: ['src/**/*.coffee'],
        tasks: ['coffee']
      browserify:
        files: ['public/fuji-pre-browserify.js'],
        tasks: ['browserify']
      casper:
        files: ['public/fuji.js'],
        tasks: ['casper']

    casper:
      test:
        options:
          test: true
        files:
          "test/casper-results.xml": ["test/fuji-test.coffee"]

  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-casper'

  grunt.registerTask 'default', ['coffee', 'browserify']