package hxpress.http;

import hxpress.nhttp.ServerResponse in NRes;

import tannus.io.ByteArray;
import tannus.ds.Object;
import tannus.ds.Maybe;

import tannus.sys.File;
import tannus.sys.Path;
import tannus.sys.Mimes;

@:forward
abstract ServerResponse (NRes) from NRes to NRes {
	/* Constructor Function */
	public inline function new(nr : NRes):Void {
		this = nr;
	}

/* === Instance Methods === */

	/**
	  * Write some data to [this] response
	  */
	public function write(chunk:ByteArray, ?enc:String, ?cb:Void->Void):Void {
		this.write(chunk, enc, cb);
	}

	/**
	  * Write the contents of a given file
	  */
	public function sendFile(path : Path):Void {
		if (!this.headersSent) {
			var mime:Maybe<String> = Mimes.getMimeType(path.extension);
			var f:File = path;

			if (f.exists) {
				this.writeHead(200, {
					'content-type'  : (mime || 'text/plain'),
					'content-length': f.size
				});

				write(f.read());

				this.end();
			} else {
				this.writeHead(404, 'Fuck You');
				this.end();
			}
		} else throw 'Cannot set headers after they have been sent';
	}
}
