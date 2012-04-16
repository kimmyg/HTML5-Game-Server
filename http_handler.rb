require 'websocket.rb'

require 'http_request.rb'
require 'http_response.rb'
require 'websocket_handler.rb'

class HTTPHandler
	@@types = {
		'css' => 'text/css',
		'html' => 'text/html',
		'js' => 'application/javascript'
	}


	def self.typeForPath( path )
		@@types[ path.split('.').last ] # this is a bad return value
						# because we won't know if the path was malformed
						# or if we didn't have a mime type for the path
	end

	def initialize( server )
		@server = server
		
		@websocket_handler = WebSocketHandler.new( server )
	end

	def handle( socket )
		puts "http handle #{socket}"
	
		request = HTTPRequest.read( socket )
	
		case request.method
		when :GET then handleGet( socket, request )
		else raise "unknown request method #{request.method}"
		end
	end
	
	def handleGet( socket, request )
		if request.header( 'Upgrade' ) == 'WebSocket'
			socket.ws_handshake( request.path, request.headers )
		
			@websocket_handler.add( socket )
		else
			path = request.path
		
			if path == '/'
				path = '/index.html'
			end
			
			path = 'resources' + path
			
			response = nil
			
			if File.exist? path and not ( File.directory? path )
				response = HTTPResponse.new( 200, 'OK' )
				response.set_body( File.read( path ), HTTPHandler.typeForPath( path ) )
			else
				response = HTTPResponse.new( 404, 'Not Found' )
			end
			
			response.write( socket )
			
			if request.header( 'Connection' ) == 'close'
				@server.removeHandler( socket )
				socket.close
			end
		end
	end
end
