# ValaVerbalExpressions
Regular expressions in Vala made easy

## Installing / Getting started

To build this library, you need [Meson](https://mesonbuild.com), and Vala >= 0.28

```shell
git clone https://github.com/VerbalExpressions/ValaVerbalExpressions.git
cd ValaVerbalExpressions/
mkdir build
cd build
meson ..
ninja build
```

To install system-wide, follow the Stew help pages

## Developing

This library uses [Valadate](https://github.com/astavale/valadate) for its test (not yet functional) 


### Usage

```vala
	var verbex = new VerbalExpression()
		.start_of_line()
		.then("http")
		.maybe("s")
		.then("://")
		.maybe("www.")
		.anything_but(" ")
		.end_of_line();
	// Create an example URL
	var test_me = "https://www.vala-project.org";
	// Verify using VerbalExpression's matches() method
	assert_true(verbex.matches(test_me));
```


## Missing Features

Patches accepted for the following features
* Capture/subgroups
* Efficient expression composition


## Contributing

If you'd like to contribute, please fork the repository and use a feature
branch. Pull requests are warmly welcome.

Please keep the code style, whitespace changes that do not adhere to the coding standart won't be merged.

## Licensing

The code in this project is licensed under the MIT license.

