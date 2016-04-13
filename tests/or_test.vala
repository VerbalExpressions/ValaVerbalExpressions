using GLib;
using Valadate;

namespace Verbex {

	[Test (name="")]
	public class OrTest : Valadate.Framework.TestCase {

		[Test (name="Test regular or() usage")]
		public void test_or() {
			var verbex = VerbalExpression.verbex().add("vala").or("genie");

			assert_true(verbex.matches("vala"));
			assert_true(verbex.matches("genie"));
		}
	}
}
