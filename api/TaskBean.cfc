<cfcomponent displayname="Task" output="false" hint="I am the Task Class.">

	<cfproperty name="taskId" type="string" default="" />
	<cfproperty name="taskName" type="string" default="" />
	<cfproperty name="taskDueDate" type="string" default="" />
	<cfproperty name="taskCompleted" type="string" default="" />

	<!--- pseudo-constructor --->
	<cfset variables.instance = {
		taskId = "" ,
		taskName = "" ,
		taskDueDate = "" ,
		taskCompleted = ""
	} />

	<cffunction name="init" access="public" output="false" returntype="any" hint="I am the constructor method for the Task Class.">
		<cfargument name="taskId" required="true" type="string" default="" hint="I am the task id." />
		<cfargument name="taskName" required="true" type="string" default="" hint="I am the task name." />
		<cfargument name="taskDueDate" required="true" type="string" default="" hint="I am the task name." />
		<cfargument name="taskCompleted" required="true" type="string" default="" hint="I am the task name." />

		<!--- set the initial values of the bean --->
		<cfscript>
			setTaskId(arguments.taskId);
			setTaskName(arguments.taskName);
			setTaskDueDate(arguments.taskDueDate);
			setTaskCompleted(arguments.taskCompleted);
		</cfscript>

		<cfreturn this />
	</cffunction>

	<!--- getters / accessors --->
	<cffunction name="getTaskId" access="public" output="false" hint="I return the task id.">
		<cfreturn variables.instance.taskId />
	</cffunction>

	<cffunction name="getTaskName" access="public" output="false" hint="I return the task name.">
		<cfreturn variables.instance.taskName />
	</cffunction>

	<cffunction name="getTaskDueDate" access="public" output="false" hint="I return the task due date.">
		<cfreturn variables.instance.taskDueDate />
	</cffunction>

	<cffunction name="getTaskCompleted" access="public" output="false" hint="I return the task completed.">
		<cfreturn variables.instance.taskCompleted />
	</cffunction>

	<!--- setters / mutators --->
	<cffunction name="setTaskId" access="public" output="false" hint="I set the task id into the variables.instance scope.">
		<cfargument name="taskId" required="true" type="string" hint="I am the task id." />
		<cfset variables.instance.taskId = arguments.taskId />
	</cffunction>

	<cffunction name="setTaskName" access="public" output="false" hint="I set the task name into the variables.instance scope.">
		<cfargument name="taskName" required="true" type="string" hint="I am the task name." />
		<cfset variables.instance.taskName = arguments.taskName />
	</cffunction>

	<cffunction name="setTaskDueDate" access="public" output="false" hint="I set the task due date into the variables.instance scope.">
		<cfargument name="taskDueDate" required="true" type="string" hint="I am the task due date." />
		<cfset variables.instance.taskDueDate = arguments.taskDueDate />
	</cffunction>

	<cffunction name="setTaskCompleted" access="public" output="false" hint="I set the task completed into the variables.instance scope.">
		<cfargument name="taskCompleted" required="true" type="string" hint="I am the task completed." />
		<cfset variables.instance.taskCompleted = arguments.taskCompleted />
	</cffunction>

	<!--- utils --->
	<cffunction name="getMemento" access="public" output="false" hint="I return a dumped struct of the variables.instance scope.">
		<cfreturn variables.instance />
	</cffunction>

</cfcomponent>