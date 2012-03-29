require 'http_handler.rb'

class AcceptHandler
	def initialize( server )
		@http_handler = HTTPHandler.new( server )
	end

	def handle( socket )
		@http_handler.handle( socket.accept )
	end
end
