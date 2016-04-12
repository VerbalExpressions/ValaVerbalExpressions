using GLib;

namespace Verbex {

	[Test (name="Test for multiple() edge cases")]
	public class MultipleTest : Valadate.Framework.TestCase {

		[Test (name="Test that multiple() works")]
		public void test_multiple() {
			var verbex = VerbalExpression.verbex().add("mo")
				.multiple("jo")
				.add("y");
			
			assert_true(verbex.matches("A mojojoy just bite my tongue"));
		}
	}
}
