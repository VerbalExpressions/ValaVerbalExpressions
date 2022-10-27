using GLib;

namespace Verbex {

	public int main (string[] args) {

		Test.init (ref args);
		Test.add_func ("/sanitize", () => {
			var verbex = VerbalExpression.verbex ();
			string val = "*+?";
			string expected = """\*\+\?""";

			assert_true(expected ==  verbex.escape (val));
		});
		return Test.run ();
	}
}
