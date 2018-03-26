using GLib;

namespace Verbex {

	public int main (string[] args) {

		Test.init (ref args);
		Test.add_func ("/with_any_case/enabled", () => {
			var verbex = VerbalExpression.verbex ().add ("www")
				.with_any_case ();

			assert_true (verbex.matches ("WWW"));
		});

		Test.add_func ("/with_any_case/disabled", () => {
			var verbex = VerbalExpression.verbex ().add ("www")
				.with_any_case (false);

			assert_false (verbex.matches ("WWW"));
		});
		return Test.run ();
	}
}
