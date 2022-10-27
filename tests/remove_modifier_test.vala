using GLib;

namespace Verbex {

	public int main (string[] args) {

		Test.init (ref args);

		Test.add_func ("/modifier/i_modifier_removal", () => {
			var verbex = VerbalExpression.verbex ().add ("test_string").remove_modifier ('i');

			assert_false (verbex.matches ("TEST_STRING"));
		});

		Test.add_func ("/modifier/m_modifier_removal", () => {
			var verbex = VerbalExpression.verbex ().remove_modifier ('m');

			assert_false (verbex.test ("test \n string"));
		});

		Test.add_func ("/modifier/s_modifier_removal", () => {
			string test_string = "First\nSecond";

			var verbex  = VerbalExpression.verbex ().add ("First").anything ().then ("Second");

			assert_true (verbex.matches (test_string));

			verbex.add_modifier ('s');
			assert_false (verbex.matches (test_string));
		});

		Test.add_func ("/modifier/x_modifier_removal", () => {
			var verbex = VerbalExpression.verbex ().add ("test string").remove_modifier ('x');

			assert_false (verbex.matches ("teststring"));
		});

		return Test.run ();
	}
}
