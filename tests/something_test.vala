using GLib;

namespace Verbex {

	[Test(name="Test for something() edge cases")]
	public class SomethingTest : Valadate.Framework.TestCase {

		[Test(name="Test that something() does not match an empty string")]
		public void test_something_empty_string() {
			var verbex = VerbalExpression.verbex().something();
			
			assert_false(verbex.matches(""));
		}

		
		[Test (name="Test that something() works as expected")]
		public void test_something()
		{
			var verbex = VerbalExpression.verbex().something();
			
			assert_true(verbex.matches("Hello Rato"));
		}
	}

}