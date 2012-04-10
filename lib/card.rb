class Card
	def initialize( suit, value )
		@suit, @value = suit, value
	end

	def to_s
		"#{@value} of #{@suit}"
	end

	def self.deck
		deck = []

		['D','S','C','H'].each do |suit|
			['A',2,3,4,5,6,7,8,9,10,'J','K','Q'].each do |value|
				deck << Card.new( suit, value )
			end
		end

		deck << Card.new( 'J', nil )
		deck << Card.new( 'J', nil )

		deck
	end
end

