using GLib;

namespace Verbex {

	public int main (string[] args) {

		Test.init (ref args);
		Test.add_func ("/url_match", () => {
			var verbex = VerbalExpression.verbex ()
				.start_of_line ()
				.then ("http")
				.maybe ("s")
				.then ("://")
				.maybe ("www.")
				.anything_but (" ")
				.end_of_line ();

			var test_me = "https://www.vala-project.org";

			assert_true (verbex.test (test_me));
		});

		Test.add_func ("/multiple/start_of_line-anything-end_of_line", () => {
			var verbex = VerbalExpression.verbex ()
				.start_of_line ()
				.anything ()
				.end_of_line ();
			assert_true (verbex.matches ("ЁЂЃЄЅІЇЈЉЊЋ💟💜💛💚💙ГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪнопрстуфхцчшщъыьэюя"));
		});

		Test.add_func ("/replace", () => {
			try {
				var res = VerbalExpression.verbex ().add ("world").replace ("hello world", "vala");
				assert_true (res == "hello vala");
			} catch (RegexError err) {
				assert_not_reached ();
			}

		});

		Test.add_func ("/line_break", () => {
			var verbex = VerbalExpression.verbex ().line_break ();
			assert_true(verbex.test("Test text wi a \nbreak line"));
		});

		Test.add_func ("/tab", () => {
			var verbex = VerbalExpression.verbex ().tab ();
			assert_true(verbex.test("text with \t tab"));
		});

		Test.add_func ("/word", () => {
			var verbex = VerbalExpression.verbex ().word ();
			assert_true (verbex.count ("four simple words here") == 4);
		});

		return Test.run ();
	}
}

