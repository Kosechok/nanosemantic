module Nanosemantic::RequestResult

	def result_chats_list(doc)
		doc['list']
	end

	def result_chat_messages(doc)
		doc['list']
	end

	def result_ips_list(doc)
		doc['list']
	end	
end