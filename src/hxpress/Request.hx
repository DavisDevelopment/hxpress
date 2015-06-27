package hxpress;

import hxpress.http.IncomingMessage in Req;

import tannus.io.ByteArray;
import tannus.io.RegEx;
import tannus.io.Ptr;
import tannus.io.Signal;
import tannus.ds.Dict;
import tannus.ds.Object;
import tannus.ds.Maybe;

import tannus.node.Url;
import tannus.node.QueryString in Qs;

using StringTools;
using Lambda;
using tannus.ds.ArrayTools;

@:allow(hxpress.core.RequestManager)
class Request {
	/* Constructor Function */
	public function new(r : Req):Void {
		req = r;
		ready = new Signal();

		__init();
	}

/* === Instance Methods === */

	/**
	  * Initialize [this] Request
	  */
	private function __init():Void {
		method = req.method.toUpperCase();
		url = req.url;
		headers = req.headerDict;
		params = {};

		params.write( url.query );
	}

	/**
	  * Loads data relevant to [this] request asynchronously
	  */
	private function load():Void {
		if (method == 'POST') {
			req.data(function(pb : ByteArray) {
				var pdata:Object = Qs.parse( pb );

				params.write( pdata );
				ready.call( this );
			});
		}
		else {
			
			ready.call( this );
		}
	}

/* === Computed Instance Fields === */

	/**
	  * The User-Agent String
	  */
	public var userAgent(get, never):Null<String>;
	private inline function get_userAgent() {
		return (headers['user-agent']);
	}

	/**
	  * Array of MIMEs that the client will accept
	  */
	public var accepts(get, never):Array<String>;
	private function get_accepts() {
		return ((headers['accept']+'').substring(0, (headers['accept']+'').indexOf(';')).split(','));
	}

	/**
	  * Cookies
	  */
	public var cookies(get, never):Object;
	private function get_cookies() {
		var cook:Maybe<Object> = (req.headers['cookie'].runIf(hxpress.Cookie.parse));
		return (cook || {});
	}

/* === Instance Fields === */

	//- Underlying Req instance
	private var req : Req;

	//- The 'method' of [this] Request
	public var method : String;

	//- The URL Being Requested
	public var url : UrlData;

	//- HTTP Headers attached to [this] request
	public var headers : Dict<String, String>;

	//- GET, POST, and url parameters pooled into one Object
	public var params : Object;

	//- Signal fired when all desired data has been obtained for [this] Request
	public var ready : Signal<Request>;
}
