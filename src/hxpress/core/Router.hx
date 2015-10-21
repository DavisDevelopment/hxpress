package hxpress.core;

import hxpress.Request;
import hxpress.Response;
import hxpress.core.Route;

import tannus.io.Signal2;
import tannus.ds.Object;
import tannus.sys.Path;
import tannus.sys.GlobStar;

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

		var handled:Bool = false;
		for (r in routes) {
			var match:Null<Object> = r.glob.match(path);
			if (r.glob.test(path)) {
				req.params += match;
				r.signal.call(req, res);
				handled = true;
			}
		}
		if (!handled) {
			res.status = 404;
			res.send();
		}
	}

	/**
	  * Create a new Route
	  */
	public function addRoute(desc:GlobStar, cb:Request->Response->Void):Void {
		var rout:Route = new Route( desc );
		rout.signal.on( cb );
		routes.push( rout );
	}

	/**
	  * Get the NetSignal associated with a given path-descriptor
	  */
	/*
	private function getSignal(desc : String):NetSignal {
		for (r in routes)
			if (r.glob.str == desc)
				return r.signal;
		var rout = new Route( desc );
		routes.push( rout );
		return rout.signal;
	}
	*/

/* === Instance Fields === */

	/* The registry of paths->handlers */
	private var routes : Array<Route>;
}

private typedef NetSignal = Signal2<Request, Response>;
