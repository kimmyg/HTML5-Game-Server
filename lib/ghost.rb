has a few states:
normal
challenge
declare

{"players":["Frank","Tim"],"state":"normal","letters":["A","N","A","C"],"turn":0}

{"players":["Frank","Tim","John"],"state":"challenge","letters":["A","N","A","C"],"challenger":0,"challengee":2}

{"players":["Frank","Tim","John"],"state":"declare","letters

class OneRoundGhost
	def initialize( n )
		@n = n
end

class Ghost
	def initialize( n )
		@players = (1..n)
	end

	def start_round
		state = :round
		data['order'] = @players.to_a.shuffle
		data['turn'] 
	end
