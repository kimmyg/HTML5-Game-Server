module HTTPRequest
	@@request_pattern = @@request_pattern = /^(\w+)\s+(\S+)\s+HTTP\/\d\.\d$/
	@@header_pattern = /^([^:]+): (.*)$/

	class HTTPGETRequest
		def initialize( path, headers, socket )
			@path = path
			@headers = headers
		end

		def method
			:GET
		end

		def path
			@path
		end

		def header( key )
			@headers[ key ]
		end
	end

	def self.read( socket )
		request = socket.readline.chomp

		if request.match @@request_pattern
			method, path = $1, $2

			headers = {}

			while socket.readline.chomp.match @@header_pattern
				headers[ $1 ] = $2
			end

			case method
			when 'GET' then HTTPGETRequest.new( path, headers, socket )
			else raise 'unknown method ' + method
			end
		else
			raise "unknown request format \"#{request}\""
		end
	end
end
