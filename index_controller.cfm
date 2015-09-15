<cfscript>
	request.view = "";

	// default params expected in url/form
	cfparam( name="request.p.user", type="string", default="" );
	cfparam( name="request.p.action", type="string", default="" );

	// add the user form to the view
	savecontent variable="userForm" { include "views/userForm.cfm"; }
	request.view = request.view & userForm;

	request.p.user = urlEncodedFormat(request.p.user);

	// process actions initiated from the simple demo ui
	switch(request.p.action) {

		// if we're adding a task
		case "addTask":
			// default params expected in url/form
			cfparam( name="request.p.taskName", type="string", default="" );
			cfparam( name="request.p.taskDueDate", type="string", default="" );
			// invoke the api to add the task to the user's task list
			cfhttp(
				url = "http://127.0.0.1/rest/trunkclub/todo/#request.p.user#/task" ,
				method = "POST" ,
				result = "restResult"
			) {
				cfhttpparam(type="formfield", name="taskName", value=request.p.taskName);
				cfhttpparam(type="formfield", name="taskDueDate", value=request.p.taskDueDate);
			};
			break;

		// if we're completing a task
		case "completeTask":
			// default params expected in url/form
			cfparam( name="request.p.taskId", type="string", default="" );
			// invoke the api to add the task to the user's task list
			cfhttp(
				url = "http://127.0.0.1/rest/trunkclub/todo/#request.p.user#/complete/#request.p.taskId#" ,
				method = "PUT" ,
				result = "restResult"
			);
			break;

		// if we're removing a task
		case "removeTask":
			// default params expected in url/form
			cfparam( name="request.p.taskId", type="string", default="" );
			// invoke the api to add the task to the user's task list
			cfhttp(
				url = "http://127.0.0.1/rest/trunkclub/todo/#request.p.user#/remove/#request.p.taskId#" ,
				method = "DELETE" ,
				result = "restResult"
			);
			break;

		default: 
			break;
	}

	// if a user has been specififed
	if (len(trim(request.p.user))) {
		// invoke the api to get the user's entire task list
		cfhttp(
			url = "http://127.0.0.1/rest/trunkclub/todo/#request.p.user#" ,
			method = "GET" ,
			result = "restResult"
		);
		variables.list = deserializeJSON(restResult.fileContent);

		// invoke the api again to get the user's completed task sublist
		cfhttp(
			url = "http://127.0.0.1/rest/trunkclub/todo/#request.p.user#/completed" ,
			method = "GET" ,
			result = "restResult"
		);
		variables.listCompleted = deserializeJSON(restResult.fileContent);

		// add the user task list to the view
		savecontent variable="userTaskList" { include "views/userTaskList.cfm"; }
		request.view = request.view & userTaskList;
	}
</cfscript>