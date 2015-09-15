component {
	function onRequest( string targetPage ) {
		try {
			// aggregate all url and form vars into request.p (form takes precedence)
			request.p = {};
			if (isDefined("url") and isStruct(url))
				structAppend(request.p,url);
			if (isDefined("form") and isStruct(form))
				structAppend(request.p,form);

			include arguments.targetPage;
		} catch (any e) {
			//handle the exception
		}
	}
}