using GLib;

namespace Verbex {

	public int main (string[] args) {

		Test.init (ref args);

    	Test.add_func ("/add/dot", () => {
            var verbex = VerbalExpression.verbex ().add (".org");

            assert_false (verbex.matches ("vala-projectorg"));
        });

        return Test.run ();
    }
}
