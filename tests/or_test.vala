using GLib;

namespace Verbex {

	public int main (string[] args) {

		Test.init (ref args);
		Test.add_func ("/regular", () => {
			var verbex = VerbalExpression.verbex ().add ("vala").or ("genie");

			assert_true (verbex.matches ("vala"));
			assert_true (verbex.matches ("genie"));
		});
		return Test.run ();
	}
}
