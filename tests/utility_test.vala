using GLib;

namespace Verbex {
	public int main (string[] args) {
		Test.init (ref args);

		Test.add_func ("/utility/count", () => {
			var verbex = VerbalExpression.verbex ().then ("foo");
			assert_true (verbex.count ("foo bar foo baz foo") == 3);
		});

		Test.add_func ("/utility/split", () => {
			var verbex = VerbalExpression.verbex ().then (",");
			var parts = verbex.split ("apple,banana,orange");
			assert_true (parts.length == 3);
			assert_true (parts[0] == "apple");
			assert_true (parts[1] == "banana");
			assert_true (parts[2] == "orange");
		});

		Test.add_func ("/utility/stop_at_first", () => {
			var verbex = VerbalExpression.verbex ()
				.then ("foo")
				.stop_at_first (true);

			try {
				var res = verbex.replace ("foo bar foo baz foo", "bar");
				assert_true (res == "bar bar foo baz foo");
			} catch (RegexError e) {
				assert_not_reached ();
			}
		});

		Test.add_func ("/utility/capture", () => {
			var verbex = VerbalExpression.verbex ()
				.start_of_line ()
				.capture ("hello")
				.whitespace ()
				.begin_capture ()
				.then ("world")
				.end_capture ()
				.end_of_line ();

			assert_true (verbex.matches ("hello world"));

			MatchInfo info = verbex.get_match_info ("hello world");
			assert_true (info.fetch (1) == "hello");
			assert_true (info.fetch (2) == "world");
		});

		Test.add_func ("/utility/build", () => {
			var verbex = VerbalExpression.verbex ().then ("test");
			try {
				Regex built_regex = verbex.build ();
				assert_true (built_regex.match ("test"));
			} catch (RegexError e) {
				assert_not_reached ();
			}
		});

		return Test.run ();
	}
}
