function Button() {
	var element = document.createElement( 'div' );

	element.addClass( 'button' );

	return element;
}

function DiscardButton() {
	var element = Button();

	element.innerText = 'discard';
	element.id = 'discard';

	return element;
}

function ControlPanel() {
	var element = document.createElement( 'div' );

	element.appendChild( DiscardButton() );
	element.appendChild( Button( 'Meld' ) );
	element.appendChild( Button( 'Challenge' ) );

	return element;
}

function Interface() {
	var element = document.createElement( 'div' );

	element.appendChild( ControlPanel() );

	return element;
}

{"players":["Kimball","Bethany"],"package":"hyn"}



function Stack() {} // div stack element

/*

we can't have a fixed layout since there may be an arbitrary number of players



*/

function handle( message ) {
	if( message.type === 'control' ) {
	
	}
	
	message.
}

/*
chat/message area
hand
control area
our stack
a stack for every player
the discard pile
the draw pile



+-+   +-+
| |   +-+
+-+   +-+
+-+   +-+
| |   +-+
+-+

