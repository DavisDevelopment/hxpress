package hxpress;

import hxpress.http.ServerResponse in Res;

import tannus.io.ByteArray;
import tannus.io.RegEx;
import tannus.io.Ptr;
import tannus.io.Getter;
import tannus.ds.Dict;
import tannus.ds.Object;
import tannus.ds.Maybe;
import tannus.ds.EitherType;

import hxpress.Cookie;

class Response {
	/* Constructor Functions */
	public function new(r : Res):Void {
		res = r;
		headers = {};
		cookies = new Array();
		res_bod = new ByteArray();
	}

/* === Instance Methods === */

	/**
	  * Send a REDIRECT
	  */
	public function redirect(path : String):Void {
		status = 302;
		headers['Location'] = path;
	}

	/**
	  * Write some data to [this] Response
	  */
	public function write(chunk : ByteArray):Void {
		if ( buffering ) {
		    res_bod.append( chunk );
		}
        else {
            res.write( chunk );
        }
	}

	/**
	  * Create new Cookie
	  */
	public function setCookie(name:String, value:Object, ?maxAge:Int):Void {
		var cooki = new Cookie(name, value);
		
		cooki.maxAge = maxAge;

		cookies.push( cooki );
	}

	/**
	  * Send [this] Response
	  */
	public function send():Void {
		if (buffering) {
			res.setHeader('Set-Cookie', [for (c in cookies) c.serialize()]);
			res.writeHead(status, headers);
			res.write( res_bod );
			res.end();
		}
		else {
			res.end();
		}
	}

	/**
	  * Send the Head of the document
	  */
	public function sendHead():Void {
		if (!res.headersSent) {
			res.setHeader('Set-Cookie', [for (c in cookies) c.serialize()]);

			res.writeHead(status, headers);
		}
	}

	/**
	  * End [this] Response
	  */
	public inline function end():Void {
	    res.end();
	}

	public inline function getRaw():Res {
	    return res;
	}

/* === Computed Instance Fields === */

	/**
	  * Whether we should send response-chunks immediately, or buffer them
	  */
	private var buffering(get, never):Bool;
	private function get_buffering() {
		return (!res.headersSent);
	}

	/**
	  * MIME Type of response body
	  */
	public var type(get, set):Null<String>;
	private function get_type() return (headers['Content-Type'].value);
	private function set_type(v) return (headers['Content-Type'] = v);

/* === Instance Fields === */
	
	//- Underlying ServerResponse instance
	private var res : Res;

	//- Buffered response body
	private var res_bod : ByteArray;

	//- Headers to be sent
	public var headers : Object;

	//- Cookies to be set
	public var cookies : Array<Cookie>;

	//- Status-Code
	public var status : Int;
}
