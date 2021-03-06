define [
  'angular'
  'app/states/project/details/details-module'
], ->
  module = angular.module 'app.states.project.details'
  module.controller 'ProjectDetailsCtrl', ($scope, $state, Project, ProjectService, StageService) ->
    $scope.project = Project
    $scope.editingProject = angular.copy Project
    $scope.projectStagesSettings = null
    $scope.newStage =
      idProject: Project.id
      name: ""
    $scope.settings =
      editKey: null

    init = ->
      setProjectStagesSettings()

    setProjectStagesSettings = ->
      $scope.projectStagesSettings =
        data: Project

    reset = ()->
      $scope.settings =
        editKey: null

    #----------------------------- $scope functions -----------------------
    $scope.save = ()->
      ProjectService.updateProject($scope.editingProject).then(reset)

    $scope.cancelEditing = (key)->
      $scope.editingProject[key] = $scope.project[key]
      reset()

    $scope.addStage = ()->
      $scope.project.stages = [] unless $scope.project.stages
      StageService.createStage($scope.newStage).then ()->
        reset()
        $scope.newStage =
          idProject: Project.id
          name: ""

    #----------------------------- init() ---------------------------------
    init()
