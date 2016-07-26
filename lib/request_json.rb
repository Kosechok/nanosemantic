module Nanosemantic::RequestJson
=begin
	def json_chats_list(opt)
#			puts "-----------------"
#	    	puts @uuid
#	    	puts "================="
	    JSONBuilder::Compiler.generate do
#	    	puts "-----------------"
#	    	puts @uuid
#	    	puts "================="
	    	request do
#				clientId @clientid
#				uuid     @uuid
				clientId 	opt[:clientid]
				uuid		opt[:uuid]
				period do
			    	from 	opt[:begin] || (Date.today - 86400).to_time.to_i   
					to 		opt[:end] || Date.today.to_time.to_i
				end
				if %w(ip userid status).map(&:to_sym).any? { |key| opt.key?(key)  }
			    	filters do
			    		ip 		opt[:ip] || nil
						userid  opt[:userid] || nil
						status	opt[:status] || nil
					end
				end
				ts DateTime.now.to_i
			end
		end
	end
=end
	def json_chats_list(opt)
		body = {
		    request: {
		    	clientId: @clientid,
		    	uuid:     @uuid,
		    	period: {
		        	from: Date.today.to_time.to_i - 86400,
		        	to: Date.today.to_time.to_i
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
		
end