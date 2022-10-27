using GLib;

namespace Verbex {

	public int main (string[] args) {

		Test.init (ref args);
		Test.add_func ("/maybe", () => {
			var verbex = VerbalExpression.verbex ()
				.start_of_line ()
				.then ("a")
				.maybe ("b");

			assert_true (verbex.matches ("a"));
		});
		return Test.run ();
	}
}
