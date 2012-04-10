

class WebSocketHandler
	def initialize( server )
		@server = server
		
		@lobby = Lobby.new( server )
	end
	
	def add( socket )
		@lobby.add( socket )
		
		@server.setHandler( socket, self )
			
	end
	
	def handle( socket )
		puts "websocket handle #{socket}"
	
		puts socket.ws_receive
	end
end