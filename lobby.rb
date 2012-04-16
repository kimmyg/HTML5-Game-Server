


class Lobby
	def initialize( server )
		@server = server
	end

	def add( socket )
		socket.ws_send( { 'type' => 'load', 'package' => 'lobby' }.to_json )	
	end
	
	def remove( socket )
	
	end
	
	def msg_chat( sender, message )
	
	end
	
	def msg_create( sender, type )
	
	end
end
