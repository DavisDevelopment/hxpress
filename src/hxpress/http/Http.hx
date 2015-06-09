package hxpress.http;

import hxpress.http.*;
import haxe.Constraints.Function;

@:jsRequire('http')
extern class Http {
	/* Create a new Server */
	static function createServer(?onreq : Function):Server;
}
