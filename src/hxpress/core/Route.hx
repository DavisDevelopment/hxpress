package hxpress.core;

import hxpress.Request;
import hxpress.Response;

import tannus.io.Signal2;
import tannus.sys.GlobStar;

class Route {
	/* Constructor Function */
	public function new(pc : GlobStar):Void {
		glob = pc;
		signal = new Signal2();
	}

/* === Instance Fields === */

	public var glob : GlobStar;
	public var signal : Signal2<Request, Response>;
}
