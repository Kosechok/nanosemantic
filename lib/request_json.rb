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
			        		ip: nil,
			        		userId: nil,
			        		status: nil
			        	}
			    	} 
			body = body.merge(filter)
		end

		body.to_json 
		
	end
		
end