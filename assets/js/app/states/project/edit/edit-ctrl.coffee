define [
  'app/states/project/edit/edit-module'
], ->
  module = angular.module 'app.states.project.edit'
  module.controller 'ProjectEditCtrl', ($scope, $state, ProjectData, ProjectService) ->
    $scope.project = angular.copy ProjectData
    $scope.submit = ->
      ProjectService.updateProject($scope.project)
