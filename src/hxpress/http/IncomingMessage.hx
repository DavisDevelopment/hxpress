package hxpress.http;

import hxpress.nhttp.IncomingMessage in Msg;
import tannus.node.Buffer;

import tannus.ds.Object;
import tannus.ds.Maybe;
import tannus.ds.Dict;
import tannus.io.ByteArray;
import tannus.node.Url;

import Std.is;

@:forward
abstract IncomingMessage (Msg) from Msg to Msg {
	/* Constructor Function */
	public inline function new(m : Msg) {
		this = m;
	}

/* === Instance Fields === */

	/**
	  * The MIME Type of [this] response
	  */
	public var type(get, never):Null<String>;
	private inline function get_type():String {
		return ('' + this.headers['content-type']);
	}

	/**
	  * The URL being requested
	  */
	public var url(get, never):UrlData;
	private inline function get_url():UrlData {
		return Url.parse(this.url);
	}

	/**
	  * The GET parameters of [this] request
	  */
	public var params(get, never):Object;
	private inline function get_params():Object {
		return url.query;
	}

	/**
	  * The HTTP Headers of [this] request, as a Dict
	  */
	public var headerDict(get, never):Dict<String, String>;
	private function get_headerDict() {
		var d:Dict<String, String> = new Dict();
		var h:Object = this.headers;
		for (key in h.keys) {
			d[key] = h[key];
		}
		return d;
	}

/* === Instance Methods === */

	/**
	  * Get the data being sent on [this] Message
	  */
	public function data(cb : ByteArray->Void):Void {
		/* ByteArray to hold any/all data received */
		var buff:ByteArray = new ByteArray();

		/* when a chunk of  data is received */
		this.on('data', function(chunk : Buffer) {

			//- append that chunk to [buff]
			buff.write( chunk );
		});

		/* when the end of the data has been reached */
		this.on('end', function() {
			//- invoke [cb] with [buff] as it's argument
			cb( buff );
		});
	}
}
