using GLib;

namespace Verbex {
	public class VerbalExpression : GLib.Object {
		private string prefixes;
		private StringBuilder internal_builder;

		private string sources {
			get{
				return internal_builder.str;
			}
		}

		private string suffixes;
		private GLib.RegexCompileFlags pattern_flags;

		public Regex? regex {
			owned get {
				try {
					return new Regex (this.to_string (), pattern_flags);
				} catch (RegexError e) {
					return null;
				}
			}
			
		}

		public static VerbalExpression verbex () {
			return new VerbalExpression ();
		}

		construct {
			prefixes = "";
			internal_builder = new StringBuilder ();
			suffixes = "";
			pattern_flags = RegexCompileFlags.MULTILINE;
		}

		public string escape (string test_str) {
			return Regex.escape_string (test_str);
		}

		public bool test (string test_str) {
			return matches (test_str);
		}

		public bool matches (string test_str) {
			return regex.match (test_str);
		}

		public MatchInfo get_match_info (string test_str){
			MatchInfo retval;
			regex.match (test_str, 0, out retval);
			return retval;
		}

		public string to_string () {
			return prefixes + sources + suffixes;
		}

		 /**
		 * Append a literal expression
		 * Everything added to the expression should use this method
		 *
		 * All existing methods already use this, so for basic usage, this method is actually discouraged.
		 * 
		 * Example:
		 * verbex().add("\n.*").to_string() // produces an "\n.*" regexp
		 *
		 * @param regex_str - literal expression, not sanitized
		 * @param sanitize - wether to sanitize regex_str or not (defaults to true)
		 * @return this the same VerbalExpression instance (for chaining purposes)
		 */
		public VerbalExpression add (string regex_str, bool sanitize = true) {
			var val = sanitize ? escape (regex_str) : regex_str;
			internal_builder.append (val);
			return this;
		}

		public VerbalExpression start_of_line (bool enable = true) {
			prefixes = enable ? "^" : "";
			return this;
		}

		public VerbalExpression end_of_line (bool enable = true) {
			suffixes = enable ? "$" : "";
			return this;
		}

		public VerbalExpression then (string val, bool sanitize = true) {
			var rval = sanitize ? escape (val) : val;
			return add (@"(?:$rval)", false);
		}

		public VerbalExpression find (string val) {
			return then (val);
		}

		public VerbalExpression maybe (string val, bool sanitize = true) {
			var rval = sanitize ? escape (val) : val;
			return add (@"($rval)?", false);
			
		}

		public VerbalExpression anything () {
			return add ("(.*)", false);
		}

		public VerbalExpression anything_but (string val, bool sanitize = true) {
			var rval = sanitize ? escape (val) : val;
			return add (@"([^$rval]*)", false);
		}

		public VerbalExpression something () {
			return add ("(.+)", false);
		}

		public VerbalExpression something_but (string val, bool sanitize = true) {
			var rval = sanitize ? escape (val) : val;
			return add (@"([^$rval]+)", false);
		}

		public VerbalExpression replace (string val, string replacement) throws RegexError {
			try{
				regex.replace_literal(val, val.length, 0, replacement);
			} catch (RegexError e){
				throw e;
			}
			return this;
		}

		public VerbalExpression line_break () {
			return add ("""(?:\n|(?:\r\n))""", false);
		}

		public VerbalExpression br () {
			return line_break ();
		}

		public VerbalExpression tab () {
			return add ("""\t""");
		}

		public VerbalExpression word () {
			return add ("""\w+""", false);
		}

		public VerbalExpression any_of (string val, bool sanitize = true) {
			var rval = sanitize ? escape (val) : val;
			return add (@"([$rval])", false);
		}

		public VerbalExpression any (string val) {
			return any_of (val);
		}


		public VerbalExpression multiple (string val, bool sanitize = true) {
			var rval = sanitize ? escape (val) : val;
			return add (@"($rval)+", false);
		}

		public VerbalExpression or (string val, bool sanitize = true) {
			prefixes += "(";
			suffixes = ")" + suffixes;
			internal_builder.append (")|(");

			return add (val, sanitize);
		}
/*
		public VerbalExpression repeat_previous (int times) {
			return add (@"{$times}", false);
		}

		public VerbalExpression repeat_previous_in_range (int from, int to) {
			return add (@"{$from,$to}", false);
		}
		*/

		public VerbalExpression add_modifier (char modifier) {
			switch (modifier) {
				case 'i':
					pattern_flags |= RegexCompileFlags.CASELESS;
					break;
				case 'x':
					pattern_flags |= RegexCompileFlags.EXTENDED;
					break;
				case 'm':
					pattern_flags |= RegexCompileFlags.MULTILINE;
					break;
				case 's':
					pattern_flags |= RegexCompileFlags.DOTALL;
					break;
			}

			return this;
		}

		public VerbalExpression remove_modifier (char modifier) {
			switch (modifier) {
				case 'i':
					pattern_flags &= ~RegexCompileFlags.CASELESS;
					break;
				case 'x':
					pattern_flags &= ~RegexCompileFlags.EXTENDED;
					break;
				case 'm':
					pattern_flags &= ~RegexCompileFlags.MULTILINE;
					break;
				case 's':
					pattern_flags &= ~RegexCompileFlags.DOTALL;
					break;
			}
			return this;
		}

		public VerbalExpression with_any_case (bool enable = true) {
			if (enable)	{
				add_modifier ('i');
			} else{
				remove_modifier ('i');
			}
			return this;
		}

		public VerbalExpression as_one_line (bool enable = true) {
			if (enable)	{
				remove_modifier ('m');
			} else {
				add_modifier ('m');
			}
			return this;
		}

	}
}
