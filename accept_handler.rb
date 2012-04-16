require 'http_handler.rb'

class AcceptHandler
	def initialize( server )
		@server = server
		@http_handler = HTTPHandler.new( server )
	end

	def handle( socket )
		@server.setHandler( socket.accept, @http_handler )
	end
end
