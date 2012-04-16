require 'rubygems'
require 'json'

class Client
	def initialize( socket, context )
		@socket = socket
		@context = context
	end

	def send( msg )
		@socket.ws_send( msg.to_json )
	end

	def receive
		@socket.ws_receive
	end

	def handle( socket )

	end
end

=begin

the server has a set of open sockets. it is notified when there is activity 
on a particular socket.

if it is the accepting socket, it should be accepted and categorized in some 
way. we will categorize all sockets as http sockets first, since they will 
originate in that way.

once designated as http, we have a few scenarios we must handle:
if it is a simple http request, we must serve up that resource.
if it is a websocket upgrade request, we must perform the upgrade and send 
the socket to some pool of websocket connections. these are in the layer 
above the other sockets. how do we push them up to that layer?

it is this context that keeps track of them for now...

treat this layer as independent from the layer below. we need to know how to 
handle activity on the socket, closed sockets, and--in the future--reconnections.

class AbstractSocketPoolThing
	def initialize
		@clients = {}
	end

	def add( socket )
		@clients[ socket ] = Client.new( socket )
	end

	def handle( socket )
		

		@clients[ socket ].

		@clients[ socket ].send( some message )JSON.parse( socket.ws_receive )
	end
end


sender has game specific attributes
sender.cards, etc.

sender responds to msg_* messages



class HYN
	def initialize
		@states = [ State( :normal, { :turn => 0 } ]
	end

	def state
		@states.last.type
	end

	def next_turn
		if @draw_pile.size == 0
			# set state to "end phase"
			# still keep track of turns
			# notify clients so 'discard' can be changed to 'pass'
		end
	end

	def msg_meld( sender, )
	end

	def msg_discard( sender, cid )
		if state == :normal
			if turn == sender
				discard = sender.cards[ cid ]
				card = @draw_pile.remove

				@discard_pile.add( discard )
				sender.cards[ cid ] = card

				@players.each do |player|
					if player == sender
						player.msg_discard( sender, discard, card )
					else
						player.msg_discard( sender, discard )
					end
				end

				next_turn
			else
				warn_turn( sender )
			end
		else
			warn_state( sender )
		end
	end
				
	end

	def msg_chat( sender, message )
		@players.each do |player|
			player.msg_chat( sender, message )
		end
	end

=end
