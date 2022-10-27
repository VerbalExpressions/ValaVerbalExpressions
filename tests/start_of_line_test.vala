using GLib;

namespace Verbex {

	public int main (string[] args) {
	
		Test.init (ref args);
		Test.add_func ("/start_of_line/unordered", () => {
			var verbex = VerbalExpression.verbex().add("test").add("ing").start_of_line();

			assert_true(verbex.matches("testing for lyfe"));
		});

		Test.add_func ("/start_of_line/match_order", () => {
			var verbex = VerbalExpression.verbex ().start_of_line ()
				.then ("http")
				.maybe ("www");

			assert_true (verbex.matches ("http"));
			assert_false (verbex.matches ("www"));
		});
		return Test.run ();
	}
}
