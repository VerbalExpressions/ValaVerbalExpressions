using GLib;
namespace Verbex {

	public int main (string[] args) {

		Test.init (ref args);
		Test.add_func ("/multiple", () => {
			var verbex = VerbalExpression.verbex ()
				.add ("mo")
				.multiple ("jo")
				.add ("y");
			
			assert_true (verbex.matches ("A mojojoy just bite my tongue"));
		});
		return Test.run ();
	}
}
