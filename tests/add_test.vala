using GLib;

namespace Verbex {

    [Test (name="Test add() edge cases")]
    public class AddTest : Valadate.Framework.TestCase {

        [Test (name="Test that adding a dot does not mess up with the matching")]
        public void test_dot_addition() {
            var verbex = VerbalExpression.verbex().add(".org");

            assert_false(verbex.matches("vala-projectorg"));
        }
    }
}
