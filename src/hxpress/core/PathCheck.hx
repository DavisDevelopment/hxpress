package hxpress.core;

import tannus.io.RegEx;
import tannus.sys.Path;

using haxe.EnumTools;
using StringTools;

abstract PathCheck (ECheck) from ECheck {
	/* Constructor Function */
	public inline function new(ec : ECheck):Void {
		this = ec;
	}

/* === Instance Methods === */

	/**
	  * Chain two Checks together
	  */
	@:op(A && B)
	public inline function and(other : PathCheck):PathCheck {
		return cast ECheck.CheckAnd(this, other);
	}

	/**
	  * Test a Path against [this] PathCheck
	  */
	public function validate(path : Path):Bool {
		switch (this) {
			case PathStartsWith(s):
				return (path.directory.normalize().startsWith(s.normalize()));

			case PathEndsWith(e):
				return (path.directory.normalize().endsWith(e.normalize()));

			case PathEquals(opath):
				return (path.directory.normalize() == opath.normalize());

			case NameStartsWith(s):
				return (path.basename.startsWith(s));

			case NameEndsWith(e):
				return (path.basename.endsWith(e));

			case NameEquals(n):
				return (path.basename == n);

			case NameMatches(reg):
				return (reg.match(path.basename));

			case ExtEquals(ex):
				return (path.extension == ex);

			case CheckOr(leftCheck, rightCheck):
				return (leftCheck.validate(path) || rightCheck.validate(path));

			case CheckAnd(l, r):
				return (l.validate(path) && r.validate(path));

			default:
				throw 'Cannot validate $this';
		}
	}

/* === Static Methods === */

	/* == Shorthand Methods for Creating the ECheck Constructs == */

	//- PathStartsWith
	public static inline function psw(start : Path):PathCheck return ECheck.PathStartsWith(start);

	//- PathEndsWith
	public static inline function pew(end : Path):PathCheck return ECheck.PathEndsWith(end);

	//- PathEquals
	public static inline function peq(whole : Path):PathCheck return ECheck.PathEquals(whole);

	//- NameStartsWith
	public static inline function fnsw(start : String):PathCheck return ECheck.NameStartsWith(start);

	//- NameEndsWith
	public static inline function fnew(end : String):PathCheck return ECheck.NameEndsWith(end);

	//- NameEquals
	public static inline function fneq(name : String):PathCheck return ECheck.NameEquals(name);

	//- NameMatches
	public static inline function fnereg(reg : RegEx):PathCheck return ECheck.NameMatches(reg);

	//- ExtEquals
	public static inline function ext(n : String):PathCheck return ECheck.ExtEquals(n);

	/**
	  * Parse a String into a PathCheck
	  */
	@:from
	public static function parse(str : String):PathCheck {
		var hasFilePart:Bool = !(str.endsWith('/'));
		var p:Path = new Path(str);
		var base:Null<String> = null;
		var ex:Null<String> = null;

		if (hasFilePart) {
			base = p.basename;
			ex = p.extension;
			p = p.directory;
		}

		var dirCheck:PathCheck;
		var baseCheck:Null<PathCheck> = null;
		var exCheck:Null<PathCheck> = null;

		if (p.str.indexOf('*') != -1) {
			if (p.startsWith('*'))
				dirCheck = pew(p.str.substring(1));
			else if (p.endsWith('*'))
				dirCheck = psw(p.str.substring(0, p.str.indexOf('*')));
			else {
				dirCheck = (psw(p.str.substring(0, p.str.indexOf('*'))) && pew(p.str.substring(p.str.indexOf('*')+1)));
			}
		}
		else {
			dirCheck = peq(p.normalize());
		}

		if (hasFilePart) {
			if (base.indexOf('*') != -1) {
				if (base.startsWith('*'))
					baseCheck = fnew(base.substring(1));
				else if (base.endsWith('*'))
					baseCheck = fnsw(base.substring(0, base.indexOf('*')));
				else {
					baseCheck = (fnsw(base.substring(0, base.indexOf('*'))) && fnew(base.substring(base.indexOf('*')+1)));
				}
			}
			else {
				baseCheck = fneq( p );
			}
		}

		if (hasFilePart) {
			exCheck = ExtEquals(ex);
			dirCheck = (dirCheck.and(baseCheck.and(exCheck)));
		}
		
		return exCheck;
	}
}

/**
  * Enum of all PathCheck Components
  */
enum ECheck {
	/* Path-Centric Checks */
	PathStartsWith(start : Path);
	PathEndsWith(end : Path);
	PathEquals(path : Path);

	/* File-Name Checks */
	NameStartsWith(start : String);
	NameEndsWith(end : String);
	NameEquals(name : String);
	NameMatches(pattern : RegEx);

	/* Extension-Centric Checks */
	ExtEquals(ext : String);

/* === Logical Checks === */

	/* Assert that only one of these two Checks must validate */
	CheckOr(left:PathCheck, right:PathCheck);

	/* Chain two Checks together */
	CheckAnd(left:PathCheck, right:PathCheck);
}
