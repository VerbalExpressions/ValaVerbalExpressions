using GLib;

namespace Verbex {

	public int main (string[] args) {

		Test.init (ref args);

		Test.add_func ("/modifier/i_modifier_addition", () => {
			var verbex = VerbalExpression.verbex ().add ("test_string").add_modifier ('i');

			assert_true (verbex.matches ("TEST_STRING"));
		});
		Test.add_func ("/modifier/m_modifier_addition", () => {
			var verbex = VerbalExpression.verbex ().add_modifier ('m');

			assert_true (verbex.test ("test \n string"));
		});

		Test.add_func ("/modifier/modifier_addition", () => {
			string test_string = "First\nSecond";

			var verbex  = VerbalExpression.verbex ().add ("First").anything ().then ("Second");

			assert_false (verbex.matches (test_string));

			verbex.add_modifier ('s');
			assert_true (verbex.matches (test_string));
		});

		Test.add_func ("/modifier/x_modifier_addition", () => {
			var verbex = VerbalExpression.verbex ().add("test string").add_modifier ('x');

			assert_true (verbex.matches ("teststring"));
		});

		return Test.run ();
	}

}
