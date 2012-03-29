class Server
	def initialize
		@sockets = {}
	end

	def run( port )
		require 'socket'

		socket = TCPServer.new( port )
                socket.listen( 5 )

		require 'accept_handler.rb'

		@sockets[ socket ] = AcceptHandler.new( self )

		puts "listening on port #{port}"

		while true
			select( @sockets.keys, nil, nil )[0].each do |socket|
				@sockets[ socket ].handle socket
			end
		end
	end
end
