package hxpress.nhttp;

import hxpress.http.*;
import haxe.Constraints.Function;
import haxe.extern.EitherType;

import tannus.ds.Object;

@:jsRequire('http')
extern class Http {
	/* Create a new Server */
	static function createServer(?onreq : Function):Server;

	/* Create a new Request */
	static function request(opts:EitherType<String, Object>, ?callback:IncomingMessage->Void):ClientRequest;
}
