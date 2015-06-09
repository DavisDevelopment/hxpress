package hxpress.nhttp;

import hxpress.nhttp.*;
import haxe.Constraints.Function;

@:jsRequire('http')
extern class Http {
	/* Create a new Server */
	static function createServer(?onreq : Function):Server;
}
