module Nanosemantic::RequestRetval

	def retval_global(doc)
		@error = doc
		@errormsg = "unkown api called response"		
	end

	def retval_chats_list(doc)
		@error = doc['error']['code']
		@errormsg = doc['error']['message']
		raise Nanosemantic::ResultError, [@error, @errormsg].join(' ') unless @error.nil?
	end
end