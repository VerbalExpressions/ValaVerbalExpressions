using GLib;
using Valadate;

namespace Verbex {

	[Test(name="Test for then() edge cases")]
	public class ThenTest : Valadate.Framework.TestCase {

		[Test (name="Test that then() works even if repeated")]
		public void test_then() {
			var verbex = VerbalExpression.verbex().start_of_line().then("abc")
				.br()
				.then("def");
			assert_true(verbex.matches("abc\ndef"));
		}
	}
}
