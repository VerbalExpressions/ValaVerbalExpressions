libverbex_sources = [
	'libverbex.vala'
]


verbex_lib = library('verbex-1.0', libverbex_sources,
                      dependencies: deps,
                      vala_header: 'libverbex.h',
                      install: true,
                      install_dir: [true, true, true])

libverbex_dep = declare_dependency(link_with: verbex_lib,
                                 include_directories: include_directories('.'))

pkgconfig = import('pkgconfig')
pkgconfig.generate(requires: 'glib-2.0',
                   libraries: verbex_lib,
                   name: 'Verbal Expressions',
                   filebase: 'verbex-1.0',
                   description: 'Simple alternative to regular expressions',
                   version: meson.project_version(),
                   subdirs: 'verbex-1.0')
