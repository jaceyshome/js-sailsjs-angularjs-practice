define [
  'app/states/home/home-module'
], ->
  module = angular.module 'app.states.home'
  module.controller 'HomeCtrl', ($scope) ->
    # -------------------------------------------------------------------------------- $scope Variables

    # -------------------------------------------------------------------------------- Private Variables

    # -------------------------------------------------------------------------------- init
    init = () ->
      console.log "hello HomeCtrl"
    # -------------------------------------------------------------------------------- $scope Functions

    # -------------------------------------------------------------------------------- Private Functions

    # -------------------------------------------------------------------------------- Handler Functions

    # -------------------------------------------------------------------------------- Helper Functions

    # -------------------------------------------------------------------------------- init()
    init()