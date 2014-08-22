"use strict"

path = require "path"
module.exports = (grunt) ->
  grunt.registerMultiTask "fileDependency", "make file dependency for requirejs", ->
    opts = @options
      configFile: "./file-dependency.conf.js"
      usePriority: (priority) ->

    config = require(path.resolve(opts.configFile)) or {}

    defPriority = (baseUrl = "./", shim = {}, alias = {}) ->
      priority = []
      has = {}
      f = (key, deps = shim[key] or []) ->
        return if has[key]
        f k for k in deps
        priority.push path.resolve baseUrl, alias[key] or key
        has[key] = true
      f key, deps for key, deps of shim
      return priority

    priority = defPriority config.baseUrl, config.shim, config.paths

    if opts.mainjs
      path = path.resolve opts.mainjs
      output = "\"use strict\";\n\nrequire.config(#{JSON.stringify config});"
      grunt.file.write path, output
    opts.usePriority priority
