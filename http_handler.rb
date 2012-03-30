require 'websocket.rb'

require 'http_request.rb'
require 'http_response.rb'

class HTTPHandler
	@@types = {
		'html' => 'text/html',
		'js' => 'application/json'
	}


	def self.typeForPath( path )
		if path.match /\.([^\.]*)$/
			extension = $1

			@@types[ extension ] 	# this is a bad return value
						# because we won't know if the path was malformed
						# or if we didn't have a mime type for the path
		end
	end

	def initialize( server )
		@server = server
	end

	def handle( socket )
		request = HTTPRequest.read( socket )
	
		if request.method == :GET
			puts "this may be an upgrade request"
		
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
			
			socket.close # TAKE THIS OUT!!!!
		end
	end
end
