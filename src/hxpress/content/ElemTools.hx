package hxpress.content;

import tannus.ds.Maybe;
import tannus.ds.Object;
import tannus.xml.Elem;

using StringTools;
using Lambda;
using tannus.ds.ArrayTools;

class ElemTools {
	/**
	  * Get Array of class-names attached to an Elem
	  */
	public static function classes(e:Elem, ?nclasses:Array<String>):Array<String> {
		if (nclasses == null) {
			if (e.attr.exists('class')) {
				var res:Array<String> = e.attr['class'].value.split(' ');
				res = res.filter(function(s) return (s != ''));
				return res;
			} else return [];
		}
		else {
			e.attr['class'] = nclasses.join(' ');
			return nclasses;
		}
	}

	/**
	  * Check for a given class on [e]
	  */
	public static function hasClass(e:Elem, className:String):Bool {
		return (classes(e).has(className));
	}

	/**
	  * Add a class to [e]
	  */
	public static function addClass(e:Elem, cn:String):Void {
		var cl = classes(e);
		if (!cl.has(cn)) {
			cl.push(cn);
			classes(e, cl);
		}
	}

	/**
	  * Remove a class from [e]
	  */
	public static function removeClass(e:Elem, cn:String):Void {
		var cl = classes(e);
		cl.remove( cn );
		classes(e, cl);
	}

	/**
	  * Wrap [e] in another Elem, and return that wrapper
	  */
	public static function wrap(e:Elem, wrapTag:String):Elem {
		var wrapper = new Elem(wrapTag);
		var par:Null<Elem> = e.parent;
		if (par != null) {
			var pos:Int = par.indexOfChild(e);
			wrapper.addChild( e );
			par.replaceChild(e, wrapper);
		}
		return wrapper;
	}
}
