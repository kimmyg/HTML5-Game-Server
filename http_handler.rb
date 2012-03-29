require 'websocket.rb'

class HTTPHandler
        @@request_pattern = /^GET (.*) HTTP\/1\.1$/
        @@header_pattern = /^([^:]+): (.*)$/

        def initialize( server )
                @server = server
        end

        def handle( socket )
		request = socket.readline.chomp

                if request.match @@request_pattern
			path = $1

                        headers = {}

                        while socket.readline.chomp.match @@header_pattern
                                headers[ $1 ] = $2
                        end

                        if headers['Upgrade'] == 'WebSocket'
				socket.ws_handshake headers
				server.add socket
			else
				if path == '/'
					# main page
				else
					# explode
				end
			end
                else
                        puts "request didn't match: #{request}"
                end
        end
end
