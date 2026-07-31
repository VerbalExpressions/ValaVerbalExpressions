using GLib;

namespace Verbex {
	public class VerbalExpression : GLib.Object {
		private string prefixes;
		private StringBuilder internal_builder;
		private string suffixes;
		private GLib.RegexCompileFlags pattern_flags;
		private bool stop_at_first_flag;

		private string sources {
			get {
				return internal_builder.str;
			}
		}

		public Regex? regex {
			owned get {
				try {
					return new Regex (this.to_string (), pattern_flags);
				} catch (RegexError e) {
					return null;
				}
			}
		}

		public Regex build () throws RegexError {
			return new Regex (this.to_string (), pattern_flags);
		}

		public static VerbalExpression verbex () {
			return new VerbalExpression ();
		}

		construct {
			prefixes = "";
			internal_builder = new StringBuilder ();
			suffixes = "";
			pattern_flags = RegexCompileFlags.MULTILINE;
			stop_at_first_flag = false;
		}

		public string escape (string test_str) {
			return Regex.escape_string (test_str);
		}

		public bool test (string test_str) {
			return matches (test_str);
		}

		public bool matches (string test_str) {
			if (regex == null) return false;
			return regex.match (test_str);
		}

		public MatchInfo get_match_info (string test_str) {
			MatchInfo retval;
			Regex reg;
			try {
				reg = regex ?? new Regex ("");
			} catch (RegexError e) {
				assert_not_reached ();
			}
			reg.match (test_str, 0, out retval);
			return retval;
		}

		public int count (string test_str) {
			if (regex == null) return 0;
			MatchInfo info;
			int match_cnt = 0;
			try {
				if (regex.match (test_str, 0, out info)) {
					while (info.matches ()) {
						match_cnt++;
						info.next ();
					}
				}
			} catch (RegexError e) {
				return 0;
			}
			return match_cnt;
		}

		public string[] split (string test_str) {
			if (regex == null) return new string[0];
			return regex.split (test_str);
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
		 * @param sanitize - whether to sanitize regex_str or not (defaults to true)
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

		public VerbalExpression find (string val, bool sanitize = true) {
			return then (val, sanitize);
		}

		public VerbalExpression maybe (string val, bool sanitize = true) {
			var rval = sanitize ? escape (val) : val;
			return add (@"(?:$rval)?", false);
		}

		public VerbalExpression anything () {
			return add ("(?:.*)", false);
		}

		public VerbalExpression anything_but (string val, bool sanitize = true) {
			var rval = sanitize ? escape (val) : val;
			return add (@"(?:[^$rval]*)", false);
		}

		public VerbalExpression something () {
			return add ("(?:.+)", false);
		}

		public VerbalExpression something_but (string val, bool sanitize = true) {
			var rval = sanitize ? escape (val) : val;
			return add (@"(?:[^$rval]+)", false);
		}

		public string replace (string source, string replacement) throws RegexError {
			if (regex == null) return source;
			if (stop_at_first_flag) {
				MatchInfo match_info;
				if (regex.match (source, 0, out match_info)) {
					int start_pos, end_pos;
					if (match_info.fetch_pos (0, out start_pos, out end_pos)) {
						var matched_str = source.substring (start_pos, end_pos - start_pos);
						var replaced_str = regex.replace (matched_str, matched_str.length, 0, replacement);
						return source.substring (0, start_pos) + replaced_str + source.substring (end_pos);
					}
				}
				return source;
			} else {
				return regex.replace (source, source.length, 0, replacement);
			}
		}

		public VerbalExpression line_break () {
			return add ("(?:\\r\\n|\\r|\\n)", false);
		}

		public VerbalExpression br () {
			return line_break ();
		}

		public VerbalExpression tab () {
			return add ("\\t", false);
		}

		public VerbalExpression word () {
			return add ("\\w+", false);
		}

		public VerbalExpression digit () {
			return add ("\\d", false);
		}

		public VerbalExpression digits () {
			return add ("\\d+", false);
		}

		public VerbalExpression whitespace () {
			return add ("\\s+", false);
		}

		public VerbalExpression space () {
			return whitespace ();
		}

		public VerbalExpression any_of (string val, bool sanitize = true) {
			var rval = sanitize ? escape (val) : val;
			return add (@"(?:[$rval])", false);
		}

		public VerbalExpression any (string val, bool sanitize = true) {
			return any_of (val, sanitize);
		}

		public VerbalExpression range (string[] args) {
			var builder = new StringBuilder ("(?:[");
			for (int i = 0; i < args.length; i += 2) {
				var from = escape (args[i]);
				if (i + 1 < args.length) {
					var to = escape (args[i + 1]);
					builder.append (@"$from-$to");
				} else {
					builder.append (from);
				}
			}
			builder.append ("])");
			return add (builder.str, false);
		}

		public VerbalExpression range_pair (string from, string to) {
			return range (new string[] {from, to});
		}

		public VerbalExpression multiple (string val, bool sanitize = true, int min = -1, int max = -1) {
			var rval = sanitize ? escape (val) : val;
			if (min < 0 && max < 0) {
				return add (@"(?:$rval)+", false);
			} else if (min >= 0 && max < 0) {
				return add (@"(?:$rval){$min,}", false);
			} else {
				return add (@"(?:$rval){$min,$max}", false);
			}
		}

		public VerbalExpression repeat_previous (int times) {
			return add (@"{$times}", false);
		}

		public VerbalExpression repeat_previous_in_range (int from, int to) {
			return add (@"{$from,$to}", false);
		}

		public VerbalExpression at_least (int count) {
			return add (@"{$count,}", false);
		}

		public VerbalExpression begin_capture () {
			return add ("(", false);
		}

		public VerbalExpression end_capture () {
			return add (")", false);
		}

		public VerbalExpression capture (string val, bool sanitize = true) {
			var rval = sanitize ? escape (val) : val;
			return add (@"($rval)", false);
		}

		public VerbalExpression or (string val, bool sanitize = true) {
			prefixes += "(";
			suffixes = ")" + suffixes;
			internal_builder.append (")|(");
			return add (val, sanitize);
		}

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
			if (enable) {
				add_modifier ('i');
			} else {
				remove_modifier ('i');
			}
			return this;
		}

		public VerbalExpression as_one_line (bool enable = true) {
			if (enable) {
				remove_modifier ('m');
			} else {
				add_modifier ('m');
			}
			return this;
		}

		public VerbalExpression stop_at_first (bool enable = true) {
			stop_at_first_flag = enable;
			return this;
		}
	}
}

