package hxpress.content;

import hxpress.content.Content;

using hxpress.content.ElemTools;

class Heading extends Content {
	/* Constructor Function */
	public function new(lvl:Int, text:String):Void {
		super();

		el = elem('h$lvl');
		el.text = text;
		el.classes(['center']);
	}
}
