package hxpress.nhttp;

import haxe.Constraints.Function;
import haxe.extern.EitherType;
import haxe.extern.Rest;

import tannus.ds.Object;
import tannus.sys.Path;
import tannus.node.ReadableStream;
import hxpress.nhttp.EventEmitter;

@:jsRequire('http', 'IncomingMessage')
extern class IncomingMessage extends ReadableStream {
/* === Instance Fields === */
	var httpVersion : String;
	
	var headers : Object;
	var rawHeaders : Array<String>;
	var trailers : Object;
	var rawTrailers : Array<String>;

	var method : Null<String>;
	var url : Null<Path>;

/* === Instance Methods === */

	function setTimeout(ms:Int, cb:Function):Void;
}
