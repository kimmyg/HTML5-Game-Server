

class Lobby
	def initialize( server )
		@server = server
		@sockets = {}
	end
	
	def add( socket )
		@server.setHandler( socket, self )
		
		@sockets.keys.each do |s|
			# notify socket
		end
		
		# notify socket of everyone else
		
		# add socket
	end
	
	def msg_chat( sender, content )
	
	end
	
	def msg_
	
	def handle( socket )
		
	end
end

module HYN
	class Gathering
		# options set here, d



	class G
		def initialize
			p = []
			
		end
		
		