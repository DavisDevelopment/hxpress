package hxpress.http;

import hxpress.http.EventEmitter;

import tannus.ds.Object;
import haxe.Constraints.Function;
import haxe.extern.EitherType;
import haxe.extern.Rest;

@:jsRequire('http', 'Server')
extern class Server extends EventEmitter {
/* === Instance Methods === */

	@:overload(function(p:LHandle, ?bl:Int, ?cb:Function):Void{})
	@:overload(function(p:LHandle, ?cb:Function):Void{})
	function listen(port:LHandle, ?hostname:String, ?backlog:Int, ?callback:Function):Void;

	function close(?callback:Function):Void;

	function setTimeout(ms:Int, cb:Function):Void;

/* === Instance Fields === */

	var maxHeadersCount : Int;
	var timeout : Int;
}

private typedef LHandle = EitherType<Int, EitherType<String, Object>>;
