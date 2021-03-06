define(['angular'], function() {angular.module('templates', []).run([ '$templateCache', function($templateCache) {  'use strict';

  $templateCache.put('app/states/home/home',
    "<div class=home><div data-panels-list=data-panels-list data-settings=panelsListSettings></div></div>"
  );


  $templateCache.put('app/states/login/login',
    "<h2>Log in</h2><div class=loginContainer><form name=loginForm class=form-login><div data-ng-class=\"{'has-error': loginForm.name.$invalid &amp;&amp; !loginForm.name.$pristine}\" class=form-group><label>Name</label><input placeholder=\"your name\" name=name required data-ng-model=user.name maxlength=100 class=\"form-control\"><p data-ng-show=\"loginForm.name.$invalid &amp;&amp; !loginForm.name.$pristine\" class=error>Required.</p></div><div data-ng-class=\"{'has-error': loginForm.password.$invalid &amp;&amp; !loginForm.password.$pristine}\" class=form-group><label>Password</label><input type=password placeholder=password name=password required data-ng-model=user.password maxlength=100 class=\"form-control\"><p data-ng-show=\"loginForm.password.$invalid &amp;&amp; !loginForm.password.$pristine\" class=error>Required.</p></div><button type=submit data-ng-click=sumbit() class=\"btn btn-lg btn-primary btn-block\">Log in</button></form><a data-ng-click=goToSignup() class=\"btn btn-lg btn-primary btn-block\">Sign up</a></div>"
  );


  $templateCache.put('app/states/project/details/details',
    "<div class=\"container projectDetail\"><div><div data-ng-hide=\"settings.editKey == 'name'\"><h2>{{project.name}}</h2><a data-click-btn=data-click-btn data-ng-click=\"settings.editKey = 'name'\">Edit</a></div><div data-ng-show=\"settings.editKey == 'name'\"><textarea data-ng-model=editingProject.name placeholder=\"Edit name description\"></textarea><a data-click-btn=data-click-btn data-ng-click=save()>Save</a><a data-click-btn=data-click-btn data-ng-click=\"cancelEditing('name')\">Close</a></div></div><div><h3>Status</h3><p>current state, project health, project priority, project status, project start date, project due date, project users</p></div><div><h3>Description</h3><div data-ng-hide=\"settings.editKey == 'description'\"><a data-click-btn=data-click-btn data-ng-click=\"settings.editKey = 'description'\">Edit</a><div>{{project.description}}</div></div><div data-ng-show=\"settings.editKey == 'description'\"><textarea data-ng-model=editingProject.description placeholder=\"Edit project description\"></textarea><a data-click-btn=data-click-btn data-ng-click=save()>Save</a><a data-click-btn=data-click-btn data-ng-click=\"cancelEditing('description')\">Close</a></div></div><div><h3>Charts</h3><a data-click-btn=data-click-btn data-ng-click=showAllCharts()>Show all</a><ul><li><a data-click-btn=data-click-btn data-ng-click=showChartCurrent()>Current state</a></li><li><a data-click-btn=data-click-btn data-ng-click=showChartALL()>All states</a></li></ul><ul><li><a data-click-btn=data-click-btn data-ng-click=showBurnDownChart()>Burn down</a></li><li><a data-click-btn=data-click-btn data-ng-click=showProgressChart()>Process</a></li><li><a data-click-btn=data-click-btn data-ng-click=showUsersChart()>Users</a></li><li><a data-click-btn=data-click-btn data-ng-click=showTasksChart()>Tasks</a></li></ul><div class=chart-container></div></div><div><h3>Progress</h3><div><a data-ng-click=\"settings.editKey = 'newStage'\" href=javascript:void(0) data-ng-hide=\"settings.editKey == 'newStage'\" class=\"btn btn-medium btn-primary\">Add Stage</a><div data-ng-show=\"settings.editKey == 'newStage'\"><input data-ng-model=newStage.name placeholder=\"new stage name\"><a data-click-btn=data-click-btn data-ng-click=addStage()>Save</a><a data-click-btn=data-click-btn data-ng-click=\"cancelEditing('newStage')\">Close</a></div></div><div data-project-stages=data-project-stages data-settings=projectStagesSettings></div></div><h3>Data binding</h3><div class=row><div class=col-sm-12><pre class=code>{{project | json}}</pre></div></div></div>"
  );


  $templateCache.put('app/states/project/details/projectstages/projectstages',
    "<div data-ui-tree=options data-drag-delay=10 data-max-depth=5 class=projectStages><ul data-ui-tree-nodes=data-ui-tree-nodes data-ng-model=settings.data.stages type=stage><li data-ng-repeat=\"stage in settings.data.stages \" data-ui-tree-node=data-ui-tree-node data-ng-style=\"{'min-height':'32px'}\"><div data-ng-hide=\"editingStage.id == stage.id\"><a data-click-btn=data-click-btn data-ng-click=removeStage(stage) data-nodrag=data-nodrag class=\"btn btn-danger btn-xs pull-right\"><i class=\"glyphicon glyphicon-remove\"></i><i class=sr-only>Remove stage</i></a><a data-click-btn=data-click-btn data-ng-click=\"editStage(stage, 'name')\" data-nodrag=data-nodrag class=\"btn btn-primary btn-xs pull-right\"><i class=\"glyphicon glyphicon-pencil\"></i><i class=sr-only>Edit stage</i></a><div>&nbsp;{{stage.name}} id:{{stage.id}}</div></div><div data-ng-show=\"editingStage.id == stage.id\"><div class=input-group><label for=editingStageName class=sr-only>Stage name</label><input placeholder=\"Stage name\" data-ng-model=editingStage.name id=editingStageName class=\"form-control\"></div><span class=input-group-btn><a data-click-btn=data-click-btn data-ng-click=saveEditingStage(stage) data-nodrag=data-nodrag class=\"btn btn-success btn-xs\"><i class=\"glyphicon glyphicon-ok\"></i><i class=sr-only>Save editing stage</i></a><a data-click-btn=data-click-btn data-ng-click=resetEditingStage() data-nodrag=data-nodrag class=\"btn btn-default btn-xs\"><i class=\"glyphicon glyphicon-remove\"></i><i class=sr-only>Save editing stage</i></a></span></div><div data-nodrag=data-nodrag><a data-ng-click=showNewTaskFieldToStage(stage) href=javascript:void(0) data-ng-hide=\"settings.editingKey == stage.id+'_task'\" class=\"btn btn-small\">Add Task</a></div><div data-ng-show=\"settings.editingKey == stage.id+'_task'\" data-nodrag=data-nodrag><label for=newTaskName_{{stage.id}} class=sr-only>Task name</label><input data-ng-model=newTask.name placeholder=\"task name\" id=\"newTaskName_{{stage.id}}\"><a data-click-btn=data-click-btn data-ng-click=addTaskToStage(stage) data-nodrag=data-nodrag>Save</a><a data-click-btn=data-click-btn data-ng-click=\"settings.editingKey = null\">Close</a></div><div data-stage-tasks=data-stage-tasks data-stage=stage></div></li></ul></div>"
  );


  $templateCache.put('app/states/project/details/stagetasks/stagetasks',
    "<div data-ui-tree=options data-drag-delay=10 data-max-depth=5 class=stageTasks><ul data-ui-tree-nodes=data-ui-tree-nodes data-ng-model=stage.tasks type=task data-stage-id={{stage.id}}><li data-ng-repeat=\"task in stage.tasks \" data-ui-tree-node=data-ui-tree-node data-ng-style=\"{'min-height':'32px'}\"><div data-ng-hide=\"editingTask.id == task.id\"><a data-click-btn=data-click-btn data-ng-click=destroyTask(task) data-nodrag=data-nodrag class=\"btn btn-danger btn-xs pull-right\"><i class=\"glyphicon glyphicon-remove\"></i><i class=sr-only>Remove task</i></a><a data-click-btn=data-click-btn data-ng-click=\"editTask(task, 'name')\" data-nodrag=data-nodrag class=\"btn btn-primary btn-xs pull-jright\"><i class=\"glyphicon glyphicon-pencil\"></i><i class=sr-only>Edit task</i></a><div>&nbsp;{{task.name}}:idStage:{{task.idStage}}</div></div><div data-ng-show=\"editingTask.id == task.id\"><div class=input-group><label for=editingTaskName class=sr-only>Task name</label><input placeholder=\"Task name\" data-ng-model=editingTask.name id=editingTaskName class=\"form-control\"></div><span class=input-group-btn><a data-click-btn=data-click-btn data-ng-click=saveEditingTask(task) data-nodrag=data-nodrag class=\"btn btn-success btn-xs\"><i class=\"glyphicon glyphicon-ok\"></i><i class=sr-only>Save editing task</i></a><a data-click-btn=data-click-btn data-ng-click=resetEditingTask() data-nodrag=data-nodrag class=\"btn btn-default btn-xs\"><i class=\"glyphicon glyphicon-remove\"></i><i class=sr-only>Save editing task</i></a></span></div></li></ul></div>"
  );


  $templateCache.put('app/states/project/list/list',
    "<div class=\"container userList\"><h3>Project List</h3><div class=container><ul><li data-ng-repeat=\"project in projects\"><a data-ng-click=show(project) href=javascript:void(0);><span>{{project.name}}</span></a><a data-ng-click=edit(project) href=javascript:void(0);><span>edit</span></a><a data-ng-click=destroy(project) href=javascript:void(0);><span>delete</span></a></li></ul></div></div>"
  );


  $templateCache.put('app/states/project/project',
    "<div class=\"container project\"><div data-ui-view=projectChildView></div></div>"
  );


  $templateCache.put('app/states/user/details/details',
    "<div class=\"container userDetail\"><h3>detail pages</h3><p>{{user.name}}</p><p>{{user.email}}</p><a data-ng-click=edit() href=javascript:void(0) class=\"btn btn-medium btn-primary\">Edit</a></div>"
  );


  $templateCache.put('app/states/user/form/form',
    "<h2>{{formTitle}}</h2><div class=userForm><form name=userForm><div data-ng-class=\"{'has-error': userForm.name.$invalid &amp;&amp; !userForm.name.$pristine}\" class=form-group><label>User Name</label><input placeholder=\"user name\" name=name required data-ng-model=user.name maxlength={{attributes.name.maxLength}} class=\"form-control\"><p data-ng-show=\"userForm.name.$invalid &amp;&amp; !userForm.name.$pristine\" class=error>Required.</p></div><div data-ng-class=\"{'has-error': userForm.email.$invalid &amp;&amp; !userForm.email.$pristine}\" class=form-group><label>Email</label><input type=email placeholder=\"email address\" name=email required data-ng-model=user.email maxlength={{attributes.email.maxLength}} class=\"form-control\"><p data-ng-show=\"userForm.email.$invalid &amp;&amp; !userForm.email.$pristine\" class=error>Enter a valid email.</p></div><div data-ng-class=\"{'has-error': userForm.password.$invalid &amp;&amp; !userForm.password.$pristine}\" class=form-group><label>Password</label><input type=password placeholder=password name=password required data-ng-model=user.password maxlength={{attributes.password.maxLength}} class=\"form-control\"><p data-ng-show=\"userForm.password.$invalid &amp;&amp; !userForm.password.$pristine\" class=error>Required.</p></div><div data-ng-class=\"{'has-error': (userForm.confirmPassword.$invalid || userForm.confirmPassword.$error.match) &amp;&amp; !userForm.confirmPassword.$pristine}\" class=form-group><label>Confirm password</label><input type=password placeholder=\"confirm password\" name=confirmPassword required data-ng-model=user.confirmPassword data-field-match={{user.password}} maxlength={{attributes.confirmPassword.maxLength}} class=\"form-control\"><p data-ng-show=\"userForm.confirmPassword.$error.match &amp;&amp; !userForm.confirmPassword.$pristine\" class=error>Password dosen't match</p></div><button type=submit data-ng-click=sumbit() href=javascript:void(0); class=\"btn btn-lg btn-primary btn-block\">{{submitBtnText}}</button></form></div>"
  );


  $templateCache.put('app/states/user/list/list',
    "<div class=\"container userList\"><h3>User List</h3><div class=container><ul><li data-ng-repeat=\"user in users\"><span data-ng-show=user.online>[online]</span><a data-ng-click=show(user) href=javascript:void(0);><span>{{user.name}}</span></a><a data-ng-click=edit(user) href=javascript:void(0);><span>edit</span></a><a data-ng-click=destroy(user) href=javascript:void(0);><span>delete</span></a></li></ul></div></div>"
  );


  $templateCache.put('app/states/user/user',
    "<h2>User</h2><div class=container><div data-ui-view=userChildView></div></div>"
  );


  $templateCache.put('common/navigation/navigation',
    "<div class=navigation></div><ul class=\"nav nav-pills\"><li><a data-click-btn=data-click-btn data-ng-click=toggleProjectsList($event)>Projects</a></li><li>each type group buttons</li><li><a data-ui-sref=user.list>User</a></li><li><a data-ui-sref=signup>Signup</a></li><li><a href=JavaScript:void(0); data-ng-click=logout()>Logout</a></li></ul><ul data-ng-show=\"dropDownSettings.data != null\" class=dropdown-list-container><li><a data-click-btn=data-click-btn data-ng-click=showAll()>show all</a></li><li><a data-click-btn=data-click-btn data-ng-click=toggleNewProjectPanel($event)>new project</a><div data-ng-show=newProjectSettings.visible><input data-ng-model=newProjectSettings.data.name placeholder=\"New project name\"><a data-click-btn=data-click-btn data-ng-click=createProject()>add</a></div></li><li>-----------------</li><li data-ng-repeat=\"item in dropDownSettings.data\"><a data-click-btn=data-click-btn data-ng-click=selectItem(item)>{{item.name}}</a></li></ul>"
  );


  $templateCache.put('common/pagination/pagination',
    "<ul class=pagination><li data-ng-class=\"{disabled:index == 0 || displayPages.length == 0}\"><a href=JavaScript:void(0); data-ng-click=first()>&laquo;</a></li><li data-ng-class=\"{disabled:index == 0 || displayPages.length == 0}\"><a href=JavaScript:void(0); data-ng-click=previous()>&lt;</a></li><li data-ng-repeat=\"page in displayPages\" data-ng-class={active:page.current}><a href=JavaScript:void(0); data-ng-click=goPage(page)>{{page.index+1}}</a></li><li data-ng-class=\"{disabled:index &gt;= lastPage.first || displayPages.length == 0}\"><a href=JavaScript:void(0); data-ng-click=next()>&gt;</a></li><li data-ng-class=\"{disabled:index &gt;= lastPage.first || displayPages.length == 0}\"><a href=JavaScript:void(0); data-ng-click=last()>&raquo;</a></li></ul>"
  );


  $templateCache.put('common/panelslist/panelslist',
    "<div class=panelsList><h2>project list</h2><div data-ng-repeat=\"panel in settings.data\"><h3>{{panel.name}}</h3></div></div>"
  );


  $templateCache.put('common/uitree/uitreelist',
    "<div class=tree-node><div data-ui-tree-handle=data-ui-tree-handle class=\"pull-left tree-handle\"><span class=\"glyphicon glyphicon-list\"></span></div><div class=tree-node-content><a data-nodrag=data-nodrag data-ng-click=toggle(this) class=\"btn btn-success btn-xs\"><span data-ng-class=\"{'glyphicon-chevron-right': collapsed, 'glyphicon-chevron-down': !collapsed}\" class=glyphicon></span></a>{{task.name}}<a data-nodrag=data-nodrag data-ng-click=remove(this) class=\"pull-right btn btn-danger btn-xs\"><span class=\"glyphicon glyphicon-remove\"></span><span class=sr-only>Remove</span></a><a data-nodrag=data-nodrag data-ng-click=edit(this) class=\"pull-right btn btn-primary btn-xs\"><span class=\"glyphicon glyphicon-pencil\"></span><span class=sr-only>Edit</span></a><a data-nodrag=data-nodrag data-ng-click=newTask(this) style=\"margin-right: 8px\" class=\"pull-right btn btn-primary btn-xs\"><span class=\"glyphicon glyphicon-plus\"></span><span class=sr-only>Add</span></a></div><ol data-ui-tree-nodes=data-ui-tree-nodes data-ng-model=task.tasks data-ng-class=\"{hidden: collapsed}\"><li data-ng-repeat=\"task in task.tasks\" data-ui-tree-node=data-ui-tree-node data-ng-include=\"'common/uitree/uitreelist'\"></li></ol></div>"
  );
} ]);});