require 'string'


class HTTPHandler
	@@request_pattern = /^GET (.*) HTTP\/1\.1$/
	@@header_pattern = /^([^:]+): (.*)$/

	#def intialize( <some server reference to add/remove clients or something> )
	#end

	def handle( socket )
		if socket.readline.chomp.match @@request_pattern
			headers = {}

			while socket.readline.chomp.match @@header_pattern
				headers[ $1 ] = $2
			end

			# do some processing
		else
			# throw an error or something
		end
	end
end

port = ARGV[0] && ARGV[0].to_i! || 8081

ServerSocket.new


read request type and path
read headers

if headers['Upgrade'] == 'WebSocket'
  # perform handshake

when there is activity on a socket
	if it is activity on the server socket
		handle the connection, which may involve upgrading the socket to a websocket
	else
		use the socket -> handler map to handle messages
	end
end

require 'socket'

def Server
	def initialize
		@sockets = {}
	end

	def run( port )
		# make server socket

		puts "listening on port #{port}"

		while true
			select( sockets.keys, nil, nil )[0].each do |socket|
				sockets[ socket ].handle socket
			end
		end
	end
end

if port = ARGV[0] && ARGV[0].to_i!
	Server.new.run( port )
else
	puts "usage: #{$0} [port-no]"
end
