using GLib;

namespace Verbex {
	public int main (string[] args) {
		Test.init (ref args);

		Test.add_func ("/digit/single", () => {
			var verbex = VerbalExpression.verbex ()
				.start_of_line ()
				.digit ()
				.end_of_line ();

			assert_true (verbex.matches ("7"));
			assert_false (verbex.matches ("77"));
			assert_false (verbex.matches ("a"));
		});

		Test.add_func ("/digit/multiple", () => {
			var verbex = VerbalExpression.verbex ()
				.start_of_line ()
				.digits ()
				.end_of_line ();

			assert_true (verbex.matches ("12345"));
			assert_false (verbex.matches ("abc"));
		});

		Test.add_func ("/whitespace", () => {
			var verbex = VerbalExpression.verbex ()
				.start_of_line ()
				.whitespace ()
				.end_of_line ();

			assert_true (verbex.matches (" \t\n"));
			assert_false (verbex.matches ("a"));
		});

		return Test.run ();
	}
}
