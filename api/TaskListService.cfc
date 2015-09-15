<cfcomponent displayname="TaskListService">

	<cffunction name="init" access="public" returntype="TaskListService" output="No" hint="TaskList Constructor">
		<!--- invoke datastore service to be used for data persistence --->
		<cfset variables.svcDatastore = createObject("component","DatastoreService").init()>

		<cfreturn this />
	</cffunction>

	<!--- public methods --->

	<cffunction name="taskListGet" access="public" returntype="array" hint="Return a user's task list.">
		<cfargument name="user" required="true" type="string">

		<!--- read, deserialize, and return the user's task list from the datastore --->
		<cfreturn deserializeJSON(variables.svcDatastore.datastoreRead(arguments.user))>
	</cffunction>

	<cffunction name="taskListGetCompleted" access="public" returntype="array" hint="Return a user's completed task list.">
		<cfargument name="user" required="true" type="string">
		<cfset var _ = {}>

		<!--- init a list of completed tasks --->
		<cfset _.listCompleted = []>
		<!--- get the user's task list --->
		<cfset _.list = taskListGet(arguments.user)>
		<!--- loop through the tasks --->
		<cfloop from="1" to="#arrayLen(_.list)#" index="_.i">
			<!--- if this task is completed --->
			<cfif _.list[_.i]["taskCompleted"]>
				<!--- add this task to the array of completed tasks --->
				<cfset arrayAppend(_.listCompleted,_.list[_.i])>
			</cfif>
		</cfloop>

		<!--- return the list of completed tasks --->
		<cfreturn _.listCompleted>
	</cffunction>

	<cffunction name="taskListAddTask" access="public" returntype="boolean" hint="Add a task to a user's task list.">
		<cfargument name="user" required="true" type="string">
		<cfargument name="taskName" required="true" type="string">
		<cfargument name="taskDueDate" required="true" type="date">
		<cfset var _ = {}>

		<cftry>
			<!--- instantiate a new task bean --->
			<cfset _.newTask = createObject("component","TaskBean").init(
				taskId = createUUID() ,
				taskName = arguments.taskName ,
				taskDueDate = arguments.taskDueDate ,
				taskCompleted = false
			)>

			<!--- get the user's task list --->
			<cfset _.list = taskListGet(arguments.user)>

			<!--- add the new task to the user's task list --->
			<cfset arrayAppend(_.list,_.newTask.getMemento())>
			<!--- serialize the updated task list --->
			<cfset _.listJSON = serializeJSON(_.list)>
			<!--- write the updated task list to the datastore --->
			<cfset variables.svcDatastore.datastoreSave(arguments.user,_.listJSON)>

			<cfreturn true>

			<cfcatch type="any">
				<cfreturn false>
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="taskListRemoveTask" access="public" returntype="boolean" hint="Remove a task from a user's task list.">
		<cfargument name="user" required="true" type="string">
		<cfargument name="taskId" required="true" type="string">
		<cfset var _ = {}>

		<cftry>
			<!--- get the user's task list --->
			<cfset _.list = taskListGet(arguments.user)>
			<!--- loop throught the task list --->
			<cfloop from="#arrayLen(_.list)#" to="1" step="-1" index="_.i">
				<!--- if this is the task being removed --->
				<cfif _.list[_.i].taskId eq arguments.taskId>
					<!--- remove the task from the task list and break the loop --->
					<cfset arrayDeleteAt(_.list,_.i)>
					<cfbreaK>
				</cfif>
			</cfloop>
			<!--- serialize te updated task list --->
			<cfset _.listJSON = serializeJSON(_.list)>
			<!--- write the update task list to the datastore --->
			<cfset variables.svcDatastore.datastoreSave(arguments.user,_.listJSON)>

			<cfreturn true>

			<cfcatch type="any">
				<cfreturn false>
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="taskListCompleteTask" access="public" returntype="boolean" hint="Complete a task on a user's task list.">
		<cfargument name="user" required="true" type="string">
		<cfargument name="taskId" required="true" type="string">
		<cfset var _ = {}>

		<cftry>
			<!--- get the user's task list --->
			<cfset _.list = taskListGet(arguments.user)>
			<!--- loop throught the task list --->
			<cfloop from="1" to="#arrayLen(_.list)#" index="_.i">
				<!--- if this is the task being completed --->
				<cfif _.list[_.i].taskId eq arguments.taskId>
					<!--- mark the task as completed and break the loop --->
					<cfset _.list[_.i].taskCompleted = true>
					<cfbreaK>
				</cfif>
			</cfloop>
			<!--- serialize te updated task list --->
			<cfset _.listJSON = serializeJSON(_.list)>
			<!--- write the update task list to the datastore --->
			<cfset variables.svcDatastore.datastoreSave(arguments.user,_.listJSON)>

			<cfreturn true>

			<cfcatch type="any">
				<cfreturn false>
			</cfcatch>
		</cftry>
	</cffunction>

</cfcomponent>