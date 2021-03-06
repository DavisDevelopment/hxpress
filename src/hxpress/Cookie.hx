package hxpress;

import tannus.ds.Maybe;
import tannus.ds.Object;

import haxe.Serializer;
import haxe.Unserializer;

using StringTools;

class Cookie {
	/* Constructor Function */
	public function new(nam:String, dat:Object):Void {
		name = nam;
		data = dat;
		maxAge = null;
		domain = null;
		path = null;
	}

/* === Instance Methods === */

	/**
	  * Serialize [this] Cookie
	  */
	public function serialize():String {
		var pairs:Array<String> = ['$name=${sdata()}'];
		var opt = pairs.push.bind(_);

		if (maxAge) {
			pairs.push('Max-Age=$maxAge');
		}

		if (domain) opt('Domain=$domain');
		if (path) opt('Path=$path');

		return pairs.join('; ');
	}

	/**
	  * Serialize [this]'s data
	  */
	private function sdata():String {
		Serializer.USE_CACHE = true;
		Serializer.USE_ENUM_INDEX = true;

		return Serializer.run( data );
	}

/* === Class Methods === */

	/**
	  * Parse a Cookie String into an Object
	  */
	public static function parse(str : String):Object {
		var o:Object = {};
		var pairs:Array<String> = ~/; */.split(str);

		for (pair in pairs) {
			var ei:Int = pair.indexOf('=');
			if (ei < 0) continue;
			var key = pair.substr(0, ei).trim();
			var val = pair.substr(ei+1, pair.length).trim();

			o[key] = Unserializer.run(val);
		}
		return o;
	}

/* === Instance Fields === */

	public var name : String;
	public var data : Object;
	public var maxAge : Maybe<Int>;
	public var domain : Maybe<String>;
	public var path : Maybe<String>;
	//public var expires : Maybe<Date>;
}
