"use strict"

path = require "path"
module.exports = (grunt) ->
  grunt.registerMultiTask "makePriority", "make priority", ->
    console.log @data

    opts = @options
      baseUrl: "./"
      alias: {}

    baseUrl = opts.baseUrl
    deps = @data.deps
    alias = opts.alias
    priority = []
    has = {}

    f = (key, d = deps[key] or []) ->
      return if has[key]
      f k for k in d
      priority.push path.resolve baseUrl, alias[key] or key
      has[key] = true
    f key, d for key, d of deps

    @data.done priority
