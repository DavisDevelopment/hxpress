package hxpress.nhttp;

import tannus.node.*;

import haxe.Constraints.Function;
import haxe.extern.EitherType;
import haxe.extern.Rest;

import tannus.ds.Object;
import tannus.node.Buffer;

@:jsRequire('http', 'ServerResponse')
extern class ServerResponse extends WritableStream {
/* === Instance Methods === */

	function writeContinue():Void;

	@:overload(function(code:Int, ?headers:Object):Void{})
	function writeHead(statusCode:Int, ?statusMessage:String, ?headers:Object):Void;

	function setTimeout(ms:Int, cb:Function):Void;

	function setHeader(key:String, value:EitherType<String, Array<String>>):Void;
	function getHeader(key : String):Null<String>;
	function removeHeader(key : String):Void;

    /*
	@:overload(function(chunk:Data, ?callback:Function):Void{})
	function write(chunk:Data, ?encoding:String, ?callback:Function):Void;
	*/

	function addTrailers(trailers : Object):Void;

    /*
	@:overload(function(?enc:String, ?cb:Function):Void{})
	@:overload(function(?cb : Function):Void{})
	function end(?data:Data, ?encoding:String, ?callback:Function):Void;
	*/

/* === Instance Fields === */

	var statusCode : Int;
	var statusMessage : String;
	var headersSent : Bool;
	var sendDate : Bool;
}

private typedef Data = EitherType<String, Buffer>;
