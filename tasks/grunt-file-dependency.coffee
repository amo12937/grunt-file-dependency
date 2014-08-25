"use strict"

path = require "path"
module.exports = (grunt) ->
  makeMainJs = (opts, config) ->
    return unless opts.mainjs

    path = path.resolve opts.mainjs
    output = "\"use strict\";\n\nrequire.config(#{JSON.stringify config});"
    grunt.file.write path, output
  
  makePriority = (opts, config) ->
    return unless opts.usePriority

    baseUrl = opts.baseUrl or config.baseUrl or "./"
    shim = config.shim or {}
    alias = config.paths or {}
    priority = []
    has = {}
    f = (key, deps = shim[key] or []) ->
      return if has[key]
      f k for k in deps
      priority.push path.resolve baseUrl, alias[key] or key
      has[key] = true
    f key, deps for key, deps of shim

    opts.usePrioriy priority

  grunt.registerMultiTask "fileDependency", "make file dependency for requirejs", ->
    opts = @options
      configFile: "./file-dependency.conf.js"

    config = require(path.resolve(opts.configFile)) or {}

    makeMainJs opts, config
    makePriority opts, config
