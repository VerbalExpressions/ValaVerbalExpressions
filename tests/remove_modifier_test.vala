using GLib;
using Valadate;

namespace Verbex {

	[Test (name="Modifier removal test")]
	public class RemoveModifierTest : Valadate.Framework.TestCase {
		[Test (name="Test that removing 'i' as modifier enables case sensitivity")]
		public void test_i_modifier_addition() {
			var verbex = VerbalExpression.verbex().add("test_string").add_modifier('i');

			assert_false(verbex.matches("TEST_STRING"));
		}

		[Test (name="Test that removing 'm' as modifier disables multiline")]
		public void test_m_modifier_addition() {
			var verbex = VerbalExpression.verbex().add_modifier('m');

			assert_false(verbex.test("test \n string"));
		}

		[Test (name="Test that removing 's' as modifier disables single line")]
		public void test_s_modifier_addition() {
			string test_str = "First\nSecond";

			var verbex  = VerbalExpression.verbex().add("First").anything().then("Second");

			assert_true(verbex.matches(test_string));

			verbex.add_modifier('s');
			assert_false(verbex.matches(test_string));
		}

		[Test (name="Test that removing 'x' as modifier disables whitespace ignore")]
		public void test_x_modifier_addition() {
			var verbex = VerbalExpression.verbex().add("test string").add_modifier('x');

			assert_false(verbex.matches("test string #comment"));
		}
	}
}
