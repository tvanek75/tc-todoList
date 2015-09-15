<cfoutput>
	<!--- display all the user's tasks --->
	<table cellpadding="4" width="100%">
		<tr>
			<th class="title" colspan="5">All Tasks</th>
		</tr>
		<tr>
			<th>Id</th>
			<th>Name</th>
			<th>DueDate</th>
			<th>Completed</th>
			<th>Action</th>
		</tr>
		<!--- output the task list --->
		<cfloop from="1" to="#arrayLen(variables.list)#" index="i">
			<tr>
				<td>#variables.list[i].taskId#</td>
				<td>#variables.list[i].taskName#</td>
				<td>#variables.list[i].taskDueDate#</td>
				<td>#variables.list[i].taskCompleted# <cfif not variables.list[i].taskCompleted>(<a href="#cgi.script_name#?action=completeTask&user=#request.p.user#&taskId=#variables.list[i].taskId#">complete</a>)</cfif></td>
				<td>(<a href="#cgi.script_name#?action=removeTask&user=#request.p.user#&taskId=#variables.list[i].taskId#">remove</a>)</td>
			</tr>
		</cfloop>
		<!--- if there aren't any tasks --->
		<cfif not arrayLen(variables.list)>
			<tr>
				<td colspan="5" align="center">No tasks</td>
			</tr>
		</cfif>
		<!--- render form to add new tasks to the user's list --->
		<form method="post" action="#cgi.script_name#?user=#request.p.user#">
		<input type="hidden" name="action" value="addTask">
		<tr class="noborders">
			<td align="right">Add a new task</td>
			<td><input id="inputTaskName" type="text" name="taskName" style="width:100%;"></td>
			<td><input id="inputTaskDueDate" type="text" name="taskDueDate" style="width:100%;"></td>
			<td colspan="2" align="center"><input id="btnAddTask" type="submit" value="add task" style="width:100%;"></td>
		</tr>
		</form>
	</table>

	<hr style="margin:20px;">

	<!--- display all the user's completed tasks --->
	<table cellpadding="4" width="100%">
		<tr>
			<th class="title" colspan="5">Completed Tasks</th>
		</tr>
		<tr>
			<th>Id</th>
			<th>Name</th>
			<th>DueDate</th>
			<th>Completed</th>
			<th>Action</th>
		</tr>
		<!--- output the task list --->
		<cfloop from="1" to="#arrayLen(variables.listCompleted)#" index="i">
			<tr>
				<td>#variables.listCompleted[i].taskId#</td>
				<td>#variables.listCompleted[i].taskName#</td>
				<td>#variables.listCompleted[i].taskDueDate#</td>
				<td>#variables.listCompleted[i].taskCompleted# <cfif not variables.listCompleted[i].taskCompleted><a href=""></cfif></td>
				<td>(<a href="#cgi.script_name#?action=removeTask&user=#request.p.user#&taskId=#variables.listCompleted[i].taskId#">remove</a>)</td>
			</tr>
		</cfloop>
		<cfif not arrayLen(variables.listCompleted)>
			<tr>
				<td colspan="5" align="center">No completed tasks</td>
			</tr>
		</cfif>
	</table>
</cfoutput>