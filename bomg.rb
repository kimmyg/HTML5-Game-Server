require 'set'

class TerminalAdapter # also turns event-driven into sequential!
	def initialize( p )
		@p = p
	end

	def a
	end
end


class BOMG
	def initialize( n, k ) # number of rounds, players
		@n = n

		@scores = {}

		(1..k).each do |i|
			@rounds[i] = []
		end

		@passages = Set.new
	end

	def state
		# certainly the round scores
		# the passages seen already
		# perhaps a correspondence between the two (which must be made in this object)
		# the in round information: order of remaining players and tallies, map from players to round state (guessed books, guessed chapters)
	end

	def state=( state )
		# replace current instance with serialized
		# deduce inner state (:scoreboard, :round, etc) from state
		# for instance, if round information is absent, we were
		# at the scoreboard. show the scoreboard before the next 
		# round. if it is present, we are in a round.
	end

	def guess_book( sender, bid )
		if _state == :round
			if _turn == sender
				if _state_data[sender][:books].include? @book
					# already guessed book
				else
					_state_data[sender][:books].add bid
					_state_data[sender][:tally] = _state_data[sender][:tally] + 1

					if bid == @book
						# send correct
					else
						# send incorrect
					end

					_next_turn
				end
			end
		end
	end

	def guess_chapter( sender, cid )
		if _state == :round
			if _turn == sender
				if _state_data[sender][:books].include? @book
					_state_data[sender][:chapters].add cid
					_state_data[sender][:tally] = _state_data[sender][:tally] + 1

					if cid == @chapter
						# remove from round robin
						# notify correct
						# go to the next turn respecting removal
					else
						# notify incorrect
						# go to next turn
					end
				else
					# can't guess chapter until book
				end
			else
				# not turn
			end
		else
			# not round
		end
	end

	def go_for_the_gold( sender, bid, cid )
		if _state == :round
			if _turn == sender
				if _state_data[sender][:books].include? @book
					# can only go for gold if book not guessed yet
				else
					_state_data[sender][:tally] = _state_data[sender][:tally] + 1

					if bid == @book and cid == @chapter
						# remove from round
						# notify correct (gftg!)
						# next turn respecting removal
					else
						# notify incorrect
						# next turn
					end
				end
			else
				# not turn
			end
		else
			# not round
		end
	end

	def _next_turn
		if round robin is empty
			end round
		else
			go to next turn
		end
	end

	def continue( sender ) # this is not in the "essence" of the game
		if _state == :scorecard
			_state_data[:pool].delete sender

			if _state_data[:pool] is empty
				_next_round
			end
		end
	end
end
