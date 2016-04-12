using GLib;

namespace Verbex {

	[Test(name="Test for something_but() edge cases")]
	public class SomethingButTest : Valadate.Framework.TestCase {

		[Test (name="Test that an empty string does not match on something_but()")]
		public void SomethingBut_EmptyStringAsParameter_DoesNotMatch() {
			var verbex = VerbalExpression.verbex().something_but("Hakuna");
			
			assert_false(verbex.matches(""));
		}
	}

}