package hxpress.content;

import tannus.ds.Object;
import tannus.io.ByteArray;
import tannus.xml.Elem;
import tannus.css.StyleSheet;

import hxpress.content.Content;

class HTMLDocument {
	/* Constructor Function */
	public function new():Void {
		root = new Elem('html');
		head = new Elem('head', root);
		titel = new Elem('title', head);
		body = new Elem('body', root);
		contents = new Array();
	}

/* === Instance Methods === */

	/**
	  * Add a StyleSheet to [this] Document
	  */
	public function styleSheet(sheet : StyleSheet):Void {
		var style:Elem = new Elem('style', head);
		style.text = sheet.toString();
	}

	/**
	  * Add a Content instance to [this] Document
	  */
	public function append(child : Content):Void {
		contents.push( child );
	}

	/**
	  * Perform any last-second alterations to the DOM before it's sent to the Client
	  */
	private function pack():Void {
		for (c in contents) {
			c.pack();
			if (c.el != null)
				body.addChild( c.el );
		}
	}

	/**
	  * Generate the HTML markup for [this] Document
	  */
	public function print():String {
		pack();
		return root.print();
	}

/* === Computed Instance Fields === */

	/**
	  * The 'title' of [this] Document
	  */
	public var title(get, set):String;
	private function get_title() return titel.text;
	private function set_title(v) return (titel.text = v);

/* === Instance Fields === */

	public var root : Elem;
	public var head : Elem;
	private var titel : Elem;
	public var body : Elem;

	public var contents : Array<Content>;
}
