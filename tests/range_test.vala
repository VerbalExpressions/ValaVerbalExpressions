using GLib;

namespace Verbex {
	public int main (string[] args) {
		Test.init (ref args);

		Test.add_func ("/range/letters", () => {
			var verbex = VerbalExpression.verbex ()
				.start_of_line ()
				.range_pair ("a", "z")
				.end_of_line ();

			assert_true (verbex.matches ("f"));
			assert_false (verbex.matches ("F"));
			assert_false (verbex.matches ("1"));
		});

		Test.add_func ("/range/multiple_ranges", () => {
			var verbex = VerbalExpression.verbex ()
				.start_of_line ()
				.range (new string[] {"a", "z", "0", "9"})
				.end_of_line ();

			assert_true (verbex.matches ("a"));
			assert_true (verbex.matches ("5"));
			assert_false (verbex.matches ("Z"));
		});

		return Test.run ();
	}
}
