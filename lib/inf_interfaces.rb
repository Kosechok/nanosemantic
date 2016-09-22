module Nanosemantic

	def api_uri
		{
			:chats_list		=> { :url => 'ChatLog.chat'},
			:ips_list 		=> { :url => 'ChatLog.ip'},
			:users_list		=> { :url => 'ChatLog.user'},
			:chat_messages	=> { :url => 'ChatLog.message'}
		}
	end

	protected
	
	def prepare_ulr
		@api = api_uri.inject({}) do |m,(k,v)|
			url = v[:url]
			url = default_url + url
			m.merge!(k => URI.parse(url))
		end
	end
end