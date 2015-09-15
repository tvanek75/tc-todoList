<cfoutput>
	<!--- prompt for a user --->
	<form method="get" action="#cgi.script_name#">
	<hr>
	<b>User : </b><input id="inputUser" type="text" name="user" value="#htmlEditFormat(request.p.user)#"> <input type="submit" value="continue">
	<hr>
	</form>
</cfoutput>