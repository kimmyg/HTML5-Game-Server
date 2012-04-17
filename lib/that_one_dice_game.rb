class Context
	def initialize( type )
		@type = type
		@data = {}
	end

	attr_reader :type, :data
end

class TODG
	def initialize( n )
		@n = n
		@contexts = []		

		context = Context.new( :opener )
		context.data[ :turn ] = 0

		@contexts << context
	end

	# at this point, assume it has started

	def context_type
		@contexts.last.type
	end

	# the following are game specific

	def turn
		@contexts.last.data[ :turn ]
	end

	def declare( player, n, v )
		if context_type == :opener
			if turn == player
				if 0 < n and n < 7
										




