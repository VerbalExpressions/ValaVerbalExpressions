using GLib;

namespace Verbex {

	[Test(name="Test for with_any_case() edge cases")]
	public class WithAnyCaseTest : Valadate.Framework.TestCase {

		[Test (name="Test for regular with_any_case() usage")]
		public void test_with_any_case() {
			var verbex = VerbalExpression.verbex().add("www")
				.with_any_case();

			assert_true(verbex.matches("WWW"));
		}

		[Test (name="Test for disabling with_any_case()")]
		public void test_with_any_case() {
			var verbex = VerbalExpression.verbex().add("www")
				.with_any_case(false);

			assert_false(verbex.matches("WWW"));
		}
	}
}
