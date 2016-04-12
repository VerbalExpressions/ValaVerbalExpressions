using GLib;

namespace Verbex {

	[Test(name="Test for input sanitization ")]
	public class SanitizeTest : Valadate.Framework.TestCase {
	
		[Test (name="Test that sanitize() truly escapes characters")]
		public void test_sanitize() {
			var verbEx = VerbalExpression.verbex();
			string val = "*+?";
			string expected = """\*\+\?""";

			assert_true(expected ==  verbex.sanitize(val));
		}
	}
}
