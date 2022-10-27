using GLib;

namespace Verbex {

	public int main (string[] args) {

		Test.init (ref args);
		Test.add_func ("/something_but/empty_string", () => {
			var verbex = VerbalExpression.verbex ().something_but ("Hakuna");
			
			assert_false (verbex.matches (""));
		});
		return Test.run ();
	}

}
