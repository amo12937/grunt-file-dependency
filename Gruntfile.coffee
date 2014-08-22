"use strict"

module.exports = (grunt) ->
  require("./src/grunt-file-dependency.coffee") grunt

  require("load-grunt-tasks") grunt

  require("time-grunt") grunt

  grunt.initConfig
    clean:
      dist:
        files: [
          dot: true
          src: ["lib"]
        ]

    coffee:
      options:
        sourceMap: false
        sourceRoot: ""
      dist:
        files: [
          expand: true
          cwd: "src"
          src: "**/*.coffee"
          dest: "lib"
          ext: ".js"
        ]

    grunt.registerTask "compile", [
      "clean:dist"
      "coffee:dist"
    ]
