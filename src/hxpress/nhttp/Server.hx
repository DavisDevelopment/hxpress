package hxpress.nhttp;

import hxpress.nhttp.EventEmitter;

import tannus.ds.Object;
import haxe.Constraints.Function;
import haxe.extern.EitherType;
import haxe.extern.Rest;

@:jsRequire('http', 'Server')
extern class Server extends EventEmitter {
/* === Instance Methods === */

	@:overload(function(p:Int, ?bl:Int, ?cb:Function):Void{})
	@:overload(function(p:Int, ?cb:Function):Void{})
	@:overload(function(p:String, ?cb:Function):Void{})
	@:overload(function(p:Dynamic, ?cb:Function):Void{})
	function listen(port:Int, ?hostname:String, ?backlog:Int, ?callback:Function):Void;

	function close(?callback:Function):Void;

	function setTimeout(ms:Int, cb:Function):Void;

/* === Instance Fields === */

	var maxHeadersCount : Int;
	var timeout : Int;
}
