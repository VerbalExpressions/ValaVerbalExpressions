using GLib;

namespace Verbex {
	public class VerbalExpression {
		private string prefixes;
		private string sources;
		private string suffixes;
		private uint32 pattern_flags;

		public Regex regex {
			get {
				return new Regex((prefixes+sources+suffixes), pattern_flags);
			}
			
		}

		public static VerbalExpression verbex() {
			return new VerbalExpression();
		}

		public VerbalExpression() {
			this.prefixes = "";
			this.sources = "";
			this.suffixes = "";
			this.pattern_flags = RegexCompileFlags.MULTILINE;
		}

		public string sanitize(string val) {
			return Regex.escape_string(value);
		}

		public bool test(string test_str) {
			return matches(test_str);
		}

		public bool matches(string test_str) {
			return regex.match(test_str);
		}

		public string to_string() {
			return prefixes+sources+suffixes;
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
		 * @param sanitize - wether to sanitize regex_str or not (dafaults to true)
		 * @return this the same VerbalExpression instance (for chaining purposes)
		 */
		public VerbalExpression add(string regex_str, bool sanitize = true) {
			var val = sanitize ? sanitize(regex_str) : regex_str;
			source += val;
			return this;
		}

		public VerbalExpression start_of_line(bool enable = true) {
			prefixes = enable ? "^" : "";
			return this;
		}

		public VerbalExpression end_of_line(bool enable = true) {
			suffixes = enable ? "$" : "";
			return this;
		}

		public VerbalExpression then(string val, bool sanitize = true) {
			var rval = sanitize ? sanitize(val) : val;
			return add(@"(?:$rval)", false);
		}

		public VerbalExpression find(string val) {
			return then(val);
		}

		public VerbalExpression maybe(string val, bool sanitize = true) {
			var rval = sanitize ? sanitize(val) : val;
			return add(@"($rval)?", false);
			
		}

		public VerbalExpression anything() {
			return add("(.*)", false);
		}

		public VerbalExpression anything_but(string val, bool sanitize = true) {
			var rval sanitize ? sanitize(val) : val;
			return add(@"([^$rval]*)", false);
		}

		public VerbalExpression something() {
			return add("(.+)", false);
		}

		public VerbalExpression something_but(string val, bool sanitize = true) {
			var rval sanitize ? sanitize(val) : val;
			return add(@"([^$rval]+)", false);
		}

		public VerbalExpression replace(string val) throws RegexError {
			try{
				regex.replace()
			} catch (RegexError e){
				throw e;
			}

			return this;
		}

		public VerbalExpression line_break() {
			return add("""(?:\n|(?:\r\n))""", false);
		}

		public VerbalExpression br() {
			return line_break();
		}

		public VerbalExpression tab() {
			return add("""\t""");
		}

		public VerbalExpression word() {
			return add("""\w+""", false);
		}

		public VerbalExpression any_of(string val, bool sanitize = true) {
			var rval sanitize ? sanitize(val) : val;
			return add(@"([{$rval}])", false);
		}

		public VerbalExpression any(string val) {
			return any_of(value);
		}


		public VerbalExpression multiple(string val, bool sanitize = true) {
			var rval sanitize ? sanitize(val) : val;
			return add(@"($rval)+", false);
		}

		public VerbalExpression or(string val, bool sanitize = true) {
			prefixes += "(";
			suffixes = ")" + suffixes;

			source += ")|(";

			return add(val, sanitize);
		}

		public VerbalExpression repeat_previous(int n) {
			return add(@"{$n}", false);
		}

		public VerbalExpression repeat_previous(int from, int to {
			return add(@"{$from,$to}", false);
		}

		public VerbalExpression add_modifier(char modifier) {
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

		public VerbalExpression remove_modifier(char modifier) {
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

		public VerbalExpression with_any_case(bool enable = true) {
			if (enable)	{
				add_modifier('i');
			} else{
				remove_modifier('i');
			}
			return this;
		}

		public VerbalExpression as_one_line(bool enable) {
			if (enable)	{
				remove_modifier('m');
			} else {
				add_modifier('m');
			}
			return this;
		}

	}
}
