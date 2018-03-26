using GLib;

namespace Verbex {

	public int main (string[] args) {

		Test.init (ref args);
		Test.add_func ("/something/empty_string", () => {
			var verbex = VerbalExpression.verbex ().something ();
			
			assert_false (verbex.matches (""));
		});

		
		Test.add_func ("/something", () => {
			var verbex = VerbalExpression.verbex ().something ();
			
			assert_true (verbex.matches ("Hello Rato"));
		});

		return Test.run ();
	}

}
