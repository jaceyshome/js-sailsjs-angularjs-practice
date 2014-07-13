define [
  'angular'
  'angular_ui_router'
  'bootstrap'
  'jquery'
  'common/utility/utility'
  'common/csrf/csrf'
  'app/states/home/home-ctrl'
  'app/states/user/user-ctrl'
  'app/states/user/detail/detail-ctrl'
  'app/states/signup/signup-ctrl'
], ->
  module = angular.module 'app', [
    'ui.router'
    'app.states.home'
    'app.states.signup'
    'app.states.user'
    'app.states.user.detail'
  ]
  module.config ($locationProvider, $urlRouterProvider)->
    $locationProvider.html5Mode(true)
    $urlRouterProvider.otherwise('/user/detail')

  module.controller 'MainCtrl', ($scope, $rootScope, $state) ->
    $scope.ready = true

  module
