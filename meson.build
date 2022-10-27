# The MIT License (MIT)
#
# Copyright (c) 2017 - 2018 Mario Daniel Ruiz Saaavedra <desiderantes93@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

project ('libverbex', ['vala', 'c'],
	license: 'MIT',
	version: '0.0.2')
	
glib = dependency('glib-2.0', version: '>=2.48')
gobject = dependency('gobject-2.0', version: '>=2.48')
gio = dependency('gio-2.0', version: '>=2.48')
gobject_introspection = dependency('gobject-introspection-1.0')
g_ir_compiler = find_program('g-ir-compiler', required: false)

deps = [
	glib,
	gobject,
	gobject_introspection
]
	
subdir ('src')

if get_option('enable_tests')
	subdir ('tests')
endif


