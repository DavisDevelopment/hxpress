package hxpress.http;

import hxpress.nhttp.ClientRequest in NReq;
import hxpress.http.*;

@:forward
abstract ClientRequest (NReq) from NReq to NReq {
	/* Constructor Function */
	public inline function new(nr : NReq):Void {
		this = nr;
	}

/* === Instance Methods === */

	/**
	  * Listen for a response to [this] Request
	  */
	public inline function onResponse(cb : IncomingMessage->Void):Void {
		this.on('response', cb);
	}
}
