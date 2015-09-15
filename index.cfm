<!--- re-init rest api to apply updates (dev only) --->
<cfset restInitApplication("/Users/tyson/Sites/trunkclub/api","trunkclub")>

<!--- include our controller (to process all form actions from the simple demo ui) --->
<cfinclude template="index_controller.cfm">

<!--- simple interface to demonstrate the api --->
<cfoutput>
<html>
<head>
	<!--- simple css --->
	<style>
		* { font-family: verdana, Arial, Helvetica; }
		th, td { border: 1px solid ##000; }
		th.title { background-color: ##aaa; }
		tr.noborders > td { border: 0; }
	</style>
	<!--- load jquery components --->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
	<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
	<!--- jquery to control input focus based on app state --->
	<script>
		$(document).ready(function(){
			$("##inputUser").focus();
			<cfif len(trim(request.p.user))>
				$("##inputTaskName").focus();
				$("##inputTaskDueDate").blur(function(){
					$("##btnAddTask").focus();
				});
			</cfif>
			$("##inputTaskDueDate").datepicker();
		});
	</script>
</head>
<body>
#request.view#
</body>
</html>
</cfoutput>