module Nanosemantic::InfRequestResult

	def result_chats_list(doc)
		doc['list']
	end

	def result_chat_messages(doc)
		doc['list']
	end

	def result_ips_list(doc)
		doc['list']
	end	

	def result_users_list(doc)
		doc['list']
	end	
end