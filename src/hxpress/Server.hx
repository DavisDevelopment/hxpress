package hxpress;

import hxpress.http.Server in NServ;
import hxpress.http.IncomingMessage in NReq;
import hxpress.http.ServerResponse in NRes;
import hxpress.core.PathCheck;
import hxpress.core.RequestManager;
import hxpress.core.Router;
import hxpress.Request;
import hxpress.Response;

import tannus.io.ByteArray;
import tannus.io.RegEx;
import tannus.io.Signal;
import tannus.io.Signal2;
import tannus.io.Ptr;
import tannus.ds.AsyncStack;
import tannus.ds.Dict;
import tannus.ds.Object;
import tannus.ds.Maybe;

class Server implements RequestManager {
	/* Constructor Function */
	public function new():Void {
		server = new NServ();
		router = new Router();
		_req = new Signal2();

		__init();
	}

/* === Instance Methods === */

	/**
	  * Initialize [this] Server
	  */
	private inline function __init():Void {
		server.any(function(req, res) {
			_handle(req, res);
		});
	}

	/**
	  * Perform any actions on the request/response pair
	  * that are needed, before they're handed off to the 
	  * rest of the API
	  */
	private function _handle(nreq:NReq, nres:NRes):Void {
		var req:Request = new Request( nreq );
		var res:Response = new Response( nres );

		req.ready.once(function(r) {
		
			router.inbound(req, res);
			// _req.call(req, res);
		});

		req.load();
	}

	/**
	  * Add a new Callback to the list
	  */
	public function route(path:PathCheck, cb:ServerCallback):Void {
		router.addRoute(path, cb);
	}

	/**
	  * Start listening on the specified port
	  */
	public function listen(port : Int):Void {
		server.listen( port );
	}

	/**
	  * Stop listening for new requests
	  */
	public function stop():Void {
		server.close();
	}

/* === Instance Fields === */

	/* Underlying HTTP Server */
	public var server : NServ;

	/* Router instance for [this] Server */
	private var router : Router;

	/* Array of callbacks to be fired upon receipt of a new Request */
	private var _req : Signal2<Request, Response>;
}

typedef ServerCallback = Request->Response->Void;
