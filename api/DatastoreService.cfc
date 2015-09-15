<cfcomponent displayname="DatastoreService">

	<cffunction name="init" access="public" returntype="DatastoreService" output="No" hint="Datastore Constructor">
		<!--- set our datastore directory --->
		<cfset variables.datastoreDirectory = "/Users/tyson/Sites/trunkclub/api/data">
		<!--- if the datastore directory doesn't exist on the file system, create it --->
		<cfif not directoryExists(variables.datastoreDirectory)>
			<cfdirectory action="create" directory="#variables.datastoreDirectory#">
		</cfif>
		<cfreturn this />
	</cffunction>

	<!--- public methods --->

	<cffunction name="datastoreCreate" access="public" returntype="boolean" hint="Create a JSON datastore for the given user.">
		<cfargument name="user" required="true" type="string">

		<cftry>
			<cfset datastoreSave(arguments.user,serializeJSON([]))>
			<cfreturn true>
			<cfcatch type="any">
				<cfreturn false>
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="datastoreRead" access="public" returntype="string" hint="Private method to read a JSON datastore for a given user.">
		<cfargument name="user" required="true" type="string">
		<cfset var _ = {}>

		<cfif not datastoreExists(arguments.user)>
			<cfset datastoreCreate(arguments.user)>
		</cfif>
		<cffile action="read" file="#datastoreFilePath(arguments.user)#" variable="_.listJSON">
		<cfreturn _.listJSON>
	</cffunction>

	<cffunction name="datastoreSave" access="public" returntype="boolean" hint="Private method to save a JSON datastore for a given user.">
		<cfargument name="user" required="true" type="string">
		<cfargument name="listJSON" required="true" type="string">

		<cftry>
			<cffile action="write" file="#variables.datastoreDirectory#/#datastoreFilename(arguments.user)#" output="#arguments.listJSON#" nameconflict="overwrite">
			<cfreturn true>
			<cfcatch type="any">
				<cfreturn false>
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="datastoreDelete" access="public" returntype="boolean" hint="Method to delete a JSON datastore for a given user.">
		<cfargument name="user" required="true" type="string">

		<cftry>
			<cfif datastoreExists(arguments.user)>
				<cffile action="delete" file="#datastoreFilePath(arguments.user)#">
			</cfif>
			<cfcatch type="any">
				<cfreturn false>
			</cfcatch>
		</cftry>
	</cffunction>

	<!--- private methods --->

	<cffunction name="datastoreFilename" access="private" returntype="string" hint="Private method that returns the JSON datastore filename for a given user.">
		<cfargument name="user" required="true" type="string">

		<cfreturn "#hash(arguments.user)#.json">
	</cffunction>

	<cffunction name="datastoreFilePath" access="private" returntype="string" hint="Private method that returns the JSON datastore filepath for a given user.">
		<cfargument name="user" required="true" type="string">

		<cfreturn "#variables.datastoreDirectory#/#datastoreFilename(arguments.user)#">
	</cffunction>

	<cffunction name="datastoreExists" access="private" returntype="boolean" hint="Private method to determine if the JSON datastore exists for a given user.">
		<cfargument name="user" required="true" type="string">

		<cfreturn fileExists("#datastoreFilePath(arguments.user)#")>
	</cffunction>

</cfcomponent>