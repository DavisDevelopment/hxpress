package hxpress.content;

import hxpress.content.Content;
import tannus.xml.Elem;

using hxpress.content.ElemTools;

class Form extends Content {
	/* Constructor Function */
	public function new() {
		super();

		el = elem('form');
		idiv = elem('div', el);
		idiv.addClass('block-center');

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

/* === Instance Fields === */

	public var fields : Array<Elem>;
}
