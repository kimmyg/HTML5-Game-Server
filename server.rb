require 'socket'

def Server
	def initialize
		@sockets = {}
	end

	def run( port )
		socket = TCPServer.new( port )
                socket.listen( 5 )

		puts "listening on port #{port}"

		while true
			select( sockets.keys, nil, nil )[0].each do |socket|
				sockets[ socket ].handle socket
			end
		end
	end
end
