class HTTPResponse
	def initialize( code, message )
		@code, @message = code, message
		@headers = {}
	end

	def set_header( key, value )
		@headers[ key ] = value
	end

	def unset_header( key )
		@headers.delete( key )
	end

	def set_body( body, type = 'text/html' )
		set_header( 'Content-Length', body.length )
		set_header( 'Content-Type', type )
		@body = body
	end

	def unset_body
		unset_header( 'Content-Length' )
		unset_header( 'Content-Type' )
		@body = nil	
	end

	def write( socket )
		socket.write "HTTP/1.1 #{@code} #{@message}\r\n"

		@headers.each do |key,value|
			socket.write "#{key}: #{value}\r\n"
		end

		socket.write "\r\n"

		if @body
			socket.write @body
		end
	end
end
