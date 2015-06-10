package hxpress.http;

import hxpress.http.*;

import tannus.io.ByteArray;
import tannus.io.RegEx;
import tannus.ds.Object;
import tannus.ds.EitherType;
import tannus.sys.Path;

import hxpress.nhttp.Server in NServ;

using StringTools;
using Lambda;

@:forward
abstract Server (NServ) from NServ to NServ {
	/* Constructor Function */
	public inline function new(?s : NServ):Void {
		this = (s != null ? s : Http.createServer());
	}

/* === Instance Methods === */

	/**
	  * Listen for incoming requests
	  */
	public inline function any(cb : ServerCallback):Void {
		this.on('request', cb);
	}

	/**
	  * Listen for incoming requests, of a specified method
	  */
	public inline function byMethod(verb:String, cb:ServerCallback):Void {
		verb = verb.toUpperCase();
		any(function(x, y) {
			if (verb.split(' ').has(x.method.toUpperCase()))
				cb(x, y);
		});
	}

	/**
	  * Listen for requests to a given path
	  */
	public inline function byPath(pn:Path, cb:ServerCallback):Void {
		any(function(req, res) {
			if (req.url.pathname == pn) {
				cb(req, res);
			}
		});
	}

/* === Instance Fields === */

}

private typedef ServerCallback = IncomingMessage->ServerResponse->Void;
