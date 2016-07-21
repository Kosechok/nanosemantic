module Nanosemantic::RequestJson

	def json_chats_list(opt)
	    JSONBuilder::Compiler.generate do
	    	request do
				clientId @clientid
				uuid     @uuid
				period do
			    	from 	opt[:begin] || (Date.today - 1.day).to_time.to_i
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
		
end