define [
  'app/states/login/login-module'
  'app/states/login/login-service'
], ->
  module = angular.module 'app.states.login'
  module.controller 'LoginCtrl', [
    '$scope','$state','LoginService','UserService','ValidationService','MessageService','LoginService',(
      $scope, $state ,LoginService, UserService, ValidationService, MessageService
    ) ->
      $scope.user = []

      init = ->
        $scope.attributes = ValidationService.getModelAttributes(
          'user', ['name', 'password'])

      $scope.sumbit = ()->
        message = ValidationService.validate(
          values:$scope.user
          attributes: $scope.attributes
        )
        if message
          MessageService.showError(message)
          return
        LoginService.login($scope.user).then (result)->
          if result
            $state.go 'home'
          else
            MessageService.showError('Login fail')

      $scope.goToSignup = ->
        $state.go "signup"

      init()
  ]