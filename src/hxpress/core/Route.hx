package hxpress.core;

import hxpress.Request;
import hxpress.Response;
import hxpress.core.PathDescriptor;

import tannus.io.Signal2;

class Route {
	/* Constructor Function */
	public function new(str:String):Void {
		glob = new PathDescriptor(str);
		signal = new Signal2();
	}

/* === Instance Fields === */

	public var glob : PathDescriptor;
	public var signal : Signal2<Request, Response>;
}
