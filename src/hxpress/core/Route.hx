package hxpress.core;

import hxpress.Request;
import hxpress.Response;
import hxpress.core.PathCheck;

import tannus.io.Signal2;

class Route {
	/* Constructor Function */
	public function new(pc : PathCheck):Void {
		glob = pc;
		signal = new Signal2();
	}

/* === Instance Fields === */

	public var glob : PathCheck;
	public var signal : Signal2<Request, Response>;
}
