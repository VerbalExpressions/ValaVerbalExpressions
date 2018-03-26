using GLib;

namespace Verbex {

	public int main (string[] args) {
		Test.init (ref args);
		Test.add_func ("/then/repeated", () => {
			var verbex = VerbalExpression.verbex ().start_of_line ().then ("abc")
				.br ()
				.then ("def");
			assert_true (verbex.matches ("abc\ndef"));
		});
		return Test.run ();
	}
}
