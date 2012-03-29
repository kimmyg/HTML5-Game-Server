require 'socket'

require 'accept_handler.rb'

class Server
	def initialize
		@sockets = {}
	end

	def add( socket )
		@sockets[ socket ] = 10
	end

	def run( port )
		socket = TCPServer.new( port )
                socket.listen( 5 )

		@sockets[ socket ] = AcceptHandler.new( self )

		puts "listening on port #{port}"

		while true
			select( @sockets.keys, nil, nil )[0].each do |socket|
				@sockets[ socket ].handle socket
			end
		end
	end
end
