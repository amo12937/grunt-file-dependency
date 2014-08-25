"use strict"

path = require "path"
module.exports = (grunt) ->
  grunt.registerMultiTask "makeMainJs", "make main js", ->
    opts = @options
      configFile: ""
    dest = path.resolve @data.dest
    main = @data.main
    if opts.configFile
      main = require(opts.configFile) main

    output = "\"use strict\";\n\nrequire.config(#{JSON.stringify main});"

    grunt.file.write dest, output