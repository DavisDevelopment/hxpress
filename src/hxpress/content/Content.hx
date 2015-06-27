package hxpress.content;

import tannus.io.EventDispatcher;
import tannus.xml.Elem;

class Content extends EventDispatcher {
	/* Constructor Function */
	public function new():Void {
		super();
		
		addSignals([
			'pack'
		]);
		
		el = null;
	}

/* === Instance Methods === */

	/**
	  * convenience method to create a new Elem
	  */
	private inline function elem(tag:String, ?parent:Elem):Elem {
		return new Elem(tag, parent);
	}

	/**
	  * handle any last-minute changes to [this] Content
	  */
	public function pack():Void {
		dispatch('pack', this);
	}

/* === Instance Fields === */

	public var el : Null<Elem>;
}
