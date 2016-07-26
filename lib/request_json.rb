module Nanosemantic::RequestJson

	def json_chats_list(opt)
		body = {
		    request: {
		    	clientId: @clientid,
		    	uuid:     @uuid,
		    	period: {
		        	from: opt[:start] || Date.today.to_time.to_i - 86400,
		        	to: opt[:finish] || Date.today.to_time.to_i
		    	},
		    	ts: DateTime.now.to_i
		    }
		  }
		if %w(ip userid status).map(&:to_sym).any? { |key| opt.key?(key)  }  
			filter = { 
						filters: {
			        		ip: 	opt[:ip] || nil,
			        		userId: opt[:userid] || nil,
			        		status: opt[:status] || nil
			        	}
			    	} 
			body = body.merge(filter)
		end
		return body

		
	end

	def json_chat_messages(opt)
		body = {
			request: {
				clientId: @clientid,
				uuid:     @uuid,
				chatId:   opt[:chat_id],
				ts: DateTime.now.to_i
			}
		}
	end

	def json_ips_list(opt)
		body = {
			request: {
				clientId: @clientid,
				uuid:     @uuid,
		    	period: {
		        	from: opt[:start] || Date.today.to_time.to_i - 86400,
		        	to: opt[:finish] || Date.today.to_time.to_i
		    	},
		    	ts: DateTime.now.to_i				
			}
		}
		if %w(userid status).map(&:to_sym).any? { |key| opt.key?(key)  }  
			filter = { 
						filters: {
			        		userId: opt[:userid] || nil,
			        		status: opt[:status] || nil
			        	}
			    	} 
			body = body.merge(filter)
		end
		return body		
	end
		
end