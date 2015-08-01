package hxpress.content;

import hxpress.content.Content;
import tannus.xml.Elem;
import Std.*;

using hxpress.content.ElemTools;

class Form extends Content {
	/* Constructor Function */
	public function new() {
		super();

		el = elem('form');
		fields = new Array();

		on('pack', function(x) {
			for (f in fields) {
				el.addChild( f );
			}
		});
	}

/* === Instance Methods === */

	/**
	  * Add a new Field to [this] Form
	  */
	public function addField(name:String, type:String):Elem {
		var inp = elem('input');
		inp.attr += {
			'type': type,
			'name': name
		};
		fields.push( inp );
		return inp;
	}

	/**
	  * Add a submit-button to [this] Form
	  */
	public function submit(txt : String):Elem {
		var sub = elem('input');
		sub.attr += {
			'type': 'submit',
			'value': txt
		};
		sub.addClass('block-center');
		on('pack', function(x) el.addChild(sub));
		return sub;
	}

/* === Computed Instance Fields === */

	/**
	  * The 'method' of [this] Form
	  */
	public var method(get, set):String;
	private function get_method() return string(el.attr['method']);
	private function set_method(nm) return (el.attr['method'] = nm);

	/**
	  * The 'action' of [this] Form
	  */
	public var action(get, set):String;
	private function get_action() return string(el.attr['action']);
	private function set_action(na) return (el.attr['action'] = na);

/* === Instance Fields === */

	public var fields : Array<Elem>;
}
