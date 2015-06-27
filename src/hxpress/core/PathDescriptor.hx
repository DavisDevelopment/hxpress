package hxpress.core;

import tannus.ds.Maybe;
import tannus.ds.Object;
import tannus.io.ByteArray;
import tannus.io.Byte;
import tannus.io.RegEx;
import tannus.io.Getter;

import tannus.sys.Path;

using StringTools;
using Lambda;

class PathDescriptor {
	/* Constructor Function */
	public function new(desc : String):Void {
		str = desc;

		__buildRegEx();
	}

/* === Instance Methods === */

	/**
	  * Build RegEx from path-descriptor
	  */
	private function __buildRegEx():Void {
		var regs:String = '';
		var bits:ByteArray = str;
		// var special = ByteArray.fromString('.*+?[]^$\\|()').toArray();
		
		var done:Getter<Bool> = Getter.create(bits.length <= 0);
		var nodone:Getter<Bool> = Getter.create(!done());
		
		while (nodone) {
			var c:Byte = bits.shift();

			if (c == '*'.code) {
				c = bits.shift();
				if (c == '*'.code) {
					regs += '([A-Z0-9._%-]+/?)+';
				}

				else {
					bits.unshift( c );
					regs += '[A-Z0-9._%-]+';
				}
			}

			else if (c == '.'.code)
				regs += '\\.';

			else {
				regs += c;
			}
		}
		
		regs += '/?';
		regs = ((str.startsWith('/')?"^":'') + regs + "$");
		
		regex = new EReg(regs, 'i');
	}

	/**
	  * Validate a Path
	  */
	public function test(path : Path):Bool {
		return regex.match( path );
	}

/* === Instance Fields === */

	public var str : String;

	public var regex : RegEx;
}
