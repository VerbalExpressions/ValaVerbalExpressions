using GLib;

namespace Verbex {

	[Test(name="Test for start_of_line() edge cases")]
	public class StartOfLineTest : Valadate.Framework.TestCase {
	
		[Test (name="Test that calling start_of_line() later still appends to the beginning")]
		public void test_start_of_line_random_placement() {
			var verbex = VerbalExpression.verbex().add("test").add("ing").start_of_line();

			assert_true(verbex.matches("testing for lyfe"));
		}

		[Test(name="Test that using start_of_line() does not mess up with match order")]
		public void test_start_of_line_match_order() {
			var verbex = VerbalExpression.verbex().start_of_line()
				.then("http")
				.maybe("www");

			assert_true(verbex.matches("http"));
			assert_false(verbex.matches("www"));
		}
	}
}
