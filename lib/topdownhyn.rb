=begin
0 - discard pile
1 - agent 1 pile
...

0:0 is top of discard pile
1:0 is first card of agent 1
1:1 is second card
etc.

but since we only deal with specifying piles or cards
0 is card on discard pile
1 is our first card
2 ...

0 is discard pile
1 is agent 1 pile
2 ...

def meld( sender, c1, c2 )
	if sender == current agent
		resolve c1
		resolve c2

		if c1 and c2?

		if wild c1 and wild c2
			# report that it is illegal
		elsif wild c1
			add pile of value c2, declare cards to all, end turn
		elsif wild c2
			add pile of value c1, declare cards to all, end turn
		else
			add pile of value c1, declare cards to all, end turn
		end
	else
		# report must wait until turn
	end
end

discard( sender, cid )
	if check_state for normal
		if is senders turn
			???
		end
	end
end



challenge( sender, cid, pid )
	if check_state for normal
		if is senders turn <= on false, sends error
			if pid points to actual pile
				if player has piles
					if cid value matches pile value
						send challenge
						@state = challenge
						@state_date = { challenger = player, defender = pid }
					end
				else
					send error to player
				end
			else
				error
			end
		end
	end
end

current_agent
	agent_index + 1
end





=end







require 'card.rb'

class S
	def initialize( s, d )
		@state, @data = s, d
	end

	attr_accessor :state, :data
end

class P
	def initialize( c1, c2 )
		@cards = [c1, c2]
	end
	
	def value
		@cards.inject( 0 ) do |total,card|
			total + (if card.suit == 'J'
				50
			else
				if card.value == 'A' or card.value == 2
					20
				elsif card.value == 10 or card.value == 'J' or card.value == 'Q' or card.value == 'K'
					10
				else
					5
				end
			end)
		end
	end
	
	def height
		@cards.length
	end
	
	def add( cards )
		@cards = @cards + cards
	end
end
	
class G
	def initialize( n, k )
		@n = n
	
		@draw_pile = []

		n.times do
			@draw_pile = @draw_pile + Card.deck
		end

		@draw_pile = @draw_pile.shuffle

		@discard_pile = []

		@hands = {}

		(1..n).each do |i|
			@hands[i] = []
		end
		
		@piles = {}
		
		(1..n).each do |i|
			@piles[i] = []
		end

		@states = []

		# new is started

		k.times do
			(1..n).each do |i|
				@hands[i] << @draw_pile.pop
				send( i, @hands[i].last )
			end
		end

		@states << S.new( :normal, { :turn => 0 } )
		broadcast( "turn #{turn}" )
	end
	
	def inspect
		"g"
	end
	
	def broadcast( message )
		puts message
	end

	def send( aid, message )
		puts "#{aid}: #{message}"
	end

	def state
		@states.last && @states.last.state
	end

	def turn
		@states.last.data[:turn] && @states.last.data[:turn] + 1
	end

	def next_turn
		@states.last.data[:turn] = ( ( @states.last.data[:turn] + 1 ) % @n )
		broadcast( "turn #{turn}" )
	end

	def discard( aid, cid )
		if state == :normal # there is at least one card in the draw pile
			if turn == aid
				@discard_pile.push( @hands[ aid ].slice!( cid - 1 ) )
				broadcast( "discard #{@discard_pile.last}" )			
			
				@hands[ aid ] << @draw_pile.pop
				send( aid, @hands[ aid ].last )

				if @draw_pile.length == 0
					# @states.last.state = :tail
					# do the above after this turn and before the next, but still broadcast below so pile will look empty
					broadcast( "draw pile is empty" )
				end

				next_turn
			else
				send( aid, 'it\'s not your turn' )
			end
		else
			send( aid, 'cannot discard in this phase of the game' )
		end
	end
	
	def resolve_card( cid )
		if cid == 0
			@
	
	def meld( aid, cid1, cid2 )
		if state == :normal
			if turn == aid
				if cid1 == cid2
					send( aid, 'pick two different cards to use' )
				else
					if cid1 == 0 or cid2 == 0
						if @discard_pile.length > 0
							# this could work	
						else
							send( aid, 'cannot draw from empty discard pile' )
						end
				end
			else
				send( aid, 'it\'s not your turn' )
			end
		else
			send( aid, 'cannot discard in this phase of the game' )
		end
	end

	def challenge( aid, cid, pid )
		if state == :normal
			if turn == aid
				begin
					card = resolve( cid )

					if card has same value as pile pid
						@states << S.new( :challenge, { :challenger => aid, :defender => pid, :pile => [card] } )
						broadcast( "#{aid} challenges #{pid} with #{card}" )
					else
						send( aid, 'cards need same value' )
					end

				rescue DiscardPileEmptyError
					send( aid, 'the discard pile is empty' )
				end	
			else
				send( aid, 'it\'s not your turn' )
			end
		else
			send( aid, 'cannot challenge at this time' )
		end
	end

	def counter( aid, cid )
		if state == :challenge
			if @states.top.data[:pile].length % 2 == 0
				if aid == @states.top.data[:challenger]
				
				elsif aid == @states.top.data[:defender]
					send( aid, "you must wait for challenger" )
				else
					send( aid, 'it\'s not your turn' )
				end
			else
				if aid == @states.top.data[:defender]

				elsif aid == @states.top.data[:challenger]
					send( aid, 'you must wait for them to retaliate' )
				
			end
	end

	def forfeit( aid )
		if state == :challenge
			if @states.last.data[:pile].length % 2 == 0
				if aid == @states.last.data[:challenger]
					pile = @piles[ aid ].last
					pile.add( @states.last.data[:pile]

					#broadcast new height, winner
					@states.pop
					next_turn
				elsif aid == @states.last.data[:defender]
					# inform defender no need
				else
					# inform not turn
				end
			else
				if aid == @states.last.data[:defender]
					pile = @piles[ aid ].pop
					pile.add( @states.last.data[:pile] )
				
					# broadcast new top piles, heights, etc.
					@states.pop
					next_turn
				elsif aid == @states.last.data[:challenger]
					# inform challenger no need
				else
					#inform not turn
				end
			end
	end
end


class G-Host
	def initialize( n )
		@word = []

		@states = []
		@states << S.new( :normal, { :turn => 0, :last_turn => nil } )
	end

	def add( aid, letter )
		if state == :normal
			if turn == aid
				@word << letter
				broadcast( letter )
				next_turn
			else
				# inform not turn
			end
		else
			# inform not state
		end
	end

	def declare( aid )
		if state == :normal
			if turn == aid
				if @word.length < 3
					send( aid, 'not at least three letters' )
				else
					# do something
				end
			else
				# not turn
			end
		else
			# not state
		end
	end

	def challenge( aid )
		
	end

	# and voting methods
end
