using GLib;
using Valadate;

namespace Verbex {

	[Test (name="Modifier addition test")]
	public class AddModifierTest : Valadate.Framework.TestCase {

		[Test (name="Test that adding 'i' as modifier removes case sensitivity")]
		public void test_i_modifier_addition() {
			var verbex = VerbalExpression.verbex().add("test_string").add_modifier('i');

			assert_true(verbex.matches("TEST_STRING"));
		}

		[Test (name="Test that addding 'm' as modifier enables multiline")]
		public void test_m_modifier_addition() {
			var verbex = VerbalExpression.verbex().add_modifier('m');

			assert_true(verbex.test("test \n string"));
		}

		[Test (name="Test that addding 's' as modifier forces single line")]
		public void test_s_modifier_addition() {
			string test_str = "First\nSecond";

			var verbex  = VerbalExpression.verbex().add("First").anything().then("Second");

			assert_false(verbex.matches(test_string));

			verbex.add_modifier('s');
			assert_true(verbex.matches(test_string));
		}

		[Test (name="Test that adding 'x' as modifier forces whitespace ignore")]
		public void test_x_modifier_addition() {
			var verbex = VerbalExpression.verbex().add("test string").add_modifier('x');

			assert_true(verbex.matches("test string val"));
		}
	}

}