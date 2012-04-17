class Cycle
	def initialize( xs )
		@xs = xs
		@current = 0
	end

	def period
		@xs.length
	end

	def current
		@xs[ @current % @xs.length ]
	end

	def next
		@current = @current + 1
	end
end

	

class C
	def initialize
		@players = []
	end

	def start
