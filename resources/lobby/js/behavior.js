function ChatBoard() {}

ChatArea.prototype.addErrorMessage = function( msg ) {

};

ChatArea.prototype.addStatusMessage = function( msg ) {

};

ChatArea.prototype.addPlayerMessage = function( pid, msg ) {

};

function ChatBox() {}

ChatBox.prototype.send = function() {}

function Interface( ws ) {
	var div = document.createElement( 'div' );

	div.ap

function Translator( ws ) {
	this.ws = ws;

	var self = this;

	ws.onmessage = function( event ) {
		self.adapter.onmessage( event );
	};

	ws.onerror = function( event ) {
		self.adapter.onerror( event );
	};

	ws.onclose = function( event ) {
		self.adapter.onclose( event );
	};
}

Translator.prototype.send = function( msg ) {
	this.ws.send( msg );
}



principled design of resumable server

a context entails the code package running on a client. if a context changes, 
the code package will change. the term context is slightly unfortunate (or 
perhaps not) as it evokes the sense of an evaluation context and suggests the 
use of a stack. it may be that this characterization is workable, but we first 
must establish some of the cases we want to handle.

a context itself is resumable or not. the default context, the lobby, is 
resumable for obvious reasons. there are a few differences between it and 
a more defined context: there is no definite beginning or end; it is not 
necessary to pass the entire history of the lobby to a reconnection. because 
of these differences, we should distinguish between the lobby and other 
contexts.

let us define a game context to be one in which: there is a definite 
beginning and end; ...

we can explore the taxonomy of games.

is the game "real time" or turn-based? this says nothing about the pace of 
the game. only whether we are dealing with a soup (or concurrency?) or a 
semamphore-type pattern.

at present, we will devote all our attention to turn-based games. we can sub-
divide this class with this distinction: can the game continue with the 
sudden loss of a player? if not, we need not worry about resumption at all! 
the game ends. upon reconnection, the player is attached to the most recent 
inner context that supports resumption. (that may be incorrect.) the answer 
to the question may be "perhaps". the only distinction that holds for all 
games in this class is between a player whose turn it is and another player. 
these games may recognize other relationships. the true question is whether 
the game can continue with the removal of a given player. for some games, this 
is an unequivocal "no", and it is simple. for others, the answer is more 
involved and, perhaps, subtle.

consider a game which is resumable and in which a player leaves. the other 
players should be immediately notified. if the game can continue without the 
player (at all), remaining players may be presented with an option to drop 
them from the game. [if a player is kicked, upon reconnecting, the player 
should be notified they were kicked from the game.]

let's do this for bomgolf.

we could do turns concurrently and synchronize at the end of rounds. we could 
do round-robin. we could do sequential.
