require 'lobby.rb'

class WebSocketHandler
	def initialize( server )
		@server = server
		
		@lobby = Lobby.new( server )
	end
	
	def add( socket )
		@server.setHandler( socket, Client.new( socket, @lobby ) )
	end
end
