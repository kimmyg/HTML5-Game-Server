require 'lobby.rb'

class WebSocketHandler
	def initialize( server )
		@server = server
		
		@lobby = Lobby.new( server )
	end
	
	def add( socket )
		@lobby.add( socket )	
	end
end
