module.exports = (grunt) ->
  cssFilesToInject = [ "linker/styles/style.css" ]
  jsFilesToInject = []
  templateFilesToInject = [ "linker/**/*.html" ]
  cssFilesToInject = cssFilesToInject.map((path) ->
    ".tmp/public/" + path
  )
  jsFilesToInject = jsFilesToInject.map((path) ->
    ".tmp/public/" + path
  )
  templateFilesToInject = templateFilesToInject.map((path) ->
    "assets/" + path
  )

  # --------------------------------------------------------------------Get path to core grunt dependencies from Sails
  depsPath = grunt.option("gdsrc") or "node_modules/sails/node_modules"
  grunt.loadTasks depsPath + "/grunt-contrib-clean/tasks"
  grunt.loadTasks depsPath + "/grunt-contrib-copy/tasks"
  grunt.loadTasks depsPath + "/grunt-contrib-concat/tasks"
  grunt.loadTasks depsPath + "/grunt-sails-linker/tasks"
  grunt.loadTasks depsPath + "/grunt-contrib-jst/tasks"
  grunt.loadTasks depsPath + "/grunt-contrib-watch/tasks"
  grunt.loadTasks depsPath + "/grunt-contrib-uglify/tasks"
  grunt.loadTasks depsPath + "/grunt-contrib-cssmin/tasks"

  #----------------------------------------------------------------------------------------------Packages for front end
  grunt.loadNpmTasks "grunt-newer"
  grunt.loadNpmTasks "grunt-contrib-less"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-jade"
  grunt.loadNpmTasks "grunt-lesslint"
  grunt.loadNpmTasks "grunt-coffeelint"
  grunt.loadNpmTasks "grunt-requirejs-config"
  grunt.loadNpmTasks "grunt-angular-templates"

  # ---------------------------------------------------------------------------------------------Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    copy:
      dev:
        files: [
          expand: true
          cwd: "./bower_components/font-awesome/fonts/"
          src: [ "**/*" ]
          dest: ".tmp/public/linker/fonts"
        ,
          #------------------------------------------------------------------------------------------libs configuration
          ".tmp/public/linker/src/lib/require.js": "./bower_components/requirejs/require.js"
        ,
          ".tmp/public/linker/src/lib/respond.min.js": "./bower_components/respond/dest/respond.min.js"
        ,
          ".tmp/public/linker/src/lib/jquery.js": "./bower_components/jquery/dist/jquery.js"
        ,
          ".tmp/public/linker/src/lib/angular.js": "./bower_components/angular/angular.js"
        ,
          ".tmp/public/linker/src/lib/bootstrap.js": "./bower_components/bootstrap/dist/js/bootstrap.js"
        ,
          ".tmp/public/linker/src/lib/socket.io.js": "./assets/src/lib/socket.io.js"
        ,
          ".tmp/public/linker/src/lib/angular-sails.io.js": "./assets/src/lib/angular-sails.io.js"
        ,
          ".tmp/public/linker/src/lib/angular-animate.js": "./bower_components/angular-animate/angular-animate.js"
        ,
          ".tmp/public/linker/src/lib/angular-resource.js": "./bower_components/angular-resource/angular-resource.js"
        ,
          ".tmp/public/linker/src/lib/angular-sanitize.js": "./bower_components/angular-sanitize/angular-sanitize.js"
        ,
          ".tmp/public/linker/src/lib/angular-ui-router.js": "./bower_components/angular-ui-router/release/angular-ui-router.js"
        ]

      prod:
        files: [
          expand: true
          cwd: "./bower_components/font-awesome/fonts/"
          src: [ "**/*" ]
          dest: ".tmp/public/fonts"
        ]

      build:
        files: [
          expand: true
          cwd: ".tmp/public"
          src: [ "**/*" ]
          dest: "www"
        ]

    jst:
      dev:

      # To use other sorts of templates (mustache), specify the regexp below:
      #        options: {
      #           templateSettings: {
      #             interpolate: /\{\{(.+?)\}\}/g
      #           }
      #        },
        files:
          ".tmp/public/jst.js": templateFilesToInject

    coffee:
      dev:
        expand: true
        cwd: "assets"
        src: [ "**/*.coffee" ]
        dest: ".tmp/public/linker/"
        ext: ".js"
        options:
          sourceMap: true
          bare: true

      prod:
        expand: true
        cwd: "assets"
        src: [ "**/*.coffee" ]
        dest: ".tmp/public/linker/"
        ext: ".js"
        options:
          sourceMap: true
          bare: true

    coffeelint:
      app: "assets/**/*.coffee"
      options:
        force: true
        max_line_length:
          value: 120

    less:
      dev:
        files:
          ".tmp/public/linker/styles/style.css": "assets/src/src.less"

        options:
          sourceMap: true

      prod:
        files:
          ".tmp/public/linker/styles/style.css": "assets/src/src.less"

        options:
          sourceMap: false
          cleancss: true
          compress: true

    lesslint:
      src: [ "assets/src/src.less" ]
      options:
        imports: [ "assets/src/**/*.less" ]
        csslint:
          "unqualified-attributes": false
          "adjoining-classes": false
          "qualified-headings": false
          "unique-headings": false

    jade:
      dev:
        expand: true
        cwd: "assets/src"
        src: [ "**/*.jade" ]
        dest: "templates/"
        ext: ".html"
        options:
          pretty: true

      prod:
        expand: true
        cwd: "assets/src"
        src: [ "**/*.jade" ]
        dest: "templates/"
        ext: ".html"
        options:
          pretty: false
          data:
            deploy: true


  #----------------------------------------------------------------------------------------------
    ngtemplates:
      dev:
        cwd: "templates"
        src: "**/*.html"
        dest: ".tmp/public/linker/src/templates.js"
        options:
          module: "app"
          bootstrap: (module, script) ->
            "define(['angular'], function() {angular.module('templates', []).run([ '$templateCache', function($templateCache) {" + script + "} ]);});"

          htmlmin:
            collapseBooleanAttributes: true
            collapseWhitespace: true
            removeAttributeQuotes: true
            removeComments: true
            removeEmptyAttributes: true
            removeRedundantAttributes: true
            removeScriptTypeAttributes: true
            removeStyleLinkTypeAttributes: true

          url: (url) ->
            url.replace ".html", ""


  #    requirejs: {
  #      main: {
  #        options: {
  #          baseUrl: "linker/src/app",
  #          mainConfigFile: "linker/src/app/main.js",
  #          name: "main",
  #          wrap: true,
  #          optimize: "uglify2",
  #          out: "bin/assets/js/deploy/main.js",
  #          include: ['../lib/almond/almond.js'],
  #          insertRequire: ['main']
  #        }
  #      }
  #    },
  #----------------------------------------------------------------------------------- clean config
    clean:
      templates: [ "templates" ]
      dev: [ ".tmp/public/**" ]
      build: [ "www" ]

  #------------------------------------------------------------------------------------ optimization config
    concat:
      js:
        src: jsFilesToInject
        dest: ".tmp/public/concat/production.js"

      css:
        src: cssFilesToInject
        dest: ".tmp/public/concat/production.css"

    uglify:
      dist:
        src: [ ".tmp/public/concat/production.js" ]
        dest: ".tmp/public/min/production-<%= pkg.version %>.js"

      options:
        mangle: false

    cssmin:
      dist:
        src: [ ".tmp/public/concat/production.css" ]
        dest: ".tmp/public/min/production-<%= pkg.version %>.css"


  #-----------------------------------------------------------------------------js /css script embed into layout.ejs
    "sails-linker":
      devJs:
        options:
          startTag: "<!--SCRIPTS-->"
          endTag: "<!--SCRIPTS END-->"
          fileTmpl: "<script src=\"%s\"></script>"
          appRoot: ".tmp/public"

        files:
          ".tmp/public/**/*.html": jsFilesToInject
          "views/**/*.html": jsFilesToInject
          "views/**/*.ejs": jsFilesToInject

      prodJs:
        options:
          startTag: "<!--SCRIPTS-->"
          endTag: "<!--SCRIPTS END-->"
          fileTmpl: "<script src=\"%s\"></script>"
          appRoot: ".tmp/public"

        files:
          ".tmp/public/**/*.html": [ ".tmp/public/min/production-<%= pkg.version %>.js" ]
          "views/**/*.html": [ ".tmp/public/min/production-<%= pkg.version %>.js" ]
          "views/**/*.ejs": [ ".tmp/public/min/production-<%= pkg.version %>.js" ]

      devStyles:
        options:
          startTag: "<!--STYLES-->"
          endTag: "<!--STYLES END-->"
          fileTmpl: "<link rel=\"stylesheet\" href=\"%s\">"
          appRoot: ".tmp/public"


      # cssFilesToInject defined up top
        files:
          ".tmp/public/**/*.html": cssFilesToInject
          "views/**/*.html": cssFilesToInject
          "views/**/*.ejs": cssFilesToInject

      prodStyles:
        options:
          startTag: "<!--STYLES-->"
          endTag: "<!--STYLES END-->"
          fileTmpl: "<link rel=\"stylesheet\" href=\"%s\">"
          appRoot: ".tmp/public"

        files:
          ".tmp/public/index.html": [ ".tmp/public/min/production-<%= pkg.version %>.css" ]
          "views/**/*.html": [ ".tmp/public/min/production-<%= pkg.version %>.css" ]
          "views/**/*.ejs": [ ".tmp/public/min/production-<%= pkg.version %>.css" ]


    # Bring in JST template object
      devTpl:
        options:
          startTag: "<!--TEMPLATES-->"
          endTag: "<!--TEMPLATES END-->"
          fileTmpl: "<script type=\"text/javascript\" src=\"%s\"></script>"
          appRoot: ".tmp/public"

        files:
          ".tmp/public/index.html": [ ".tmp/public/jst.js" ]
          "views/**/*.html": [ ".tmp/public/jst.js" ]
          "views/**/*.ejs": [ ".tmp/public/jst.js" ]


    #---------------------------------------------------------------------------js /css script embed into layout.jade
      devJsJADE:
        options:
          startTag: "// SCRIPTS"
          endTag: "// SCRIPTS END"
          fileTmpl: "script(type=\"text/javascript\", src=\"%s\")"
          appRoot: ".tmp/public"

        files:
          "views/**/*.jade": jsFilesToInject

      prodJsJADE:
        options:
          startTag: "// SCRIPTS"
          endTag: "// SCRIPTS END"
          fileTmpl: "script(type=\"text/javascript\", src=\"%s\")"
          appRoot: ".tmp/public"

        files:
          "views/**/*.jade": [ ".tmp/public/min/production-<%= pkg.version %>.js" ]

      devStylesJADE:
        options:
          startTag: "// STYLES"
          endTag: "// STYLES END"
          fileTmpl: "link(rel=\"stylesheet\", href=\"%s\")"
          appRoot: ".tmp/public"

        files:
          "views/**/*.jade": cssFilesToInject

      prodStylesJADE:
        options:
          startTag: "// STYLES"
          endTag: "// STYLES END"
          fileTmpl: "link(rel=\"stylesheet\", href=\"%s\")"
          appRoot: ".tmp/public"

        files:
          "views/**/*.jade": [ ".tmp/public/min/production-<%= pkg.version %>.css" ]


    # Bring in JST template object
      devTplJADE:
        options:
          startTag: "// TEMPLATES"
          endTag: "// TEMPLATES END"
          fileTmpl: "script(type=\"text/javascript\", src=\"%s\")"
          appRoot: ".tmp/public"

        files:
          "views/**/*.jade": [ ".tmp/public/jst.js" ]


  #-------------------------------------------------------------------------------------------------------watch tasks
    watch:
      api:

      # API files to watch:
        files: [ "api/**/*" ]

      assets:

      # Assets to watch:
        files: [ "assets/src/**/*" ]

      # When assets are changed:
        tasks: [ "watchAssets", "linkAssets" ]


  #----------------------------------------------------------------------------------------------------------base tasks
  grunt.registerTask "watchCoffee", [ "newer:coffee:dev", "coffeelint" ]
  grunt.registerTask "watchLess", [ "newer:less:dev", "lesslint" ]
  grunt.registerTask "watchJade", [ "jade:dev", "ngtemplates" ]
  grunt.registerTask "buildCoffee", [ "coffee:dev", "coffeelint" ]
  grunt.registerTask "buildLess", [ "less:dev", "lesslint" ]
  grunt.registerTask "buildJade", [ "clean:templates", "jade:dev", "ngtemplates", "clean:templates" ]

  #-----------------------------------------------------------------------------------------------When Sails is lifted:
  grunt.registerTask "default", [ "watch" ]
  grunt.registerTask "watchAssets", [ "watchCoffee", "watchLess", "watchJade" ]
  grunt.registerTask "buildAssets", [ "clean:dev", "buildCoffee", "buildLess", "buildJade", "copy:dev" ]
  grunt.registerTask "linkAssets", [ "sails-linker:devJs", "sails-linker:devStyles", "sails-linker:devTpl", "sails-linker:devJsJADE", "sails-linker:devStylesJADE", "sails-linker:devTplJADE" ]
  grunt.registerTask "build", [ "clean:build", "buildAssets", "linkAssets", "copy:build" ]

  # When sails is lifted in production
  grunt.registerTask "prod", [ "buildAssets", "copy:prod", "concat", "uglify", "cssmin", "sails-linker:prodJs", "sails-linker:prodStyles", "sails-linker:devTpl", "sails-linker:prodJsJADE", "sails-linker:prodStylesJADE", "sails-linker:devTplJADE" ]

# When API files are changed:
# grunt.event.on('watch', function(action, filepath) {
#   grunt.log.writeln(filepath + ' has ' + action);

#   // Send a request to a development-only endpoint on the server
#   // which will reuptake the file that was changed.
#   var baseurl = grunt.option('baseurl');
#   var gruntSignalRoute = grunt.option('signalpath');
#   var url = baseurl + gruntSignalRoute + '?action=' + action + '&filepath=' + filepath;

#   require('http').get(url)
#   .on('error', function(e) {
#     console.error(filepath + ' has ' + action + ', but could not signal the Sails.js server: ' + e.message);
#   });
# });