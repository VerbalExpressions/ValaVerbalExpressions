using GLib;

namespace Verbex {

	public int main (string[] args) {
		Test.init (ref args);

		Test.add_func ("/end_of_line/matches", () => {
			var verbex = VerbalExpression.verbex ().add (".com").end_of_line ();

			assert_true (verbex.matches ("www.google.com"));
		});

		Test.add_func ("/end_of_line/not_matches", () => {
			var verbex = VerbalExpression.verbex ().add (".com").end_of_line ();

			assert_false (verbex.matches ("www.google.com"));
		});

		return Test.run ();
	}
}
