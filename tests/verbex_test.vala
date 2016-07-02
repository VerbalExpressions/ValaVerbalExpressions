using GLib;
using Valadate;

namespace Verbex {
	[Test (name="Generic usability test")]
	public class VerbalExpressionTest : Valadate.Framework.TestCase {

		[Test (name="Test for valid URL match")]
		public void valid_url_test() {
			var verbex = new VerbalExpression()
				.start_of_line()
				.then("http")
				.maybe("s")
				.then("://")
				.maybe("www.")
				.anything_but(" ")
				.end_of_line();

			var test_me = "https://www.vala-project.org";

			assert_true(verbex.test(test_me));
		}

		[Test (name="Test that start_of_line(), anything() and end_of_line() match")]
		public void anything_oneline_test() {
			var verbex = new VerbalExpression()
				.start_of_line()
				.anything()
				.end_of_line();
			assert_true(verbex.matches("ЁЂЃЄЅІЇЈЉЊЋ💟💜💛💚💙ГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪнопрстуфхцчшщъыьэюя"));
		}

		[Test (name="Test that replace() behaves after initialization")]
		public void replace_throw_test() {
			try {
				VerbalExpression.verbex().replace("filler text", "text");
			} catch (RegexError err) {
				assert_not_reached();
			}

		}

		[Test (name="Test that line_break() matching works")]
		public void line_break_test() {
			var verbex = VerbalExpression.verbex().line_break();
			assert_true(verbex.test("Test text wi a \nbreak line"));
		}

		[Test (name="Test that tab() works")]
		public void tab_test() {
			var verbex = VerbalExpression.verbex().tab();
			assert_true(verbex.test("text with \t tab"));
		}

		[Test (name="Test that word() actually gives the right number of words")]
		public void word_count_test() {
			var verbex = VerbalExpression.verbex().word();
			MatchInfo? match_info =  verbex.get_match_info("four simple words here");
			if (match_info == null) {
				assert_not_reached();
			}
			assert_true(4 == (match_info.get_match_count() -1));
		}
	}
}
