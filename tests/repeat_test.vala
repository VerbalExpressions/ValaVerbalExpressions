using GLib;

namespace Verbex {
	public int main (string[] args) {
		Test.init (ref args);

		Test.add_func ("/repeat/times", () => {
			var verbex = VerbalExpression.verbex ()
				.start_of_line ()
				.then ("a")
				.repeat_previous (3)
				.end_of_line ();

			assert_true (verbex.matches ("aaa"));
			assert_false (verbex.matches ("aa"));
			assert_false (verbex.matches ("aaaa"));
		});

		Test.add_func ("/repeat/range", () => {
			var verbex = VerbalExpression.verbex ()
				.start_of_line ()
				.then ("b")
				.repeat_previous_in_range (2, 4)
				.end_of_line ();

			assert_true (verbex.matches ("bb"));
			assert_true (verbex.matches ("bbb"));
			assert_true (verbex.matches ("bbbb"));
			assert_false (verbex.matches ("b"));
			assert_false (verbex.matches ("bbbbb"));
		});

		Test.add_func ("/repeat/at_least", () => {
			var verbex = VerbalExpression.verbex ()
				.start_of_line ()
				.then ("c")
				.at_least (2)
				.end_of_line ();

			assert_false (verbex.matches ("c"));
			assert_true (verbex.matches ("cc"));
			assert_true (verbex.matches ("cccc"));
		});

		return Test.run ();
	}
}
