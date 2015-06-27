package hxpress.core;

import hxpress.Request;
import hxpress.Response;
import hxpress.core.PathDescriptor;
import hxpress.core.Route;

import tannus.io.Signal2;
import tannus.sys.Path;

import haxe.ds.ArraySort.sort;

using StringTools;
using Lambda;

class Router {
	/* Constructor Function */
	public function new():Void {
		routes = new Array();
	}

/* === Instance Methods === */

	/**
	  * Handle an inbound Request
	  */
	@:allow(hxpress.Server)
	private function inbound(req:Request, res:Response):Void {
		var path:String = req.url.pathname;

		for (r in routes) {
			if (r.glob.test(path)) {
				r.signal.call(req, res);
			}
		}
	}

	/**
	  * Create a new Route
	  */
	public function addRoute(desc:String, cb:Request->Response->Void):Void {
		var sig:NetSignal = getSignal( desc );
		sig.on( cb );
	}

	/**
	  * Get the NetSignal associated with a given path-descriptor
	  */
	private function getSignal(desc : String):NetSignal {
		for (r in routes)
			if (r.glob.str == desc)
				return r.signal;
		var rout = new Route( desc );
		routes.push( rout );
		return rout.signal;
	}

/* === Instance Fields === */

	/* The registry of paths->handlers */
	private var routes : Array<Route>;
}

private typedef NetSignal = Signal2<Request, Response>;
