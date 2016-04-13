using GLib;
using Valadate;

namespace Verbex {

	[Test (name="Test for maybe() edge cases")]
	public class MaybeTest : Valadate.Framework.TestCase {

		[Test (name="Test for maybe() regular usage")]
		public void test_maybe() {
			var verbex = VerbalExpression.verbex()
				.start_of_line()
				.then("a")
				.maybe("b")

			assert_true(verbex.matches("a")):
		}
	}
}
