using GLib;
using Valadate;

namespace Verbex {

	[Test (name="Test for end_of_line() edge cases")]
	public class EndOfLineTest : Valadate.Framework.TestCase {

		[Test (name="Test that end_of_line() properly matches")]
		public void test_end_of_line_matching() {
			var verbex = VerbalExpression.verbex().add(".com").end_of_line();

			assert_true(verbex.matches("www.google.com"));
		}

		[Test (name="Test that end_of_line disallows non-strict matching")]
		public void test_end_of_line_wrong_matching() {
			var verbex = VerbalExpression.verbex().add(".com").end_of_line();

			assert_false(verbex.matches("www.google.com/"));
		}
	}
}
