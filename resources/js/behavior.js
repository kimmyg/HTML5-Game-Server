function $( id ) {
	return document.getElementById( id );
}

function load_css( name ) {
	var element = document.createElement( 'link' );

	element.rel = 'stylesheet';
	element.src = '/' + name + '/css/style.css';
	element.id = name + '_css';

	$('head').appendChild( element );
}

function unload_css( name ) {
	$('head').removeChild( $( name + '_css' ) );
}

function load_js( name ) {
	var element = document.createElement( 'script' );

	script.type = 'application/javascript';
	script.src = '/' + name + '/js/behavior.js';
	script.id = name + '_js';

	$('head').appendChild( element );
}
	
function unload_js( name ) {
	$('head').removeChild( $( name + '_js' ) );
}
