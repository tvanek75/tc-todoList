<!---
	Requirements: 

	- Through the web service’s API, we need to be able to
		- Create a new todo item for a given user with a due date
		- Mark a todo item as complete
		- Retrieve the todo items for a given user
		- Retrieve the incomplete todo items for a given user
	- All data must be persisted in some manner
	- Both requests and responses must be represented as JSON
	- Neither authentication nor authorization are required
--->
<cfcomponent rest="true" restpath="todo">

	<!--- invoke TaskList service to be used by api methods --->
	<cfset variables.svcTaskList = createObject("component","TaskListService").init()>

	<!--- remote api methods --->

	<cffunction name="getTaskList" access="remote" httpmethod="GET" restpath="{user}" returntype="array" produces="application/json" hint="Return a user's task list.">
		<cfargument name="user" required="true" type="string" restargsource="path">
		<cfset var _ = {}>
		<cfreturn variables.svcTaskList.taskListGet(arguments.user)>
	</cffunction>

	<cffunction name="getTaskListCompleted" access="remote" httpmethod="GET" restpath="{user}/completed" returntype="array" produces="application/json" hint="Return a user's completed task list.">
		<cfargument name="user" required="true" type="string" restargsource="path">
		<cfreturn variables.svcTaskList.taskListGetCompleted(arguments.user)>
	</cffunction>

	<cffunction name="getTask" access="remote" httpmethod="GET" restpath="{user}/{taskId}" returntype="struct" produces="application/json" hint="Return an individual task.">
		<cfargument name="user" required="true" type="string" restargsource="path">
		<cfargument name="taskId" required="true" type="string" restargsource="path">
		<cfreturn variables.svcTaskList.taskListGetTask(arguments.user, arguments.taskId)>
	</cffunction>

	<cffunction name="addTask" access="remote" httpmethod="POST" restpath="{user}/task" returntype="boolean" produces="application/json" hint="Add a task to the user's task list.">
		<cfargument name="user" required="true" type="string" restargsource="path">
		<cfargument name="taskName" required="true" type="string" restargsource="form">
		<cfargument name="taskDueDate" required="true" type="string" restargsource="form">
		<cfreturn variables.svcTaskList.taskListAddTask(arguments.user, arguments.taskName, arguments.taskDueDate)>
	</cffunction>

	<cffunction name="removeTask" access="remote" httpmethod="DELETE" restpath="{user}/remove/{taskId}" returntype="boolean" produces="application/json" hint="Remove a task from the user's task list.">
		<cfargument name="user" required="true" type="string" restargsource="path">
		<cfargument name="taskId" required="true" type="string" restargsource="path">
		<cfreturn variables.svcTaskList.taskListRemoveTask(arguments.user, arguments.taskId)>
	</cffunction>

	<cffunction name="completeTask" access="remote" httpmethod="PUT" restpath="{user}/complete/{taskId}" returntype="boolean" produces="application/json" hint="Complete a task on the user's task list.">
		<cfargument name="user" required="true" type="string" restargsource="path">
		<cfargument name="taskId" required="true" type="string" restargsource="path">
		<cfreturn variables.svcTaskList.taskListCompleteTask(arguments.user, arguments.taskId)>
	</cffunction>

</cfcomponent>