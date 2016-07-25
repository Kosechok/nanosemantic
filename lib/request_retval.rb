module Nanosemantic::RequestRetval

	def retval_global(doc)
		@error = doc
		@errormsg = "unkown api called response"		
	end

	def retval_chats_list(doc)
		if doc.has_key?("error")
			@error = doc['error']['code']
			@errormsg = doc['error']['message']
		end
		raise Nanosemantic::ResultError, [@error, @errormsg].join(' ') unless @error.nil?
	end
end